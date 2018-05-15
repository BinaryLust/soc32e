if [file exists "work"] {vdel -all}
vlib work
vlog -f compile_sv.f 
vsim -L altera_mf_ver -L lpm_ver i2c_tb -novopt -assertdebug
onbreak {resume}
log -r /*
do wave.do
run -all

