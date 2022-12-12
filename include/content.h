#ifndef CONTENT_H
#define CONTENT_H

#include <primitive.h>

typedef struct {
    Primitive audio_track; // base audio object derived from struct
    int audio_track_bitrate;
} AudioTrack;

typedef struct {
    Primitive subtitle_track; // base subtitle object derived from struct
    char subtitle_track_name[20];
} SubtitleTrack;

#endif