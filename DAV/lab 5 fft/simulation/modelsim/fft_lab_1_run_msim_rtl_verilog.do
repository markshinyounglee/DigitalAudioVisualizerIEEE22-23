transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/MSI_Backup/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 5\ fft {D:/MSI_Backup/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 5 fft/fft_4point_tb.sv}
vlog -sv -work work +incdir+D:/MSI_Backup/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 5\ fft {D:/MSI_Backup/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 5 fft/fft_32bit.sv}
vlog -sv -work work +incdir+D:/MSI_Backup/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 5\ fft {D:/MSI_Backup/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 5 fft/butterfly.sv}
vlog -sv -work work +incdir+D:/MSI_Backup/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 5\ fft {D:/MSI_Backup/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 5 fft/fft_16bit.sv}

vlog -sv -work work +incdir+D:/MSI_Backup/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 5\ fft {D:/MSI_Backup/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 5 fft/fft_4point_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  fft_4point_tb

add wave *
view structure
view signals
run -all
