# Welcome to [Slidev](https://github.com/slidevjs/slidev)!

To start the slide show from this directory:

- `pnpm install`
- `pnpm dev`
- visit <http://localhost:3030>

Each slide has its own Markdown file in [pages](./pages), from
`01-cover.md` to `16-learn-more.md`. Edit these files to update the slides;
the development server reloads automatically.

[slides.md](./slides.md) contains the deck configuration and an ordered list
of `src` imports. The first import shares the opening configuration block.
Page layouts, styles, scripts, and presenter notes stay with their pages.

To add a slide, create a Markdown file in `pages/` and add an import at the
desired position in `slides.md`:

```yaml
---
src: ./pages/17-my-slide.md
---
```

Display order follows the imports in `slides.md`, not the filenames. Files
in `pages/` are only included when imported.

Shared Vue components live in `components/`, and reusable code snippets live
in `snippets/`.

Learn more about Slidev at the [documentation](https://sli.dev/).
