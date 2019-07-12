.PHONY: all
all: signal.h5 wave.png spectrum.png

waves.h5: data/sources.csv data/stations.csv data/bandwidth.csv data/speed_of_light.csv data/sample.csv
	python3 oscillation.py $^ $@

offset.csv: data/ostrength.csv
	python3 random_offset.py $^ $@

wave.png: waves.h5 data/sample.csv
	python3 plot_wave.py $^ $@

spectrum.png: waves.h5 data/sample.csv
	python3 plot_wave_spectrum.py $^ $@

signal.h5: waves.h5 offset.csv
	python3 superimpose.py $^ $@
