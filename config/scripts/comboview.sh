#!/usr/bin/env sh

first_tag=$(mmsg get all-tags | jq -r '.all_tags[].tags[].index' | rofi -dmenu -i -p "select first tag(determines layout):")

if [ -z "$first_tag" ]; then
    exit 0
fi

second_tag=$(mmsg get all-tags | jq -r '.all_tags[].tags[].index' | rofi -dmenu -i -p "select second tag")

if [ -z "$second_tag" ]; then
    exit 0
fi

mmsg dispatch comboview,"$first_tag"
mmsg dispatch comboview,"$second_tag"
