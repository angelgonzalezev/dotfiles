import { defineConfig } from 'vitepress'
import { readFileSync } from 'node:fs'
import { dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), '../..')
const appItems = readFileSync(resolve(repoRoot, 'config/packages.tsv'), 'utf8')
  .trim()
  .split('\n')
  .slice(1)
  .map((line) => {
    const [, , , link, title] = line.split('\t')
    return { text: title, link }
  })

export default defineConfig({
  lang: 'en-US',
  title: 'dotfiles',
  description: 'An open source terminal workspace designed to make development faster, cleaner, and easier to maintain.',
  cleanUrls: true,
  appearance: false,
  sitemap: {
    hostname: 'https://dotfiles.becomebuilder.com'
  },
  head: [
    ['meta', { name: 'theme-color', content: '#050505' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:site_name', content: 'dotfiles' }],
    ['meta', { property: 'og:image', content: 'https://dotfiles.becomebuilder.com/images/apps/nvim-screenshot.png' }],
    ['meta', { name: 'twitter:card', content: 'summary_large_image' }],
    ['link', { rel: 'icon', href: 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><text y=".9em" font-size="90">👼</text></svg>' }]
  ],
  transformHead({ pageData }) {
    const pagePath = pageData.relativePath.replace(/(^|\/)index\.md$/, '$1').replace(/\.md$/, '')
    const canonical = `https://dotfiles.becomebuilder.com/${pagePath}`
    return [
      ['link', { rel: 'canonical', href: canonical }],
      ['meta', { property: 'og:url', content: canonical }],
      ['meta', { property: 'og:title', content: pageData.title || 'dotfiles' }],
      ['meta', { property: 'og:description', content: pageData.description || 'An open source terminal workspace for faster development.' }]
    ]
  },
  lastUpdated: true,
  themeConfig: {
    siteTitle: 'dotfiles',
    nav: [
      { text: 'Install', link: '/getting-started/install' },
      { text: 'Apps', link: '/apps/nvim' },
      { text: 'Reference', link: '/reference/commands' },
      {
        text: 'Links',
        items: [
          { text: 'GitHub', link: 'https://github.com/angelgonzalezev/dotfiles' },
          { text: 'X / Twitter', link: 'https://x.com/angelgonzaleh' },
          { text: 'YouTube', link: 'https://www.youtube.com/@byangelgonzalez' }
        ]
      }
    ],
    sidebar: [
      {
        text: 'Getting Started',
        items: [
          { text: 'Overview', link: '/getting-started/overview' },
          { text: 'Install', link: '/getting-started/install' },
          { text: 'Compatibility', link: '/getting-started/compatibility' },
          { text: 'Daily Workflow', link: '/getting-started/daily-workflow' },
          { text: 'FAQ', link: '/getting-started/faq' }
        ]
      },
      {
        text: 'Guides',
        items: [
          { text: 'Managing Configurations', link: '/guides/managing-configurations' },
          { text: 'Backups and Restore', link: '/guides/backups-and-restore' },
          { text: 'Security', link: '/guides/security' },
          { text: 'Troubleshooting', link: '/guides/troubleshooting' },
          { text: 'macOS Terminal Shortcut', link: '/guides/macos-terminal-shortcut' }
        ]
      },
      {
        text: 'Apps',
        items: [{ text: 'GNU Stow', link: '/apps/stow' }, ...appItems]
      },
      {
        text: 'Reference',
        items: [
          { text: 'Repository Layout', link: '/reference/repository-layout' },
          { text: 'bbldr Architecture', link: '/reference/bbldr-architecture' },
          { text: 'Commands', link: '/reference/commands' },
          { text: 'Licensing And Assets', link: '/reference/licensing' },
          { text: 'Contributing', link: '/reference/contributing' }
        ]
      }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/angelgonzalezev/dotfiles' },
      { icon: 'twitter', link: 'https://x.com/angelgonzaleh' },
      { icon: 'youtube', link: 'https://www.youtube.com/@byangelgonzalez' }
    ],
    search: {
      provider: 'local'
    },
    editLink: {
      pattern: 'https://github.com/angelgonzalezev/dotfiles/edit/main/docs/:path',
      text: 'Edit this page on GitHub'
    },
    lastUpdated: {
      text: 'Last updated'
    },
    outline: [2, 3]
  }
})
