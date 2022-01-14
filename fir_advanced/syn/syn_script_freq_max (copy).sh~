analyze -f vhdl -lib WORK ../src/FD.vhd
analyze -f vhdl -lib WORK ../src/REG.vhd
analyze -f vhdl -lib WORK ../src/stage1.vhd
analyze -f vhdl -lib WORK ../src/stage2.vhd
analyze -f vhdl -lib WORK ../src/stage3.vhd
analyze -f vhdl -lib WORK ../src/my_fir.vhd

set power_preserve_rtl_hier_names true

elaborate my_fir -arch behavioural -lib WORK > ./elaborate_freq_max.txt

uniquify

link

#min period 
create_clock -name MY_CLK -period 1.41  clk

set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]

set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]

set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile
# -map_effort high -incremental_mapping

report_timing > ./report_timing_freq_max.txt

#with clk = 2.67 area = 3872.161999
report_area > ./report_area_freq_max.txt

ungroup -all -flatten

change_names -hierarchy -rules verilog

write_sdf ../netlist/myfir.sdf

write -f verilog -hierarchy -output ../netlist/myfir.v

write_sdc ../netlist/myfir.sdc

#quit

