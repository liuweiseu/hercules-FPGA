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
puts "ANDARA: # Starting step: fixer "
puts "ANDARA: ###############################"
set step fixer
set inFile netlist/chip_refiner.v
set outFile netlist/chip_fixer.v
set outDbFile db/chip_fixer.db
set sdcFile [list "constraint/mipi_rx_pinf_tx_pinf_1080.sdc" "$env(CSTESTS)/lib/special.sdc" "$env(AGATE_ROOT)/bin/template/project/propagated_clock.sdc"]
set placerMode wire_timing
set numberPaths 500
set delayType max
set outSdcFile { }
set fixerClockAdjust 200
catch {exec reportProgress 16 0 3}
source "$env(CSTOOLS)/scripts/cswitch/fixer.tcl"
catch {exec reportProgress 16 20 3}
puts "ANDARA: ###############################"
puts "ANDARA: # Ending step: fixer "
puts "ANDARA: ###############################"