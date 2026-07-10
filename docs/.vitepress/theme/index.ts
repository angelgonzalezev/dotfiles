import DefaultTheme from 'vitepress/theme'
import { h } from 'vue'
import './style.css'

export default {
  extends: DefaultTheme,
  Layout() {
    return h(DefaultTheme.Layout, null, {
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
