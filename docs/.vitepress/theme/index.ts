import DefaultTheme from 'vitepress/theme'
import { defineComponent, h, onMounted, ref } from 'vue'
import './style.css'

const HeroVideo = defineComponent({
  setup() {
    const reducedMotion = ref(true)

    onMounted(() => {
      reducedMotion.value = window.matchMedia('(prefers-reduced-motion: reduce)').matches
    })

    return () => h('video', {
      autoplay: !reducedMotion.value,
      loop: true,
      muted: true,
      playsinline: true,
      preload: 'metadata',
      poster: '/images/apps/nvim-screenshot.png',
      'aria-label':
        'Dotfiles demo showing terminal, Neovim, tabs, tmux-dev, and tmux-agent'
    }, [
      h('source', {
        src: '/images/demo/demo-dotfiles.mp4',
        type: 'video/mp4'
      }),
      'Your browser cannot play the terminal demonstration video.'
    ])
  }
})

export default {
  extends: DefaultTheme,
  Layout() {
    return h(DefaultTheme.Layout, null, {
      'home-hero-info-after': () =>
        h(
          'figure',
          { class: 'hero-demo' },
          h(HeroVideo)
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
