import netCDF4 as nc
import numpy as np 
import matplotlib.pyplot as plt

ds = nc.Dataset('RRRAG4_Greenland_1993_2013_01_age_grid.nc')

x = ds.variables['x'][:][:,0]
y = ds.variables['y'][:][0,:]
age = ds.variables['age_norm'][:][-1,:,:]

plt.contourf(x,y,age.T)
plt.colorbar()
plt.show()
