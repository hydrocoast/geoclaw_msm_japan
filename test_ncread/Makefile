
FC = $(shell nc-config --fc) 
FFLAGS = $(shell nc-config --fflags)
FLIBS = $(shell nc-config --flibs)
EXE = xread_msmnc
FILE = test_read.f90

.PHONY: exe all clean
all: exe

exe:
	$(FC) $(FILE) $(FFLAGS) $(FLIBS) -o $(EXE)

clean:
	\rm $(EXE)