infile?=PHONY
whisper_dir?=.
language_code?=sv
font_size?=48
font_name?=Ubuntu Bold
_dummy := $(shell mkdir -p subtitleds)
# ffmpeg -i 111.mp3 -acodec pcm_s16le -ar 16000 out.wav
subtitleds/$(infile).english-subtitles.mp4 : $(infile) $(infile).wav.srt
		ffmpeg -y -i $(infile) -vf "subtitles=$(infile).wav.srt:force_style='Fontname=$(font_name),PrimaryColour=&HFFFFFF,Fontsize=$(font_size), SecondaryColour=&H000000, OutlineColour=&H000000'" subtitleds/$(infile).english-subtitles.mp4
$(infile).wav.srt : $(infile).wav
		$(whisper_dir)/main --max-len 89 --model $(whisper_dir)/models/ggml-large.bin -l $(language_code) -tr -osrt -f $(infile).wav
$(infile).wav : $(infile)
		ffmpeg -i $(infile) -acodec pcm_s16le -ar 16000 $(infile).wav
.PHONY : clean
clean :
		rm $(infile).wav $(infile).wav.srt \
		   $(infile).english-subtitles.mp4
