#!/bin/bash

whisper_dir=$2
infile=$1
language_code=$3
# Get sound as WAV file
ffmpeg -i $infile $infile.wav
# Make sure it's 16K sample rate
sox $infile.wav -r16k $infile.16k.wav
# Whisper transcribes into English
$whisper_dir/main --model $whisper_dir/models/ggml-large.bin -l sv -tr -osrt -f $infile.16k.wav
# Make subtitle file where we can change font size
ffmpeg -i $infile.16k.wav.srt $infile.ass
# Change font size
perl -pi -e 's/Default,Arial,16/Default,Arial,48/' $infile.ass
# Make new video file with burnt-in subtitles
ffmpeg -i $infile -vf "ass=$infile.ass" $infile.english-subtitles.mp4

