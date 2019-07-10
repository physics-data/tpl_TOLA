.PHONY: all
all: signal.h5

waves.h5: sources.csv stations.csv
	python3 oscillation.py $^ $@

offset.csv: ostrength.csv
	python3 sample.py $^ $@

signal.h5: waves.h5 offset.csv
	python3 superimpose.py $^ $@
