# Repository Overview

This repository is a workspace for creating, refining layouts for, and exporting Slidev presentations. Nix provides a consistent development and export environment. The repository stores reusable examples and environment configuration; user presentations are kept locally under `outputs/`.

## Directories and Files

- `examples/`: Reusable presentation examples, layouts, and templates. Add future examples in separate named subdirectories.
- `examples/Initial/`: The initial Slidev demo, used to explore features, reference syntax, and start new presentations. `slides.md` is the entry point, `pages/` contains individual slides, `components/` contains Vue components, `snippets/` contains code snippets, and `public/` holds static assets.
- `outputs/`: The workspace for user presentations stored locally. It is excluded by the root `.gitignore` and must not be committed to Git.
- `flake.nix` / `flake.lock`: Nix environment configuration and dependency locking, providing Node.js, pnpm, and tools required for exports.
- `README.md`: User-facing project introduction, directory conventions, and instructions for running and exporting presentations.

## Presentation Output Convention

Each presentation must have its own directory at `outputs/{ppt_name}/`, replacing `{ppt_name}` with the actual presentation name. Keep all source files, assets, supporting documents, previews, and exports for that presentation within this directory. Do not scatter them across the repository root or `examples/`.

Use the following recommended structure, creating subdirectories as needed:

```text
outputs/{ppt_name}/
├── slides/                 # Slidev project and dependency configuration
│   ├── slides.md           # Presentation entry point and slide import order
│   ├── pages/              # Individual slides in Markdown
│   ├── components/         # Custom Vue components
│   ├── public/             # Static assets such as images and fonts
│   └── package.json
├── docs/                   # Outlines, reference materials, and production notes
└── exports/                # Generated PPTX, PDF, screenshots, and previews
```

Existing presentations may retain their internal structure, but all related files must remain under their respective `outputs/{ppt_name}/` directory. Keep presentations independent and avoid overwriting files belonging to other presentations.

## Working Conventions

- When creating a presentation, first consult a suitable example in `examples/`, then create or modify the project under `outputs/{ppt_name}/`. When copying examples, exclude dependencies and build artifacts such as `node_modules/` and `dist/`.
- Preserve `examples/Initial/` as the initial demo reference. Modify it only when the task explicitly concerns examples, templates, or their layouts. Do not place user presentation content there.
- For presentations using separate Markdown files per slide, edit content in `pages/` and maintain the import order in `slides.md`. Import order determines playback order.
- Run `nix develop` from the repository root, then enter the relevant Slidev project to install dependencies, preview, or export. Use the scripts defined in that project's `package.json`.
- Explicitly set export destinations to the corresponding `exports/` directory to avoid writing generated files into example directories.
- Do not add files under `outputs/` to Git or bypass ignore rules with `git add -f`. Limit commits to changes in examples, documentation, and reusable configuration.
