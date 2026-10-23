# Slidev Nix Development Environment

Provides the following tools based on the configuration in the [Slidev repository](https://github.com/slidevjs/slidev):

- Node.js 24, satisfying the upstream requirement of `>=22.12.0`.
- pnpm 12 from Nixpkgs, with the exact version pinned by `flake.lock`.
- Git, Python, pkg-config, a C/C++ compiler, and make for installing dependencies and building native modules. Linux also includes libsecret.
- Chromium and Chinese and Emoji fonts on Linux for PDF, PNG, and PPTX exports.

Supports x86_64 and ARM64 Linux, and Apple Silicon macOS. Dependencies are pinned in `flake.lock`.

## Enter the Environment

Install Nix with `nix-command` and `flakes` enabled, then run:

```sh
nix develop
node --version
pnpm --version
```

Entering the environment makes the tools available without automatically installing npm dependencies. The first run requires an internet connection to download Nix packages.

## Create a Presentation

After entering the environment from this directory, create a separate presentation project:

```sh
pnpm create slidev slides
cd slides
pnpm install
pnpm dev
```

Run `pnpm verify` for the full upstream validation sequence: build, type checking, linting, and unit tests.

## Export Slides

Install the Playwright JavaScript package in your presentation project:

```sh
pnpm add -D playwright-chromium
```

If pnpm reports `ERR_PNPM_IGNORED_BUILDS`, run `pnpm approve-builds` and allow the installation script for `playwright-chromium`. The upstream Slidev monorepo already includes this permission.

On Linux, the environment skips Playwright's browser download and uses Chromium from Nix. Pass the executable path explicitly when exporting. This environment provides `SLIDEV_CHROMIUM_PATH` for convenience:

```sh
pnpm exec slidev export --executable-path "$SLIDEV_CHROMIUM_PATH"
pnpm exec slidev export --format pptx --executable-path "$SLIDEV_CHROMIUM_PATH"
```

On macOS, let Playwright install its browser, then run `pnpm exec slidev export` directly.

On Linux, Cypress binary installation is also skipped to allow installing the upstream monorepo dependencies. This environment does not configure the Cypress E2E test runtime.
