#!/bin/bash

#ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i Season\ 01/\[Beatrice-Raws\]\ Darling\ in\ the\ Franxx\ 01\ \[BDRip\ 1920x1080\ x264\ FLAC\].mkv -i Season\ 01/RUS\ Sound/\[Beatrice-Raws\]\ Darling\ in\ the\ Franxx\ 01\ \[BDRip\ 1920x1080\ x264\ FLAC\].RUS.\[AniLibria\].mka -i Season\ 01/\[Beatrice-Raws\]\ Darling\ in\ the\ Franxx\ 01\ \[BDRip\ 1920x1080\ x264\ FLAC\].ENG.\[CR\].ass -map 0 -map 1 -map 2 -metadata:s:a:1 language=rus -metadata:s:s:2 language=eng -c:v hevc_nvenc Darling_In_the_Franxx_S01E01.mkv

# path variables
PATH_TO_MEDIA=/PlexMedia
PATH_TO_SPECIFIC_CONTENT=$PATH_TO_MEDIA
PATH_TO_SUBS=$PATH_TO_SPECIFIC_CONTENT
PATH_TO_AUDIO=$PATH_TO_SPECIFIC_CONTENT

# variables
NVIDIA_AVAILABLE=false
DONE_PATH_TO_FOLDER=false

# constants
CUDA_REQUEST=' -hwaccel cuda -hwaccel_output_format cuda ' 

function select_folder {
    array=(./*)
    echo "There are ${#array[@]} folders in the current path";
    select dir in "${array[@]}"; do 
        echo "you selected ${dir}"; 
        echo "${dir}"
        cd "${dir}"
        break;
    done
}

echo "Welcome to automated FFMPEG script!"
if [[ "$(inxi -G)" == *"NVIDIA"* ]]; then # check if Nvidia GPU is present
    NVIDIA_AVAILABLE=true
    echo "Nvidia GPU available: "
    INXI_INFO_GPU=$(inxi -G)
    echo $INXI_INFO_GPU | grep -o -P '(?<=Device-1:).*(?=Device-2)'
fi

cd $PATH_TO_MEDIA
for (( ; ; )) {
    # infinite loop
    select_folder # select folder until  you reach the destination

    if [ -f ${file_with_extension}.mkv ] || [ -f ${file_with_extension}.avi ] || [ -f ${file_with_extension}.mp4 ] ; then
        DONE_PATH_TO_FOLDER=true
        break;
    fi
}

