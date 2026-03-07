#!/bin/sh

source "$CONFIG_DIR/colors.sh"

update_icons() {
  local sid=$1

  apps=$(aerospace list-windows --workspace "$sid" \
    | awk -F '|' '{gsub(/^ *| *$/, "", $2); if (!seen[$2]++) print $2}' \
    | sort)

  icon_strip=""
  if [ "${apps}" != "" ]; then
    while read -r app; do
      icon_strip+=" $($CONFIG_DIR/plugins/icons.sh "$app")"
    done <<<"${apps}"
  fi

  sketchybar --animate sin 10 --set space.$sid label="$icon_strip"
}

# Hide the previously focused workspace
if [ -n "$PREV_WORKSPACE" ]; then
  sketchybar --set space.$PREV_WORKSPACE display=0
fi

# Show and highlight the newly focused workspace
if [ -n "$FOCUSED_WORKSPACE" ]; then
  m=$(aerospace list-workspaces --all --format "%{workspace} %{monitor-id}" 2>/dev/null \
    | awk -v ws="$FOCUSED_WORKSPACE" '$1 == ws {print $2}')
  [ -z "$m" ] && m=1

  sketchybar --set space.$FOCUSED_WORKSPACE \
    background.drawing=on \
    background.color=$ACCENT_COLOR \
    label.color=$ITEM_COLOR \
    icon.color=$ITEM_COLOR \
    display=$m

  update_icons "$FOCUSED_WORKSPACE"
fi