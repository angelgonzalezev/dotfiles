import DefaultTheme from 'vitepress/theme'
import { h } from 'vue'
import './style.css'

export default {
  extends: DefaultTheme,
  Layout() {
    return h(DefaultTheme.Layout, null, {
      'home-hero-info-after': () =>
        h(
          'figure',
          { class: 'hero-demo' },
          h('video', {
            autoplay: true,
            loop: true,
            muted: true,
            playsinline: true,
            preload: 'metadata',
            'aria-label':
              'Dotfiles demo showing terminal, Neovim, tabs, tmux-dev, and tmux-agent'
          }, [
            h('source', {
              src: '/images/demo/demo-dotfiles.mp4',
              type: 'video/mp4'
            })
          ])
        ),
      'layout-bottom': () =>
        h(
          'footer',
          { class: 'site-footer' },
          [
            'Made with ❤️ by ',
            h(
              'a',
              {
                href: 'https://www.youtube.com/@byangelgonzalez',
                target: '_blank',
                rel: 'noreferrer'
              },
              'Angel Gonzalez'
            )
          ]
        )
    })
  }
}
