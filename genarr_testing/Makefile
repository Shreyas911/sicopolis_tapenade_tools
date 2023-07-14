target: test

test: driver.o CTRL_SIZE.h

%.o: %.F90
	gfortran -o $@ -c $<

# Useful phony targets

.PHONY: clean

clean:
	$(RM) $(EXEC) *.o $(MOD) $(MSG) *.msg *.mod *_db.f90 *_b.f90 *_d.f90 *~
