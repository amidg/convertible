#!/bin/bash

#ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i Season\ 01/\[Beatrice-Raws\]\ Darling\ in\ the\ Franxx\ 01\ \[BDRip\ 1920x1080\ x264\ FLAC\].mkv -i Season\ 01/RUS\ Sound/\[Beatrice-Raws\]\ Darling\ in\ the\ Franxx\ 01\ \[BDRip\ 1920x1080\ x264\ FLAC\].RUS.\[AniLibria\].mka -i Season\ 01/\[Beatrice-Raws\]\ Darling\ in\ the\ Franxx\ 01\ \[BDRip\ 1920x1080\ x264\ FLAC\].ENG.\[CR\].ass -map 0 -map 1 -map 2 -metadata:s:a:1 language=rus -metadata:s:s:2 language=eng -c:v hevc_nvenc Darling_In_the_Franxx_S01E01.mkv

# path variables
PATH_TO_MEDIA=/PlexMedia
PATH_TO_SPECIFIC_CONTENT=/PlexMedia/Anime

# variables
NVIDIA_AVAILABLE=false

echo "Welcome to automated FFMPEG transcoder!"
if [[ "$(inxi -G)" == *"NVIDIA"* ]]; then # check if Nvidia GPU is present
    NVIDIA_AVAILABLE=true
    echo "Nvidia GPU available: "
    INXI_INFO_GPU=$(inxi -G)
    echo "$INXI_INFO_GPU" | awk -F['Device-1''\n'] '{print $1}'
fi




