#!/bin/bash

# Function to display usage
usage() {
    echo "Script to bulk rename files in a directory"
    echo "Usage: $0 [-p prefix] [-n] directory"
    echo "-------------------------------------------"
    echo "Options:"
    echo "  -p prefix    Add a specific prefix to files (optional)"
    echo "  -n           Use numbered sequence for renaming"
    echo "-------------------------------------------"
    echo " Example: \`bulk-rename -p prefix ./directory\` will add \`prefix_\` to all the files in \`./directory\`"
    echo " Example: \`bulk-rename -n ./directory\` will rename files to 001.ext, 002.ext, etc."
    exit 1
}

# Parse command line options
prefix=""
use_numbers=false
while getopts "p:nh" opt; do
    case $opt in
        p) prefix="$OPTARG";;
        n) use_numbers=true;;
        h) usage;;
        ?) usage;;
    esac
done

# Shift the options out of the argument list
shift $((OPTIND-1))

# Check if directory is provided
if [ $# -ne 1 ]; then
    usage
fi

directory="$1"

# Check if directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist"
    exit 1
fi

# Change to the specified directory
cd "$directory" || exit 1

# Counter for numbered sequence
counter=1

# Process each file in the directory
for file in *; do
    # Skip if it's not a regular file
    [ -f "$file" ] || continue
    
    # Get file extension
    extension="${file##*.}"
    
    # Create new filename based on whether prefix is provided
    if [ -n "$prefix" ]; then
        # Use prefix
        new_name="${prefix}_${file}"
    elif [ "$use_numbers" = true ]; then
        # Use numbered sequence
        new_name="$(printf "%03d" $counter).${extension}"
        ((counter++))
    else
        # Skip if no renaming method is specified
        continue
    fi

    # Rename the file
    if [ "$file" != "$new_name" ]; then
        mv "$file" "$new_name"
        echo "Renamed: $file -> $new_name"
    fi
done
