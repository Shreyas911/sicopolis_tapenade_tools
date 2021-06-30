import os


def reverse_mode(ind_var):

	############ Change working directory to sicopolis/src/subroutines/openad
	try:
	    # Change the current working Directory
	    os.chdir("./subroutines/openad/")
	    print("Directory changed to ", os.getcwd())
	except OSError:
	    print("Can't change the Current Working Directory")

	os.system('cp openad_m_adjoint_template.f90 openad_m.F90')

	new_file_lines = []

	with open('openad_m.F90') as f:
		file_lines = f.readlines()

	    ### Do stuff with the file in str form
		for line in file_lines:

			if line.startswith('use sico_variables_m_diff') == True:
				line = 'use sico_variables_m_diff, only : '+ind_var+'b, fcb\n'

			if line.startswith('open(unit = 1001') == True:
				line = 'open(unit = 1001, file = "'+ind_var+'_adjoint_limited.dat", status = "replace")\n'

			if line.startswith('open(unit = 1002') == True:
				line = 'open(unit = 1002, file = "'+ind_var+'_adjoint.dat", status = "replace")\n'

			if line.startswith('write (1001, *)') == True:
				line = 'write (1001, *) xi(i), eta(j), '+ind_var+'b(j,i)\n'

			if line.startswith('write (1002, *)') == True:
				line = 'write (1002, *) xi(i), eta(j), '+ind_var+'b(j,i)\n'

			new_file_lines.append(line)

	with open('openad_m.F90', "w") as f:
		f.write(''.join(new_file_lines))
	
	############ Change working directory to sicopolis/src/
	try:
	    # Change the current working Directory
	    os.chdir("../../")
	    print("Directory changed to ", os.getcwd())
	except OSError:
	    print("Can't change the Current Working Directory")

	new_file_lines = []

	with open('MakefileOpenAD') as f:
		file_lines = f.readlines()

		### Do stuff with the file in str form
		for line in file_lines:

			if line.startswith('	tapenade') == True:
				line = '	tapenade -b -ext "external_modules" -head "sicopolis_openad(fc)/('+ind_var+')" numCore_1.f90\n'
				print(line)

			line = line.replace("numCore_1_d","numCore_1_b")

			new_file_lines.append(line)

	with open('MakefileOpenAD', "w") as f:
		f.write(''.join(new_file_lines))

	new_file_lines = []
	with open('preprocessor.py') as f:
		file_lines = f.readlines()

		### Do stuff with the file in str form
		for line in file_lines:

			if line.startswith('call sico_end()') == True:
				line = '!call sico_end()'

			new_file_lines.append(line)

	with open('preprocessor.py', "w") as f:
		f.write(''.join(new_file_lines))


	os.system('make HEADER=v5_grl20_ss25ka -f MakefileOpenAD clean; make HEADER=v5_grl20_ss25ka -f MakefileOpenAD; ./adjoint')

def forward_mode(ind_var):

	############ Change working directory to sicopolis/src/subroutines/openad
	try:
	    # Change the current working Directory
	    os.chdir("./subroutines/openad/")
	    print("Directory changed to ", os.getcwd())
	except OSError:
	    print("Can't change the Current Working Directory")

	os.system('cp openad_m_forward_template.f90 openad_m.F90')


	new_file_lines = []

	with open('openad_m.F90') as f:
	    file_lines = f.readlines()

	    ### Do stuff with the file in str form
	    for line in file_lines:

		    if line.startswith('use sico_variables_m_diff') == True:
		    	line = 'use sico_variables_m_diff, only : '+ind_var+'d, fcd\n'

		    if line.startswith('open(unit = 1001') == True:
		    	line = 'open(unit = 1001, file = "'+ind_var+'_forward_limited.dat", status = "replace")\n'

		    if line.startswith('open(unit = 1002') == True:
		    	line = 'open(unit = 1002, file = "'+ind_var+'_forward.dat", status = "replace")\n'

		    if line.endswith('d(j,i) = 1.\n') == True:
		    	line = ind_var+'d(j,i) = 1.\n'

		    if line.endswith('d = 0.\n') == True:
		    	line = ind_var+'d = 0.\n'

		    new_file_lines.append(line)

	with open('openad_m.F90', "w") as f:
		f.write(''.join(new_file_lines))

	############ Change working directory to sicopolis/src/
	try:
	    # Change the current working Directory
	    os.chdir("../../")
	    print("Directory changed to ", os.getcwd())
	except OSError:
	    print("Can't change the Current Working Directory")

	
	new_file_lines = []
	with open('MakefileOpenAD') as f:
		file_lines = f.readlines()

		### Do stuff with the file in str form
		for line in file_lines:
			if line.startswith('	tapenade') == True:
				line = '	tapenade -d -ext "external_modules" -head "sicopolis_openad(fc)/('+ind_var+')" numCore_1.f90\n'
				print(line)

			line = line.replace("numCore_1_b","numCore_1_d")

			new_file_lines.append(line)

	with open('MakefileOpenAD', "w") as f:
		f.write(''.join(new_file_lines))

	new_file_lines = []
	with open('preprocessor.py') as f:
		file_lines = f.readlines()

		### Do stuff with the file in str form
		for line in file_lines:

			if line.startswith('!call sico_end()') == True:
				line = 'call sico_end()'

			new_file_lines.append(line)

	with open('preprocessor.py', "w") as f:
		f.write(''.join(new_file_lines))

	os.system('make HEADER=v5_grl20_ss25ka -f MakefileOpenAD clean; make HEADER=v5_grl20_ss25ka -f MakefileOpenAD; ./adjoint')

reverse_mode('h_c')