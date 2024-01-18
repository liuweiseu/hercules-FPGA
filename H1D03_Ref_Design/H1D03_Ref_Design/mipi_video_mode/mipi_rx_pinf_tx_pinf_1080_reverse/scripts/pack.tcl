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
puts "ANDARA: # Starting step: pack "
puts "ANDARA: ###############################"
set step pack
set inFile netlist/chip_fixer.v
set dbFile db/chip_fixer.db
set outFile netlist/chip_pack.v
set outDbFile db/chip_pack.db
set double_set_of_reg_ctrl_signal 1
source "$env(CSTOOLS)/scripts/cswitch/pack.tcl"
catch {exec reportProgress 16 70 3}
puts "ANDARA: ###############################"
puts "ANDARA: # Ending step: pack "
puts "ANDARA: ###############################"