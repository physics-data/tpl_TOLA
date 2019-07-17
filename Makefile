.PHONY: all
all: signal.h5 wave.png spectrum.png

waves.h5: data/sources.csv data/bandwidth.csv data/sample.csv
	python3 oscillation.py $^ $@

offset.csv: data/stations.csv data/ostrength.csv
	python3 random_offset.py $^ $@

ideal_signal.h5: waves.h5 data/sources.csv data/stations.csv data/speed_of_light.csv data/sample.csv
	python3 superposition.py $^ $@

wave.png: waves.h5 ideal_signal.h5 data/sample.csv
	python3 plot_wave.py $^ $@

spectrum.png: waves.h5 ideal_signal.h5 data/sample.csv
	python3 plot_wave_spectrum.py $^ $@

signal.h5: ideal_signal.h5 offset.csv data/sample.csv
	python3 superimpose.py $^ $@

# Delete partial files when the processes are killed.
.DELETE_ON_ERROR:
# Keep intermediate files around
.SECONDARY:
