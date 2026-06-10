# 🛠 AI Tooling — Development Automation Shenanigans

Small tools that make my life easier and my brain less annoyed.

---

## `spin()` — Project Scaffolder

I start new projects constantly, across macOS and WSL. Rather than recreating structure and config from scratch every time, `spin` handles it in one command.

```
spin
```

Prompts for a project name, description, kicker, and a few flags — then copies a template directory, injects the values into `portf.json`, and initializes a git repo. Every project starts with consistent structure and a portfolio config ready to go.

**Prompts:**
| Prompt | Default |
|---|---|
| Project name | — |
| Description | — |
| Kicker | `New great project` |
| Skip portfolio loop? | `false` |
| Include in portfolio showcase? | `false` |
| Featured card? | `false` (standard) |

Everything else — URL, tech stack, links, detailed description — is left as a placeholder to fill in manually when the project is ready.

### Setup

The script lives in your shell config (`.zshrc`, `.bashrc`, or equivalent) so it's globally available across machines.

Before using it, set `TEMPLATE_DIR` to the folder you want copied on each `spin`:

```bash
TEMPLATE_DIR="/path/to/your/template"
```

This should be a directory containing at minimum the `portf.json` template from this repo, plus anything else you want in every new project (AI instructions, `.gitignore`, whatever your setup needs).

---

## `portf.json` — Portfolio Config Template

The file `spin` injects values into. Lives in the root of every project and feeds the [portfolio automation](https://github.com/alxhdd/portfolio-autopilot).

Fields left blank by `spin` (url, tech, links, detail_description) are filled in manually once the project is ready to go public.

---

*Part of a wider automation setup — see [portfolio-autopilot](https://github.com/alxhdd/portfolio-autopilot) for how it all connects.*
