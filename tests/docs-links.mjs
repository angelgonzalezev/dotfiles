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

function targetExists(file, rawTarget) {
  const target = rawTarget.split('#')[0].split('?')[0]
  if (!target || /^(https?:|mailto:)/.test(target) || target.includes('<')) return true
  if (target.startsWith('/images/') || target.startsWith('/fonts/')) {
    return existsSync(join(docsRoot, 'public', target))
  }
  if (target.startsWith('/')) {
    return existsSync(join(docsRoot, `${target}.md`)) || existsSync(join(docsRoot, target, 'index.md'))
  }
  return existsSync(resolve(dirname(file), target))
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

if (failures.length > 0) {
  console.error(`Broken internal documentation links:\n${failures.join('\n')}`)
  process.exit(1)
}

console.log(`documentation links ok (${markdownFiles.length} pages)`)
