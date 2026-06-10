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
