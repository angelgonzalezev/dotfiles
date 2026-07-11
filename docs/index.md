---
layout: home

hero:
  name: "dotfiles"
  text: "A Developer Setup Designed to Help You Build Faster."
  actions:
    - theme: brand
      text: Install now
      link: /getting-started/install
    - theme: alt
      text: View GitHub
      link: https://github.com/angelgonzalezev/dotfiles
---

<section class="install-cta" aria-labelledby="install-cta-title">
  <div class="install-cta__content">
    <p class="install-cta__eyebrow">Install in one command</p>
  </div>

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/install.sh)"
```
</section>

<section class="tech-stack" aria-labelledby="tech-stack-title">
  <div class="tech-stack__header">
    <p class="tech-stack__eyebrow">What this workspace uses</p>
    <h2 id="tech-stack-title">Terminal-based development</h2>
  </div>
  <div class="tech-stack__grid">
    <a class="tech-card" href="/apps/nvim">
      <div class="tech-card__logo tech-card__logo--nvim">
        <img src="/images/logos/neovim-logo.png" alt="Neovim logo" />
      </div>
      <div>
        <h3>Neovim</h3>
        <p>Terminal editor configured for fast navigation, file search, grep, buffers, and daily coding shortcuts.</p>
      </div>
    </a>
    <a class="tech-card" href="/apps/wezterm">
      <div class="tech-card__logo tech-card__logo--wezterm">
        <img src="/images/logos/wezterm-logo.svg" alt="WezTerm logo" />
      </div>
      <div>
        <h3>WezTerm</h3>
        <p>GPU-powered terminal with custom tabs, panes, keyboard shortcuts, font settings, and visual styling.</p>
      </div>
    </a>
    <a class="tech-card" href="/apps/tmux">
      <div class="tech-card__logo tech-card__logo--tmux">
        <img src="/images/logos/tmux-logo.svg" alt="tmux logo" />
      </div>
      <div>
        <h3>tmux</h3>
        <p>Persistent terminal sessions, reusable layouts, split panes, and a custom status bar for development context.</p>
      </div>
    </a>
    <a class="tech-card" href="/apps/zsh">
      <div class="tech-card__logo tech-card__logo--zsh">
        <img src="/images/logos/zsh-logo.svg" alt="Zsh logo" />
      </div>
      <div>
        <h3>Zsh</h3>
        <p>Shell configuration with Oh My Zsh, prompt customization, command history, aliases, and local overrides.</p>
      </div>
    </a>
    <a class="tech-card" href="/apps/stow">
      <div class="tech-card__logo tech-card__logo--stow">
        <img src="/images/logos/gnu-stow-logo.webp" alt="GNU Stow logo" />
      </div>
      <div>
        <h3>GNU Stow</h3>
        <p>Symlink manager that installs the selected configuration packages into the correct locations in `$HOME`.</p>
      </div>
    </a>
  </div>
</section>

<section class="brand-contrast">
  <h2>Built to make development <span>faster</span>, cleaner, and easier to maintain.</h2>
  <div class="brand-contrast__grid">
    <article class="brand-card brand-card--pink">
      <h3>Without a dotfiles repo</h3>
      <ul>
        <li>You rebuild your terminal setup from memory.</li>
        <li>Shortcuts and commands get forgotten.</li>
        <li>Local configuration becomes hard to audit.</li>
      </ul>
    </article>
    <article class="brand-card brand-card--green">
      <h3>With this workspace</h3>
      <ul>
        <li>You install known configurations from one command.</li>
        <li>You keep commands documented next to the setup.</li>
        <li>You can fork, adapt, and contribute improvements.</li>
      </ul>
    </article>
  </div>
</section>
