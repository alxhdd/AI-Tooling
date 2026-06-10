# 🛠 AI Tooling — Development Automation Shenanigans

This directory contains small internal tools I like to keep around to make my life easier. 

I frequently start new projects across macOS and WSL environments. Rather than manually recreating structure, configuration, and setup every time,
I built a lightweight Bash scaffolding utility that standardizes project initialization.

The goal is simple:

> Automate the boring stuff (with (or without) Python (hihi)

---

##  `spin()` — Project Scaffolder

### What it does

Running:

```
spin
```

Will:

1. Prompt for project details
2. Copy a predefined template + any tools or skills you use
3. Inject values into a JSON config file
4. Initialize a Git repository

This ensures every project starts with:

- My AI instructions,
- JSON for my automated portfolio
- Consisten structue

---

##  The Script

```bash
spin() {

    TEMPLATE_DIR=""  # ← point this at your template directory

    read -p "Project name: " name
    read -p "Project description: " desc
    read -p "Kicker (default: 'New great project'): " kicker
    read -p "Skip portfolio loop? (y/N): " skip
    read -p "Include in portfolio showcase? (y/N): " portfolio
    read -p "Featured card? (y/N): " featured

    if [ -z "$name" ]; then
        echo "Give the project a name."
        return 1
    fi

    if [ ! -d "$TEMPLATE_DIR" ]; then
        echo "Template directory not found."
        return 1
    fi

    # Apply defaults
    kicker="${kicker:-New great project}"
    skip_value="false";      [[ "$skip"      =~ ^[Yy]$ ]] && skip_value="true"
    portfolio_value="false"; [[ "$portfolio" =~ ^[Yy]$ ]] && portfolio_value="true"
    card_type="standard";    [[ "$featured"  =~ ^[Yy]$ ]] && card_type="featured"

    mkdir "$name" || return 1
    cp -R "$TEMPLATE_DIR"/. "$name"/ || return 1
    cd "$name" || return 1

    # macOS and Linux have different sed -i behaviour
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s|{{public_name}}|$name|g"           portf.json
        sed -i '' "s|{{kicker}}|$kicker|g"              portf.json
        sed -i '' "s|{{description}}|$desc|g"           portf.json
        sed -i '' "s|{{skip}}|$skip_value|g"            portf.json
        sed -i '' "s|{{portfolio}}|$portfolio_value|g"  portf.json
        sed -i '' "s|{{card_type}}|$card_type|g"        portf.json
    else
        sed -i "s|{{public_name}}|$name|g"              portf.json
        sed -i "s|{{kicker}}|$kicker|g"                 portf.json
        sed -i "s|{{description}}|$desc|g"              portf.json
        sed -i "s|{{skip}}|$skip_value|g"               portf.json
        sed -i "s|{{portfolio}}|$portfolio_value|g"     portf.json
        sed -i "s|{{card_type}}|$card_type|g"           portf.json
    fi

    git init

    echo "Project '$name' created. Git initialised."
}
```

---

## Design Philosophy

I aim to make my life easier and as error proof as I can. 

By automating scaffolding:

- I reduce context switching
- I enforce structural consistency
- I actually keep my portfolio automated
- I make experimentation cheaper

This script lives in my shell configuration making it globally available across machines.

---

