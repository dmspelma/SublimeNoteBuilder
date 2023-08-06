#!/bin/bash

default_path=$HOME
path_extension='Documents/Notes'
formatted_date=$(date +%m/%d/%Y)
platform='Trello'

while getopts ":d :j" opt; do
  case ${opt} in
    d )
      path_extension='Documents/Notes/DevNotes'
      ;;
    j )
      platform='JIRA'
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))
full_path="$default_path/$path_extension"
echo "Building a new note for you under $full_path"

if [ ! -d "$full_path" ]; then
	# -p ensure the directory and parent directories are created if they don't exist
  mkdir -p "$full_path"
  echo "Created directory $full_path"
fi

# For given name, substitutes all spaces with _ and appends `.notes` file extension
function note_name(){
	tmp=$1
  tmp="${tmp// /_}" # Replace spaces with underscores
	echo "$tmp.notes"
}

function filter_text(){
	local=$1
	filtered="${local//[^a-zA-Z0-9_ .-]/}" # Removes all symbols except spaces, underscores, and hyphens
	echo "$filtered"
}

read -p "$platform Card Title: " card_title
read -p "$platform Link: " card_link
note_file="$full_path/$(note_name "$(filter_text "$card_title")")"
echo "Note is saved here: $note_file"

# Create file and fill with template. Will not create file if one exists
if [ -e "${note_file}" ]; then # -e flag checks if file exists in given path
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
