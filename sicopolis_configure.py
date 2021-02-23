import os

### Following SICOPOLIS configuration steps
### https://csdms.colorado.edu/mediawiki/images/SICOPOLIS_V5dev_Quick_Start.pdf

os.system('./copy_templates.sh')

### Change working directory to sicopolis/runs
try:
    # Change the current working Directory
    os.chdir("./runs")
    print("Directory changed to ", os.getcwd())
except OSError:
    print("Can't change the Current Working Directory")

### Access sico_configs.sh
new_file_lines = []
with open('sico_configs.sh') as f:
    file_lines = f.readlines()

    ### Do stuff with the file in str form
    for line in file_lines:
        if line.startswith('NETCDF_FLAG') == True:
            line = line.replace("false","true")
            print(line)
        elif line.startswith('LIS_FLAG') == True:
            line = line.replace("false","true")
            print(line)
        elif line.startswith('OPENMP_FLAG') == True:
            line = line.replace("false","true")
            print(line)
        elif line.startswith('LARGE_DATA_FLAG') == True:
            line = line.replace("false","true")
            print(line)
        elif line.startswith('   export NETCDFHOME') == True:
            line = line.replace("/opt/netcdf","/usr")
            print(line)
        elif line.startswith('   LISHOME') == True:
            line = line.replace("/opt/lis","/lis-1.3.33/installation")
            print(line)
        new_file_lines.append(line)

with open('sico_configs.sh', "w") as f:
    f.write(''.join(new_file_lines))

os.system('./sico.sh -m v5_grl20_ss25ka -f')
