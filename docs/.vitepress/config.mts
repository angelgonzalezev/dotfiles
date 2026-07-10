import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'dotfiles',
  description: 'My personal workspace for terminal setup, workflow, and documentation.',
  cleanUrls: true,
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
          { text: 'Daily Workflow', link: '/getting-started/daily-workflow' }
        ]
      },
      {
        text: 'Guides',
        items: [
          { text: 'Managing Configurations', link: '/guides/managing-configurations' },
          { text: 'Backups and Restore', link: '/guides/backups-and-restore' },
          { text: 'macOS Terminal Shortcut', link: '/guides/macos-terminal-shortcut' }
        ]
      },
      {
        text: 'Apps',
        items: [
          { text: 'Neovim', link: '/apps/nvim' },
          { text: 'WezTerm', link: '/apps/wezterm' },
          { text: 'tmux', link: '/apps/tmux' },
          { text: 'Zsh', link: '/apps/zsh' }
        ]
      },
      {
        text: 'Reference',
        items: [
          { text: 'Repository Layout', link: '/reference/repository-layout' },
          { text: 'Commands', link: '/reference/commands' },
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
    }
  }
})
