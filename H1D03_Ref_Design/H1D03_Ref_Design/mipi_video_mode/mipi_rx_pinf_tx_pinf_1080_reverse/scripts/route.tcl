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
puts "ANDARA: # Starting step: route "
puts "ANDARA: ###############################"
set step route
set inDbFile       db/chip_pack.db
set inSdcFile      [list "constraint/mipi_rx_pinf_tx_pinf_1080.sdc" "$env(CSTESTS)/lib/special.sdc" "$env(AGATE_ROOT)/bin/template/project/propagated_clock.sdc"]
set ntiming_paths  500
set routeLog       outputs/chip_rte.ro
set outDbFile      db/chip_rte.db
set outFile        netlist/chip_rte.v
set arafile        outputs/mipi_rx_pinf_tx_pinf_1080.ara
set dev_name       H1D03N3W72C7
set outSdcFile     ""
set routeSdf       "outputs/mipi_rx_pinf_tx_pinf_1080_router.sdf"
set apafile        outputs/mipi_rx_pinf_tx_pinf_1080.apa
set arvfile        outputs/mipi_rx_pinf_tx_pinf_1080.arv
set andara_ver     5.1.2
set delayType      max
cs_route_config MAX_ITER 95
cs_route_config  FUTURE_WEIGHT 95
set rgraph         "$env(USE_RGRAPH_ARCH)"
set rgraph_delay   "$env(USE_RGRAPH_DELAY)"
set double_set_of_reg_ctrl_signal 1
source "$env(CSTOOLS)/scripts/cswitch/route.tcl"
catch {exec reportProgress 16 100 3}
puts "ANDARA: ###############################"
puts "ANDARA: # Ending step: route "
puts "ANDARA: ###############################"