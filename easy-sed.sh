#!/bin/bash

# Directory Prompt
echo "Is the target file(s) in the current working directory?"
echo -n "y/n: "
read dir_answer
if [[ "$dir_answer" = "n" ]]; then
	echo "Please enter the location of the target file."
	echo "Example: If the target file is /opt/file.txt, enter /opt/"
	echo -n "What is the location? "
	read -r target_dir
fi

# Filename Prompt
echo "Please enter the name of the target file."
echo "To target all files in the dir, enter *"
echo -n "What is the name of the target file? "
read target_file

# Build $final_path var
if [[ "$dir_answer" = "n" ]]; then
	final_path="$target_dir$target_file"
else
	final_path="$target_file"
fi

# Pattern Prompt
echo -n "What is the pattern you would like to replace? "
read -r old_value
echo -n "What is the desired replacement pattern? "
read -r new_value

# Validate Changes
old_cat=$(cat $final_path | grep $old_value)
time_label=$(date +%H-%M-%S)
echo $old_cat > $time_label.txt
sed -i "s/$old_value/$new_value/" $time_label.txt
new_cat=$(cat $time_label.txt)
echo "In $final_path"
echo $old_cat
echo "will become..."
echo $new_cat
echo -n "Continue? y/n: "
read validation

# Execute Changes
if [[ "$validation" = "y" ]]; then
	sed -i "s/$old_value/$new_value/" $final_path
fi

# Remove Temp Files
rm $time_label.txt

echo "END"
