infile=PHONY
whisper_dir=.
language_code=sv
font_size=48
font_name=Ubuntu Bold

$(infile).english-subtitles.mp4 : $(infile) $(infile).16k.wav.srt
		ffmpeg -y -i $(infile) -vf "subtitles=$(infile).16k.wav.srt:force_style='Fontname=$(font_name),PrimaryColour=&HFFFFFF,Fontsize=$(font_size), SecondaryColour=&H000000, OutlineColour=&H000000'" $(infile).english-subtitles.mp4
$(infile).16k.wav.srt : $(infile).16k.wav
		$(whisper_dir)/main --max-len 89 --model $(whisper_dir)/models/ggml-large.bin -l $(language_code) -tr -osrt -f $(infile).16k.wav
$(infile).16k.wav : $(infile).wav
		sox $(infile).wav -r16k $(infile).16k.wav
$(infile).wav : $(infile)
		ffmpeg -i $(infile) $(infile).wav
.PHONY : clean
clean :
		rm $(infile).wav $(infile).16k.wav $(infile).16k.wav.srt \
		   $(infile).english-subtitles.mp4

