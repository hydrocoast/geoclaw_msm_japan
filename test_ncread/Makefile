
FC = $(shell nc-config --fc) 
FFLAGS = $(shell nc-config --fflags)
FLIBS = $(shell nc-config --flibs)
EXE = xread
FILE = test_read.f90

.PHONY: exe all
all: exe

exe:
	$(FC) $(FILE) $(FFLAGS) $(FLIBS) -o $(EXE)
