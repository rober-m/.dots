
# /bin/bash
 
# Program to rename all PNG files into a numbered sequence
# Usage: bulk-rename.sh directory

# Provide the directory name as an argument
dir=$1

# Set the initial counter
i=1

# Loop through all files that end in .png
for file in "$dir"/*.png
do
    # Give the file a new name
    echo "Renaming $file to $i.png"
    mv "$file" "$dir/$i.png"

    # Increment the counter
    ((i=i+1))
done

# Exit the program
exit 0
