#!/bin/bash

sketchybar --add event aerospace_workspace_change
sketchybar --add event aerospace_focus_change

sketchybar --add item aerospace_dummy left \
  --set aerospace_dummy display=0 \
  script="$PLUGIN_DIR/spaces.sh" \
  --subscribe aerospace_dummy aerospace_workspace_change aerospace_focus_change

FOCUSED=$(aerospace list-workspaces --focused)
[ -z "$FOCUSED" ] && FOCUSED="1"

for sid in 1 2 3 4 5; do
  m=$(aerospace list-workspaces --all --format "%{workspace} %{monitor-id}" 2>/dev/null \
    | awk -v ws="$sid" '$1 == ws {print $2}')
  [ -z "$m" ] && m=1

  sketchybar --add space space.$sid left \
    --set space.$sid space=$sid \
      icon=$sid \
      background.color=$TRANSPARENT \
      label.color=$ACCENT_COLOR \
      icon.color=$ACCENT_COLOR \
      script="" \
      display=$m \
      label.font="sketchybar-app-font:Regular:12.0" \
      icon.font="SF Pro:Semibold:12.0" \
      label.padding_right=0 \
      label.y_offset=-1 \
      click_script="$PLUGIN_DIR/space_click.sh $sid"

  # Build app icon strip (empty string if no apps, no dash)
  apps=$(aerospace list-windows --workspace "$sid" \
    | awk -F '|' '{gsub(/^ *| *$/, "", $2); if (!seen[$2]++) print $2}')

  icon_strip=""
  if [ "${apps}" != "" ]; then
    while read -r app; do
      icon_strip+=" $($PLUGIN_DIR/icons.sh "$app")"
    done <<<"${apps}"
  fi

  sketchybar --set space.$sid label="$icon_strip"

  # Only show the focused workspace
  if [ "$sid" = "$FOCUSED" ]; then
    sketchybar --set space.$sid background.drawing=on \
      background.color=$ACCENT_COLOR \
      label.color=$ITEM_COLOR \
      icon.color=$ITEM_COLOR \
      display=$m
  else
    sketchybar --set space.$sid display=0
  fi
done