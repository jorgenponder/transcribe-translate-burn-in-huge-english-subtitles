# Transcribe, translate, burn in huge english subtitles

## Purpose

* It can be tedious to do the 3-4 steps needed to subtitle a foreign language video or video snippet into English, and it also involves several different programs

* Sometimes it's quicker to read a transcript than listen to a radio show, podcast or video, to find what's interesting
 
This project automatically transcribes, translates and then burns huge English subtitles into Swedish and other foreign language videos in one step. And allows you to optionally edit the subtitles on the way, and rerun the build.

There is also the possibility to automatically make same language transcripts from video and mp3 files.

* Tested with ffmpeg version "4.4.2-0ubuntu0.22.04.1"
* Uses whisper.cpp for the transcription and translation parts.
* Two bonus makefiles for radio programs and videos with transcription but with no translation, see end of this Readme

## Usage

Please note, do not have any spaces in your file names! This project uses Gnu Make, and it cannot handle that. See <https://savannah.gnu.org/bugs/?712>. It also doesn't like brackets and probably a lot of other seedy characters.

```make infile='video file' whisper_dir='path-to-whisper.cpp' language_code='video language code' font_name='fontname'```

* If video language isn't set, ```sv``` (Swedish) as language code is assumed.
* If path to whisper isn't set, ```.``` (current directory) is assumed.
* If font_name isn't set, ```Ubuntu Bold``` is assumed. If that doesn't work it probably reverts to Arial.

You can probably put these in environment variables too, bot not tested enough yet.


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

```cd models; ./download-ggml-model.sh large```

Make sure ffmpeg is installed:

    sudo apt install ffmpeg
    
If you are going to use the mp3-to-transcript-in-original-language.makefile , you also need to install mpg123:

    sudo apt install mpg123

And sox:

    sudo apt install sox

## Workflow

The Makefile will not redo steps that are already up to date. So if you e.g. make a change to the subtitles file that is generated, the steps before that won't be rerun.

The steps that the program (i.e. the Makefile) performs are the following:

* Extract the audio as a 16kHz Wav file from the input video
* Run Whisper.cpp with flags set to generate a subtitle file in English
* Burn the subtitles into a new video file with the original video in it

```make clean infile='video file'``` will delete all created files, but not delete the input video file

## The bonus video-to-transcript-in-original-language.makefile

An extra makefile called ```video-to-transcript-in-original-language.makefile``` has been added. It writes out an .srt file based on what is said in the video, in the same language as the video language.

Usage:

    make -f video-to-transcript-in-original-language.makefile infile='mp3 file' whisper_dir='path-to-whisper.cpp' language_code='audio language code'

## The bonus mp3-to-transcript-in-original-language.makefile

Since there was a need to also transcribe radio programs or podcasts in the original language,  an extra makefile called ```mp3-to-transcript-in-original-language.makefile``` has been added. It writes out an .srt file based on what is said in the mp3 file,, in the same language as in the mp3 file.

Usage:

    make -f mp3-to-transcript-in-original-language.makefile infile='mp3 file' whisper_dir='path-to-whisper.cpp' language_code='audio language code'

### Font

The font can be changed but it does not like commas in the font name but it seems to work fine with commas omitted. One bold choice if you have it installed is ```DejaVu Sans Bold```.

### Formatting and presentation options

There is now a "label" field at the top left that can be used to put in e.g. a date. It will be rendered throughout the video.

There are some experimental formatting features for the subtitles, that may or may not work, depedning on what substation alpha features are available in ffmpeg in general and in the specific ffpmeg binary used, in particular.

## CPU Choices

Whisper.cpp has a benchmark feature. Currently for the large language model, the champs are the Apple M1 and M2 CPUs with about 5 seconds, After them the fastest Intel compatible sees to be AMD Ryzen 9 at around 10 seconds. Thereafter the fastest Intel seems to be around 20 seconds. My AMD Ryzen 5 laptop at around 90 seconds, an 7 year old Intel i3 NUC at around 450 seconds.
