infile?=PHONY
whisper_dir?=.
language_code?=sv
font_size?=48
font_name?=Ubuntu Bold
label=""
#colour format used by libass is: &HAABBGGRR
# (alpha, blue, green, red). 
# This is backwards from the standard web ordering, &HRRGGBBAA (red, blue, green).
#The alpha is inverted: 00 is fully opaque, and FF is fully transparent.

primary_color?=00FFFFFF
secondary_color?=00000000
outline_color?=00000000
back_color?=00000000
_dummy := $(shell mkdir -p subtitleds)
# ffmpeg -i 111.mp3 -acodec pcm_s16le -ar 16000 out.wav
subtitleds/$(infile).english-subtitles.mp4 : $(infile) $(infile).wav.srt
		ffmpeg -y -i $(infile) -vf "drawtext=font='Ubuntu Bold':text='$(label)':fontcolor=white:fontsize=36:box=1:boxcolor=black@0.5:boxborderw=5:x=10:y=10, subtitles=$(infile).wav.srt:force_style='Fontname=$(font_name),PrimaryColour=&H$(primary_color),Fontsize=$(font_size), SecondaryColour=&H$(secondary_color), borderstyle=3, outline=3, BackColour=&H$(back_color), OutlineColour=&H$(outline_color)'" subtitleds/$(infile).english-subtitles.mp4
$(infile).wav.srt : $(infile).wav
		$(whisper_dir)/main --max-len 89 --model $(whisper_dir)/models/ggml-large.bin -l $(language_code) -tr -osrt -f $(infile).wav
$(infile).wav : $(infile)
		ffmpeg -i $(infile) -acodec pcm_s16le -ar 16000 $(infile).wav
.PHONY : clean
clean :
		rm $(infile).wav $(infile).wav.srt \
		   $(infile).english-subtitles.mp4
