EXEC := executable
SRC  := $(wildcard *.f90)
OBJ  := $(patsubst %.f90, %.o, $(SRC))

F90 := gfortran
CC := gcc

$(EXEC): $(OBJ)
	$(F90) -o $@ $^

%.o: %.f90 
	$(F90) -c $<

driver.o : functions.o
.PHONY: clean

clean:
	$(RM) $(EXEC) *.o $(MOD) $(MSG) *.msg *.mod *_db.f90 *_b.f90 *_d.f90 *~

