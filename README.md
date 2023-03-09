# transcribe-then-burn-in-huge-english-subtitles

## Purpose

To automatically transcribe, translate and then burn huge English subtitles into Swedish and other foreign language videos in one step. And allow you to optionally edit the subtitles on the way, and rerun the build.

* Tested with ffmpeg version "4.4.2-0ubuntu0.22.04.1"
* Uses whisper.cpp for the transcription part.
* No error handling currently, feel free to fork or port!

## Usage

```make infile='video file' whisper_dir='path-to-whisper.cpp' language_code='video language code'```

* If video language isn't set, ```sv``` (Swedish) as language code is assumed.
* If path to whisper isn't set, ```.``` (current directory) is assumed.

## Example

Make sure the Makefile of this project and e.g. a video file 'swedish-language-video.mp4' is in the same directory. Then:

```make infile='swedish-language-video.mp4' whisper_dir='path-to-whisper.cpp' language_code='sv'```

Gives a video "swedish-language-video.mp4.english-subtitles.mp4"
with massive English subtitles burnt in.

## Prerequisites

For Debian-like Linux distros below. It may work out of the box on MacOS, or with small changes. You could probably get it to run on Windows with some modifications. Tested on Ubuntu 22.04 LTS.

Install build-essential:

    sudo apt install build-essential

Download whisper.cpp from <https://github.com/ggerganov/whisper.cpp>

Compile it with make

Download the largest language model; it has Swedish and others in it

./download-ggml-model.sh large```

Make sure ffmpeg is installed:

    sudo apt install ffmpeg
    
Make sure sox is installed:

    sudo apt install sox
    
Make sure perl is installed (it probably already is)

## Workflow

The Makefile will not redo steps that are already up to date. So if you e.g. make a change to the subtitles file that is generated, the steps before that won't be rerun.

The steps that the program (i.e. the Makefile) performs are the following:

* Extract the audio as a Wav file from the input video
* Convert the Wav file to 16k sample rate, for whisper.cpp
* Run Whisper.cpp with flags set to generate a subtitle file in English
* Convert the .srt subtitles file to an .ass file where we can control font size and other things
* Increase the font size
* Burn the subtitles into a new video file with the original video in it


```make clean infile='video file'``` will delete all created files, but not delete the input video file
