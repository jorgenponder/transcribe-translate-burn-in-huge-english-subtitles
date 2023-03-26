infile=PHONY
whisper_dir=.
language_code=sv

$(infile).wav.srt : $(infile).wav
		$(whisper_dir)/main --model $(whisper_dir)/models/ggml-large.bin -l $(language_code) -osrt -f $(infile).wav
$(infile).wav : $(infile)
		ffmpeg -i $(infile) -acodec pcm_s16le -ar 16000 $(infile).wav
.PHONY : clean
clean :
		rm $(infile).wav $(infile).wav.srt
