#!/bin/bash

default_path=$HOME
path_extension='Documents/Notes'
echo "Building a new note for you under $default_path$path_extension"
formatted_date=$(date +%m/%d/%Y)

# For given name, substitutes all spaces with _ and appends `.notes` file extension
function note_name(){
	tmp=$*
	tmp="${tmp// /_}"
	echo "$tmp.notes"
}

read -p "Trello Card Title: " card_title
read -p "Trello Link: " card_link
note_file="$default_path/$path_extension/$(note_name $card_title)"
echo "Note is saved here: $note_file"

 # Create file and fill with template. Will not create file if one exists
if [ -e "${note_file[@]}" ]; then
  echo "File ${note_file} already exists!"
else
	cat > "${note_file}" <<EOF
Trello Card: $card_title
< $card_link >

Date: $formatted_date

Notes:





Tests:










EOF
fi


subl $note_file
