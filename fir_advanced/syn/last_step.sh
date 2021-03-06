read_verilog -netlist  ../netlist/myfir.v

read_saif -input ../saif/myfir_syn.saif -instance tb_fir/UUT -unit ns -scale 1

create_clock -name MY_CLK CLK
compile
report_power > ./report_power.txt
