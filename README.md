# PPT Maker

A workspace for creating, refining, and exporting Slidev presentations with a Nix development environment.

## Structure

```text
.
├── AGENTS.md               # Repository guidance for AI assistants
├── flake.nix / flake.lock  # Nix environment and pinned dependencies
├── examples/               # Reusable examples and layouts
│   └── Initial/            # Initial Slidev demo
└── outputs/                # Local presentations, excluded from Git
    └── {ppt_name}/
        ├── slides/         # Slidev source, components, and assets
        ├── docs/           # Outlines and reference materials
        └── exports/        # PPTX, PDF, screenshots, and previews
```

Keep all files for each presentation under `outputs/{ppt_name}/`. Create the suggested subdirectories as needed.

## Getting Started

With Nix installed and `nix-command` and `flakes` enabled, enter the environment from the repository root:

```sh
nix develop
```

Preview the initial demo:

```sh
cd examples/Initial
pnpm install
pnpm dev
```

Or create a presentation from the repository root, replacing `my-presentation` with its name:

```sh
mkdir -p outputs/my-presentation
pnpm create slidev outputs/my-presentation/slides
cd outputs/my-presentation/slides
pnpm install
pnpm dev
```

You can also copy an example into the presentation's `slides/` directory, excluding `node_modules/` and `dist/`. For the initial demo, edit individual slides in `pages/` and maintain their import order in `slides.md`.

## Build and Export

Run these commands inside your presentation's `slides/` directory, within the Nix shell:

```sh
pnpm build
pnpm add -D playwright-chromium
mkdir -p ../exports
pnpm exec slidev export --output ../exports/my-presentation.pdf --executable-path "$SLIDEV_CHROMIUM_PATH"
pnpm exec slidev export --format pptx --output ../exports/my-presentation.pptx --executable-path "$SLIDEV_CHROMIUM_PATH"
```
