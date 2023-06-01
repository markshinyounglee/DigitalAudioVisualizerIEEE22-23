transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/joing/OneDrive/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 2 {C:/Users/joing/OneDrive/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 2/sevenSegDisp.sv}
vlog -sv -work work +incdir+C:/Users/joing/OneDrive/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 2 {C:/Users/joing/OneDrive/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 2/sevenSegDigit.sv}
vlog -sv -work work +incdir+C:/Users/joing/OneDrive/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 2 {C:/Users/joing/OneDrive/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 2/labTwo.sv}
vlog -sv -work work +incdir+C:/Users/joing/OneDrive/Documents/_UCLA/2nd\ yr/1_fall\ quarter/Extracurriculars/DAV/lab\ 2 {C:/Users/joing/OneDrive/Documents/_UCLA/2nd yr/1_fall quarter/Extracurriculars/DAV/lab 2/miniALU.sv}

