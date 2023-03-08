infile=PHONY
whisper_dir=.
language_code=sv
$(infile).english-subtitles.mp4 : $(infile) $(infile).ass
		ffmpeg -i $(infile) -vf "ass=$(infile).ass" $(infile).english-subtitles.mp4
$(infile).ass : $(infile).16k.wav.srt
		ffmpeg -i $(infile).16k.wav.srt $(infile).ass
		perl -pi -e 's/Default,Arial,16/Default,Arial,48/' $(infile).ass
$(infile).16k.wav.srt : $(infile).16k.wav
		$(whisper_dir)/main --model $(whisper_dir)/models/ggml-large.bin -l $(language_code) -tr -osrt -f $(infile).16k.wav
$(infile).16k.wav : $(infile).wav
		sox $(infile).wav -r16k $(infile).16k.wav
$(infile).wav : $(infile)
		ffmpeg -i $(infile) $(infile).wav
.PHONY : clean
clean :
		rm $(infile).wav $(infile).16k.wav $(infile).16k.wav.srt $(infile).ass\
		   $(infile).english-subtitles.mp4
