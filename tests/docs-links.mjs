import { existsSync, readdirSync, readFileSync, statSync } from 'node:fs'
import { dirname, join, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..')
const docsRoot = join(root, 'docs')
const markdownFiles = []
const failures = []

function walk(directory) {
  for (const name of readdirSync(directory)) {
    const path = join(directory, name)
    if (path.includes('/.vitepress/cache') || path.includes('/.vitepress/dist')) continue
    if (statSync(path).isDirectory()) walk(path)
    else if (path.endsWith('.md')) markdownFiles.push(path)
  }
}

function markdownPage(file, target) {
  if (target.startsWith('/')) {
    const direct = join(docsRoot, `${target}.md`)
    const index = join(docsRoot, target, 'index.md')
    if (existsSync(direct)) return direct
    if (existsSync(index)) return index
    return null
  }
  const path = resolve(dirname(file), target)
  return existsSync(path) ? path : null
}

function anchors(file) {
  const seen = new Map()
  return new Set(
    [...readFileSync(file, 'utf8').matchAll(/^#{1,6}\s+(.+)$/gm)].map((match) => {
      const base = match[1]
        .replace(/<[^>]+>/g, '')
        .replace(/[`*_~]/g, '')
        .toLowerCase()
        .trim()
        .replace(/[^\p{L}\p{N}\s-]/gu, '')
        .replace(/\s+/g, '-')
      const count = seen.get(base) ?? 0
      seen.set(base, count + 1)
      return count === 0 ? base : `${base}-${count}`
    })
  )
}

function targetExists(file, rawTarget) {
  const [withoutAnchor, anchor] = rawTarget.split('#')
  const target = withoutAnchor.split('?')[0]
  if (!target || /^(https?:|mailto:)/.test(target) || target.includes('<')) return true
  if (target.startsWith('/images/') || target.startsWith('/fonts/')) {
    return existsSync(join(docsRoot, 'public', target))
  }
  const page = markdownPage(file, target)
  if (!page) return false
  return !anchor || !page.endsWith('.md') || anchors(page).has(decodeURIComponent(anchor).toLowerCase())
}

walk(docsRoot)
markdownFiles.push(join(root, 'README.md'))

for (const file of markdownFiles) {
  const content = readFileSync(file, 'utf8')
  const targets = [
    ...content.matchAll(/\[[^\]]*\]\(([^)]+)\)/g),
    ...content.matchAll(/(?:src|href)=["']([^"']+)["']/g),
    ...content.matchAll(/^\s*link:\s+([^\s]+)\s*$/gm)
  ].map((match) => match[1])

  for (const target of targets) {
    if (!targetExists(file, target)) failures.push(`${file.replace(`${root}/`, '')}: ${target}`)
  }
}

const packages = readFileSync(join(root, 'config', 'packages.tsv'), 'utf8')
  .trim()
  .split('\n')
  .slice(1)
  .map((line) => line.split('\t'))

for (const [name, , , docs] of packages) {
  if (!existsSync(join(root, name))) failures.push(`config/packages.tsv: missing package directory ${name}`)
  if (!markdownPage(join(root, 'README.md'), docs)) failures.push(`config/packages.tsv: missing docs page ${docs}`)
}

const targetRows = readFileSync(join(root, 'config', 'targets.tsv'), 'utf8').trim().split('\n').slice(1)
for (const row of targetRows) {
  const [name, , source] = row.split('\t')
  if (!packages.some(([packageName]) => packageName === name)) failures.push(`config/targets.tsv: unknown package ${name}`)
  if (!existsSync(join(root, source))) failures.push(`config/targets.tsv: missing source ${source}`)
}

const legacyPatterns = [
  /bin\/bootstrap/,
  /bin\/dotfiles-(?:install|restore|doctor|status|sync|check)/,
  /\.config\/dotfiles-backups/
]
for (const file of markdownFiles) {
  const content = readFileSync(file, 'utf8')
  for (const pattern of legacyPatterns) {
    if (pattern.test(content)) failures.push(`${file.replace(`${root}/`, '')}: legacy command or path ${pattern}`)
  }
}

if (failures.length > 0) {
  console.error(`Broken internal documentation links:\n${failures.join('\n')}`)
  process.exit(1)
}

console.log(`documentation links ok (${markdownFiles.length} pages)`)
