##############################################################################
# PROJECT ENVIRONMENT
##############################################################################
# INCENTIA = /cygdrive/C/Software/Fuxi/ast_frontend
# AST_FRONTEND = /cygdrive/C/Software/Fuxi/ast_frontend
# ARCH_TYPE = H6
# USE_ACE_ARCH = 
# USE_RGRAPH_ARCH = C:/Software/Fuxi/andara/csdata/H6/rgraph/rgraph_arch
# USE_RGRAPH_DELAY = C:/Software/Fuxi/andara/csdata/H6/rgraph/rgraph_delay
# CSDATA = C:/Software/Fuxi/andara/csdata/H6
# CSLIBS = C:/Software/Fuxi/andara/cslibs/H6
# CSTOOLS = C:/Software/Fuxi/andara/cstools/devC
# CSTESTS = C:/Software/Fuxi/andara/cstests/devC
##############################################################################
# PROJECT VARIABLES
##############################################################################
set design           mipi_rx_pinf_tx_pinf_1080
set arch             griffin
set arch_ver         2.0
set speed_grade      -3
set pvt_factor       1.121
puts "ANDARA: ###############################"
puts "ANDARA: # Starting step: refiner_new "
puts "ANDARA: ###############################"
set step refiner_new
set inFile netlist/chip_assigner.v
set outFile netlist/chip_refiner.v
set outDbFile db/chip_refiner.db
set sdcFile [list "constraint/mipi_rx_pinf_tx_pinf_1080.sdc" "$env(CSTESTS)/lib/special.sdc" "$env(AGATE_ROOT)/bin/template/project/propagated_clock.sdc"]
set apafile outputs/mipi_rx_pinf_tx_pinf_1080.apx
set andara_ver 5.1.2
set dev_name H1D03N3W72C7
set apvfile outputs/mipi_rx_pinf_tx_pinf_1080.apv
set region_constraint_file region_file
set delayType max
set use_assigner 1
set refinerClockAdjust 200
set double_set_of_reg_ctrl_signal 1
set is_lut_first 0
set INSERT_LUT5_2_ROUTE_THROUGH 1
source "$env(CSTOOLS)/scripts/cswitch/refiner_new.tcl"
catch {exec reportProgress 8 100 3}
puts "ANDARA: ###############################"
puts "ANDARA: # Ending step: refiner_new "
puts "ANDARA: ###############################"