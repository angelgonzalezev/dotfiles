---
layout: home

hero:
  name: "Open source developer workspace"
  text: "Build faster with a terminal setup you can reproduce anywhere."
  tagline: "A ready-to-use and adaptable workspace that brings your terminal, editor, shell, and sessions together in one documented workflow."
  actions:
    - theme: brand
      text: Preview the installation
      link: /getting-started/install#preview-without-changes
    - theme: alt
      text: Explore the workflow
      link: /getting-started/overview
---

<section class="trust-strip" aria-label="Project guarantees">
  <div class="trust-strip__item"><span aria-hidden="true">&#10003;</span> Open source</div>
  <div class="trust-strip__item"><span aria-hidden="true">&#8984;</span> macOS and Linux</div>
  <div class="trust-strip__item"><span aria-hidden="true">&#8594;</span> Interactive installation</div>
  <div class="trust-strip__item"><span aria-hidden="true">&#8634;</span> Backups and restore</div>
</section>

<section class="install-cta product-section" aria-labelledby="install-cta-title">
  <div class="section-heading section-heading--centered">
    <p class="section-eyebrow">Start safely</p>
    <h2 id="install-cta-title">See what will change before installing</h2>
    <p>Run a dry preview from any directory. It checks your system and prints the complete installation plan without changing files, installing dependencies, or creating links.</p>
  </div>

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/angelgonzalezev/dotfiles/main/install.sh)" -- --dry-run
```

  <div class="inline-actions">
    <a class="text-link" href="/getting-started/install">Read the install guide <span aria-hidden="true">&#8594;</span></a>
    <a class="text-link" href="/guides/security">Review the security model <span aria-hidden="true">&#8594;</span></a>
  </div>
</section>

<section class="value-section product-section" aria-labelledby="value-title">
  <div class="section-heading">
    <p class="section-eyebrow">Why dotfiles</p>
    <h2 id="value-title">One workspace. A faster daily workflow.</h2>
    <p>Stop rebuilding your development environment from memory. Keep the setup, the commands, and the reasoning behind them together in one versioned workspace.</p>
  </div>
  <div class="value-grid">
    <article class="value-item">
      <span class="value-item__number" aria-hidden="true">01</span>
      <h3>Reproduce your setup</h3>
      <p>Turn a fresh machine into a familiar development environment through a repeatable, guided installation.</p>
    </article>
    <article class="value-item">
      <span class="value-item__number" aria-hidden="true">02</span>
      <h3>Stay in flow</h3>
      <p>Move between terminal, persistent sessions, project search, editing, and commands without rebuilding context.</p>
    </article>
    <article class="value-item">
      <span class="value-item__number" aria-hidden="true">03</span>
      <h3>Maintain it with confidence</h3>
      <p>Track configuration in Git, understand every shortcut, and restore previous files when a setup is not right for you.</p>
    </article>
  </div>
</section>

<section class="process-section" aria-labelledby="process-title">
  <div class="product-section">
    <div class="section-heading section-heading--centered section-heading--light">
      <p class="section-eyebrow">How it works</p>
      <h2 id="process-title">From a fresh terminal to a working environment</h2>
      <p>The installer makes each decision visible before it touches your configuration.</p>
    </div>
    <ol class="process-list">
      <li>
        <span class="process-list__marker">1</span>
        <div><h3>Preview</h3><p>Inspect dependencies, managed paths, conflicts, and the backup location with a dry run.</p></div>
      </li>
      <li>
        <span class="process-list__marker">2</span>
        <div><h3>Choose</h3><p>Select only the tools and configuration packages that belong in your workflow.</p></div>
      </li>
      <li>
        <span class="process-list__marker">3</span>
        <div><h3>Install</h3><p>Back up conflicting files, install dependencies, and create managed configuration links.</p></div>
      </li>
      <li>
        <span class="process-list__marker">4</span>
        <div><h3>Build</h3><p>Open a documented workspace and use consistent commands across daily projects.</p></div>
      </li>
    </ol>
    <div class="centered-action"><a class="button-link button-link--light" href="/getting-started/install">Follow the installation guide</a></div>
  </div>
</section>

<section class="tech-stack product-section" aria-labelledby="tech-stack-title">
  <div class="section-heading section-heading--centered">
    <p class="section-eyebrow">The workspace</p>
    <h2 id="tech-stack-title">Terminal-based development</h2>
    <p>Each tool owns one layer of the workflow, so the full setup stays understandable and every part can be adapted independently.</p>
  </div>
  <div class="tech-stack__grid">
    <a class="tech-card" href="/apps/wezterm">
      <div class="tech-card__logo"><img src="/images/logos/wezterm-logo.svg" alt="WezTerm logo" /></div>
      <div><h3>WezTerm</h3><p>The terminal window: tabs, panes, fonts, colors, native controls, and keyboard shortcuts.</p></div>
    </a>
    <a class="tech-card" href="/apps/zsh">
      <div class="tech-card__logo"><img src="/images/logos/zsh-logo.svg" alt="Zsh logo" /></div>
      <div><h3>Zsh</h3><p>The interactive shell: prompt, history, suggestions, aliases, and access to local commands.</p></div>
    </a>
    <a class="tech-card" href="/apps/tmux">
      <div class="tech-card__logo"><img src="/images/logos/tmux-logo.svg" alt="tmux logo" /></div>
      <div><h3>tmux</h3><p>The persistent workspace: reusable layouts, split panes, sessions, and live system context.</p></div>
    </a>
    <a class="tech-card" href="/apps/nvim">
      <div class="tech-card__logo"><img src="/images/logos/neovim-logo.png" alt="Neovim logo" /></div>
      <div><h3>Neovim</h3><p>The editor: keyboard-first navigation, file discovery, project search, buffers, and coding shortcuts.</p></div>
    </a>
  </div>
  <aside class="stow-callout">
    <div class="tech-card__logo"><img src="/images/logos/gnu-stow-logo.webp" alt="GNU Stow logo" /></div>
    <div><p class="section-eyebrow">Installation layer</p><h3>GNU Stow keeps the repository and your live configuration connected.</h3><p>It creates explicit symlinks to the selected files while leaving unrelated files in your home directory untouched.</p></div>
    <a class="text-link" href="/apps/stow">How Stow works <span aria-hidden="true">&#8594;</span></a>
  </aside>
</section>

<section class="workflow-section product-section" aria-labelledby="workflow-title">
  <div class="section-heading">
    <p class="section-eyebrow">Built for daily use</p>
    <h2 id="workflow-title">Designed around the way developers work</h2>
    <p>The value is not a collection of config files. It is the repeatable workflow those files create together.</p>
  </div>
  <div class="workflow-layout">
    <div class="workflow-list">
      <article><span aria-hidden="true">01</span><div><h3>Find code without breaking focus</h3><p>Search files and project text from Neovim with documented shortcuts.</p></div></article>
      <article><span aria-hidden="true">02</span><div><h3>Start the right workspace</h3><p>Open two-pane or four-pane layouts with <code>tmux-dev</code> and <code>tmux-agent</code>.</p></div></article>
      <article><span aria-hidden="true">03</span><div><h3>Keep work running</h3><p>Detach from tmux, close the terminal, and reconnect to the same session later.</p></div></article>
      <article><span aria-hidden="true">04</span><div><h3>Remember less</h3><p>Keep shortcuts, recovery steps, and custom commands searchable beside the configuration.</p></div></article>
    </div>
    <div class="workflow-summary">
      <p class="section-eyebrow">A typical session</p>
      <div class="workflow-command">WezTerm <span>&#8594;</span> Zsh <span>&#8594;</span> tmux <span>&#8594;</span> Neovim</div>
      <p>Every layer has a clear responsibility, from drawing the terminal window to keeping sessions alive and editing the project.</p>
      <a class="text-link" href="/getting-started/daily-workflow">Explore the daily workflow <span aria-hidden="true">&#8594;</span></a>
    </div>
  </div>
</section>

<section class="safety-section" aria-labelledby="safety-title">
  <div class="product-section safety-section__inner">
    <div class="safety-icon" aria-hidden="true">&#8634;</div>
    <div>
      <p class="section-eyebrow">Reversible by design</p>
      <h2 id="safety-title">Your existing configuration is protected</h2>
      <p>Before managed files are linked, conflicts are recorded and moved into a timestamped backup. Installation runs can be inspected, diagnosed, and restored through the same command-line interface.</p>
      <div class="safety-points">
        <span>Dry-run preview</span><span>Automatic conflict backups</span><span>Package-aware restore</span><span>Private local overrides</span>
      </div>
      <a class="button-link" href="/guides/backups-and-restore">Read the restore guide</a>
    </div>
  </div>
</section>

<section class="opensource-section product-section" aria-labelledby="opensource-title">
  <div class="opensource-section__copy">
    <p class="section-eyebrow">Open source and adaptable</p>
    <h2 id="opensource-title">Use it as-is. Make it work for you.</h2>
    <p>Created by Angel Gonzalez as a real development workspace, this project is published under the MIT License so you can inspect it, fork it, adapt the configuration, and share improvements.</p>
    <div class="inline-actions inline-actions--start">
      <a class="button-link button-link--dark" href="https://github.com/angelgonzalezev/dotfiles">View on GitHub</a>
      <a class="text-link" href="/reference/contributing">Contribute to the project <span aria-hidden="true">&#8594;</span></a>
    </div>
  </div>
  <div class="opensource-section__terminal" aria-label="Example contribution workflow">
    <div class="terminal-dots" aria-hidden="true"><span></span><span></span><span></span></div>
    <pre><code>$ bbldr dotfiles doctor
all checks passed
$ git checkout -b improve/workflow
$ npm run check
$ git push origin improve/workflow</code></pre>
  </div>
</section>

<section class="faq-section product-section" aria-labelledby="faq-title">
  <div class="section-heading section-heading--centered">
    <p class="section-eyebrow">Before you install</p>
    <h2 id="faq-title">Common questions</h2>
  </div>
  <div class="faq-list">
    <details><summary>Which systems are supported?</summary><p>macOS, Ubuntu, and Debian have automated dependency support. Other Linux distributions can use the configuration packages after installing dependencies manually.</p></details>
    <details><summary>What happens to my existing configuration?</summary><p>Only conflicting managed targets are moved into a timestamped backup. Unrelated files remain in place.</p></details>
    <details><summary>Do I have to install every tool?</summary><p>No. The interactive installer lets you choose the packages and relevant dependency groups you want.</p></details>
    <details><summary>Can I undo the configuration?</summary><p>Yes. Installation manifests record the affected targets so a selected run can be restored with <code>bbldr dotfiles restore</code>.</p></details>
    <details><summary>Can I customize the setup?</summary><p>Yes. Fork the repository for shared changes and use local override files for private or machine-specific values.</p></details>
  </div>
</section>

<section class="final-cta" aria-labelledby="final-cta-title">
  <p class="section-eyebrow">Start with confidence</p>
  <h2 id="final-cta-title">Ready for a cleaner terminal workflow?</h2>
  <p>Preview every change first, then choose the parts of the workspace that fit the way you build.</p>
  <div class="inline-actions">
    <a class="button-link button-link--light" href="/getting-started/install#preview-without-changes">Preview the installation</a>
    <a class="text-link text-link--light" href="/getting-started/overview">Read the documentation <span aria-hidden="true">&#8594;</span></a>
  </div>
</section>
