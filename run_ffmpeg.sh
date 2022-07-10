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
CHOSEN_MEDIA_FORMAT=''
CHOSEN_SUBTITLE_FORMAT=''
CHOSEN_AUDIO_FORMAT=''
ADD_SUBTITLES=''
ADD_AUDIO_TRACK1=''
ADD_AUDIO_TRACK2=''

# constants
CUDA_REQUEST=' -hwaccel cuda -hwaccel_output_format cuda ' 
MKV_FORMAT='mkv'
MP4_FORMAT='mp4'
AVI_FORMAT='avi'

##################### FUNCTIONS ###############################
function select_folder {
    folders=(*)
    echo "There are ${#folders[@]} folders in the current path";
    folders+=("go back")
    select dir in "${folders[@]}"; do 
        echo "you selected ${dir}"; 
        if [ "$dir" = "go back" ]; then
            if [ "$(pwd)" != "$PATH_TO_MEDIA" ]; then
                cd ..
            fi
            break;
        else
            cd "${dir}" # later must use cd "${PATH_TO_SPECIFIC_CONTENT}"
            PATH_TO_SPECIFIC_CONTENT=$PATH_TO_SPECIFIC_CONTENT'/'${dir}
            break;
        fi
    done
}

function check_if_extension_exists {
    filelist=(`find ./ -maxdepth 1 -name "*.$1"`)
    if [ ${#filelist[@]} -gt 0 ]; then 
        true 
    else 
        false
    fi
}

function select_file_in_folder {
    shopt -s extglob
    filelist=( ./*.$1 )
    echo "There are ${#filelist[@]} media files in the folder";
    filelist+=("all files")
    select file in "${filelist[@]}"; do
        echo "you selected ${file}"
        break;
    done
}

function select_from_two {
    options="$1"
    options+=("$2")
    select option in "${options[@]}"; do
        break;
    done

    return "${option}"
}

################### MAIN PROGRAM ##############################
echo "Welcome to automated FFMPEG script!"
if [[ "$(inxi -G)" == *"NVIDIA"* ]]; then # check if Nvidia GPU is present
    NVIDIA_AVAILABLE=true
    echo "Nvidia GPU available (NVENC autoselected): "
    INXI_INFO_GPU=$(inxi -G)
    echo $INXI_INFO_GPU | grep -o -P '(?<=Device-1:).*(?=Device-2)'
fi

cd $PATH_TO_MEDIA
for (( ; ; )) {
    # infinite loop
    select_folder # select folder until  you reach the destination
   
    if check_if_extension_exists $MKV_FORMAT; then
        DONE_PATH_TO_FOLDER=true
        CHOSEN_MEDIA_FORMAT=$MKV_FORMAT
        break;
    fi
}

if $DONE_PATH_TO_FOLDER; then
    echo "Let's choose $CHOSEN_MEDIA_FORMAT files to convert:"
    select_file_in_folder $CHOSEN_MEDIA_FORMAT

    read -p "Do you want to add subtitles? [Y/n]: " ADD_SUBTITLES  
    if [ "$ADD_SUBTITLES" = "y" ] || [ "$ADD_SUBTITLES" = "Y" ]; then
        echo "Let's choose subtitle format:"
        CHOSEN_SUBTITLE_FORMAT = $(select_from_two 'srt' 'ass')
        echo "$CHOSEN_SUBTITLE_FORMAT"
    fi
    
fi

