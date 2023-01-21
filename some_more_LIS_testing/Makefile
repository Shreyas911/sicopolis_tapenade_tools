all: test

ifndef F90C
F90C=gfortran
endif
ifndef CC
CC=gcc
endif

ifndef LISDIR
LISDIR=/home/shreyas/lis-1.4.43/installation
endif

ifdef LISDIR
LIBLIS=${LISDIR}/lib/liblis.so
LIBLISFLAG=-L${LISDIR}/lib -llis
LISFLAG=-DBUILD_LIS -I${LISDIR}/include/
endif

F90FLAGS= -O3 -g -mcmodel=medium -fno-range-check -ffpe-trap=invalid,zero 
CFLAGS= -O3 -g

CPPCMD_FILES = cat $< |  cpp ${LISFLAG} -traditional-cpp -P

test: sico_maths_m_tlm_cpp.o\
	driver.o\
	${LIBLIS} \
        ${LIB_NETCDF_F90}
	${F90C} ${F90FLAGS} -o $@ sico_maths_m_tlm_cpp.o driver.o ${LIBLISFLAG}

driver.o: sico_maths_m_tlm_cpp.o
%_cpp.f90: %.F90
	$(CPPCMD_FILES) > dummy.f90
	cat dummy.f90 > $@
	 
%.o : %.f90
	${F90C} ${LISFLAG} -I./ ${F90FLAGS} -o $@ -c $< 

clean: 
	rm -f *.o\ 
		*.mod*
.PHONY: clean
