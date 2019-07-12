.PHONY: all
all: signal.h5 wave.png spectrum.png

waves.h5: sources.csv stations.csv bandwidth.csv speed_of_light.csv sample.csv
	python3 oscillation.py $^ $@

offset.csv: ostrength.csv
	python3 random_offset.py $^ $@

wave.png: waves.h5 sample.csv
	python3 plot_wave.py $^ $@

spectrum.png: waves.h5 sample.csv
	python3 plot_wave_spectrum.py $^ $@

signal.h5: waves.h5 offset.csv
	python3 superimpose.py $^ $@
