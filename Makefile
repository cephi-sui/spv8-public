# Compilers
CC = gcc
CXX = g++
# - Debug
#CFLAGS += -g
# CFLAGS += -fsanitize=address # Check invalid memory access
# - General
CFLAGS += -O2 # Should be disabled when debug
CFLAGS += -std=c++17 -Wall -Wextra -lm
#CFLAGS += -march=skylake-avx512 -fopenmp
CFLAGS += -march=native -fopenmp
#CFLAGS += -static
# - MKL
#CFLAGS += -ltbb -lmkl_core -lmkl_tbb_thread -lmkl_intel_lp64
#CFLAGS += -lmkl_core -lmkl_gnu_thread -lmkl_intel_lp64
#CFLAGS += -lmkl_core -lmkl_intel_thread -liomp5 -lmkl_intel_lp64
LDLIBS = -lmkl_rt -lmkl_core -lmkl_intel_thread -liomp5 -lmkl_intel_lp64
LDLIBS += -I/usr/include/mkl
VPATH = src

all: bin bin/spmv_spv8 bin/spmv_mkl

bin:
	mkdir bin

bin/spmv_spv8 : spmv_spv8.cpp
	$(CXX) $(CFLAGS) $< -o $@ $(LDLIBS)

bin/spmv_mkl : spmv_mkl.cpp
	$(CXX) $(CFLAGS) $< -o $@ $(LDLIBS)

.PHONY : clean
clean :
	-rm bin/*

