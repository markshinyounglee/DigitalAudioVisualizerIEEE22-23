transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/joing/OneDrive/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 3 {C:/Users/joing/OneDrive/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 3/clockDivider.sv}
vlog -sv -work work +incdir+C:/Users/joing/OneDrive/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 3 {C:/Users/joing/OneDrive/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 3/tb_clockDivider.sv}

