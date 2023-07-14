target: test

test: driver.o CTRL_SIZE.h
	gfortran -o $@ $<

%.o: %.F90
	gfortran -o $@ -c $<

# Useful phony targets

.PHONY: clean

clean:
	$(RM) test *.o *.gch *.msg *.mod *_db.f90 *_b.f90 *_d.f90 *~
