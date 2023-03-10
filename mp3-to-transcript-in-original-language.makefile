infile=PHONY
whisper_dir=.
language_code=sv

$(infile).16k.wav.srt : $(infile).16k.wav
		$(whisper_dir)/main --model $(whisper_dir)/models/ggml-large.bin -l $(language_code) -osrt -f $(infile).16k.wav
$(infile).16k.wav : $(infile).wav
		sox $(infile).wav -r16k $(infile).16k.wav
$(infile).wav : $(infile)
		mpg123 -w $(infile).wav $(infile)
.PHONY : clean
clean :
		rm $(infile).wav $(infile).16k.wav $(infile).16k.wav.srt