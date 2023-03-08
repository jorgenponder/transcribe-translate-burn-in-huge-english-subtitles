# transcribe-then-burn-in-huge-english-subtitles

## Purpose

To automatically transcribe, translate and then burn huge  
English subtitles into Swedish and other foreign language videos

-Tested with ffmpeg version "4.4.2-0ubuntu0.22.04.1"
-Uses whisper.cpp for the transcription part.
-No error handling currently, feel free to fork or port!

##Example

```./burn-in-subs.sh swedish-video.mp4 /home/user/whisper-cpp sv```

Gives a video "swedish-video.mp4.english-subtitles.mp4"
with massive English subtitles burnt in

## Usage

```./burn-in-subs.sh [video file] [path-to-whisper.cpp] [video language code]```

-If video language isn't set, sv (Swedish) as language code
is assumed.
-If on top of that, whisper path isn't set,
current directory is assumed.

## Prerequisites

For debian-like distros below.

Install build-essential:

    sudo apt install build-essential

Download whisper.cpp from <https://github.com/ggerganov/whisper.cpp>

Compile it with make

Download the largest language model; it has Swedish and others in it

Make sure ffmpeg is installed:

    sudo apt install ffmpeg
    
Make sure sox is installed:

    sudo apt install sox
    
Make sure perl is installed (it probably already is)
