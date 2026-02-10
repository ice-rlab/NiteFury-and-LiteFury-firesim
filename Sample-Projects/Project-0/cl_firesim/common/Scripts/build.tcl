# Run synthesis & implementation
reset_run synth_1
launch_runs synth_1 -jobs 6
wait_on_run synth_1

# This is litefury hack to get pcie up and running. Set constraints and then redo synthesis.
set_property PROCESSING_ORDER NORMAL \
  [get_files -all -of_objects [get_ips Top_xdma_0_0] *PCIE_X0Y0.xdc]


reset_run synth_1
launch_runs synth_1 -jobs 6
wait_on_run synth_1

launch_runs impl_1 -jobs 6 -to_step write_bitstream
wait_on_run impl_1 
puts "Implementation done!"

# Make the output files for flash programming
source ../../../common/Scripts/make-mcs.tcl
