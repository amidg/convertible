#ifndef PRIMITIVE_H
#define PRIMITIVE_H

/*
    primitive object can become anything:
    - video
        -> path_to_source = path to original video
        -> source_language = NaN
        -> source_index = used for queue'ing
    - audio
        -> path_to_source = path to audio file source
        -> source_language = audio language, passed to the FFMPEG cli
        -> source_index = index of the input, passed to the FFMPEG cli
    - subtitle 
        -> path_to_source = path to subtitle file source
        -> source_language = subtitle language, passed to the FFMPEG cli
        -> source_index = index of the input, passed to the FFMPEG cli
*/

typedef struct {
    char path_to_source[256];
    char source_language[10];
    int source_index;
} Primitive;

#endif