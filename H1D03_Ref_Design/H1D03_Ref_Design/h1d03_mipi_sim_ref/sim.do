
vlib work

vlog -sv -work work \
         +libext+.v\
         +define+SIM\
         -timescale "1ns/1ns" \
         -l rtl.log \
         -f vlog_file_list.f

vsim -sva -c -novopt +define+SIM -t 1ps +notimingchecks -l sim.log work.h6_mipi_sim_tb 

add wave -position insertpoint sim:/h6_mipi_sim_tb/*

run -all



