#!/bin/bash

# Check if the source directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <source-directory>"
  exit 1
fi

# Check if the target directory is provided
if [ -z "$2" ]; then
  echo "Usage: $0 <source-directory> <target-directory>"
  exit 1
fi

# Source directory
sourcedir="$1"
echo "Source Directory: $sourcedir"

# Target directory
targetdir="$2"
echo "Target Directory: $targetdir"

# Create the target directory if it doesn't exist
mkdir -p "$targetdir"

# List all files in the source directory

for name in "$sourcedir"/*.png; do
  base_name=$(basename "$name")
  if [[ "$base_name" =~ \.png$ ]]; then
    prefix=$(echo "${base_name%%_*}" | tr '[:lower:]' '[:upper:]')
    rest="${base_name#*_}"
    new_name="${prefix}_${rest,,}"
    
    cp "$name" "$targetdir/$new_name"
  fi
done

echo "end"