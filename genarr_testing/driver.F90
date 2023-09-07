#include "CTRL_SIZE.h"
#include "CTRL_VARS.h"

#define IMAX 84
#define JMAX 144

program driver

implicit none

character(STRLENGTH), dimension(NUM_CTRL) :: vars_aux
character(STRLENGTH), dimension(NUM_CTRL) :: weights_aux 
character(STRLENGTH), dimension(NUM_CTRL) :: bounds_aux
real(8),              dimension(NUM_CTRL) :: weights
integer                                   :: i
integer(4),           dimension(NUM_CTRL) :: xLow, xHigh, yLow, yHigh

vars_aux    = xx_genarr2d_vars
weights_aux = xx_genarr2d_weights
bounds_aux  = xx_genarr2d_bounds

do i=1, NUM_CTRL
        if (weights_aux(i) .NE. ' ') then

                read (unit=weights_aux(i),fmt=*) weights(i)
  
        end if
        
        if (weights_aux(i) .EQ. '1.0') then
        
                print *, "YAYAY!"

        end if

        if (bounds_aux(i) .NE. ' ') then

                read (unit=bounds_aux(i),fmt=*) xLow(i), xHigh(i), yLow(i), yHigh(i) 

        else

                xLow(i)  = 1
                xHigh(i) = IMAX+1
                yLow(i)  = 1
                yHigh(i) = JMAX+1 

        end if
end do

print *, weights
print *, xLow
print *, xHigh
print *, yLow
print *, yHigh

end program driver
