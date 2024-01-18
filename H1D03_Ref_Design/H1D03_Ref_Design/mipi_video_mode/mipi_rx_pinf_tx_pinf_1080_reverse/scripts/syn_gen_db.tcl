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
puts "ANDARA: # Starting step: syn_gen_db "
puts "ANDARA: ###############################"
set step syn_gen_db
set inSrcFile outputs/mipi_rx_pinf_tx_pinf_1080.amv
set outDbFile db/chip_syn.db
catch {exec reportProgress 8 0 3}
source "$env(CSTOOLS)/scripts/cswitch/syn_gen_db.tcl"
catch {exec reportProgress 8 15 3}
puts "ANDARA: ###############################"
puts "ANDARA: # Ending step: syn_gen_db "
puts "ANDARA: ###############################"