#/bin/bash


#This will recursively change all the images inside the folder to the below format

#Folder path where to reduce the images
initial_folder="/path/to/your/folder"

#Size of the image in px
image_size=224

# You can use "." to target the folder in which you are running the script for example
resized_folder_name="resized"

all_images=$(find -E $initial_folder -iregex ".*\.(jpg|gif|png|jpeg)")

while read -r image_full_path; do
    filename=$(basename "$image_full_path");
    source_folder=$(dirname "$image_full_path");
    destination_folder=$source_folder"/"$resized_folder_name"/";
    destination_full_path=$destination_folder$filename;

    if [ ! -z "$image_full_path" -a "$image_full_path" != " " ] &&
        # Do not resize images inside a folder that was already resized
        [ "$(basename "$source_folder")" != "$resized_folder_name" ]; then

        mkdir "$destination_folder";
        sips -Z "$image_size" "$image_full_path" --out "$destination_full_path";

    fi

done <<< "$all_images"
