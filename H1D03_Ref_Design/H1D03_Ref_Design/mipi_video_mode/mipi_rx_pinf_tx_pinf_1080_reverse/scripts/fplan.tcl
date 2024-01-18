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
puts "ANDARA: # Starting step: fplan "
puts "ANDARA: ###############################"
set step fplan
set inFile outputs/mipi_rx_pinf_tx_pinf_1080.amv
set outFile netlist/chip_fplan.v
set outDbFile db/chip_fplan.db
set outFplanFixedCellsFile scripts/fplan.fixed_cells.tcl
set outAocFile outputs/mipi_rx_pinf_tx_pinf_1080_pr.aoc
set inAocFile mipi_rx_pinf_tx_pinf_1080.aoc
source "$env(CSTOOLS)/scripts/cswitch/fplan.tcl"
catch {exec reportProgress 8 45 3}
puts "ANDARA: ###############################"
puts "ANDARA: # Ending step: fplan "
puts "ANDARA: ###############################"