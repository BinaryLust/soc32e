if [file exists "work"] {vdel -all}
vlib work
vlog -f compile_sv.f 
vsim -L altera_mf_ver -L lpm_ver -L fiftyfivenm_ver vgaDriver_tb -novopt -assertdebug
onbreak {resume}
#log -r /* # this logs all objects in the design
#log -out * # this logs all output ports in the current design unit
do wave.do
run -all
