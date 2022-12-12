#ifndef VIDEO_H
#define VIDEO_H

#include <content.h>

typedef struct {
    // original video object
    Primitive original_video;

    // finalized video objects
    char new_video_path[256];
    char new_video_format[10];
    char video_codec[10];
    int video_bitrate;
    char video_encoder[10];
    char video_encoder_pass[10];

    // additional content objects
    AudioTrack list_of_audio_tracks[10];
    SubtitleTrack list_of_sub_tracks[10];
} Video;

#endif