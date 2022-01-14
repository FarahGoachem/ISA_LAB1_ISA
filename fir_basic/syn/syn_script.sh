analyze -f vhdl -lib WORK ../src/packg.vhd
analyze -f vhdl -lib WORK ../src/FD.vhd
analyze -f vhdl -lib WORK ../src/reg.vhd
analyze -f vhdl -lib WORK ../src/adder.vhd
analyze -f vhdl -lib WORK ../src/multiplier.vhd
analyze -f vhdl -lib WORK ../src/vout_gen.vhd
analyze -f vhdl -lib WORK ../src/stage.vhd
analyze -f vhdl -lib WORK ../src/myfir.vhd

set power_preserve_rtl_hier_names true

elaborate myfir -arch struct -lib WORK > ./elaborate.txt

uniquify

link

#min period 2.67
create_clock -name MY_CLK -period 10.68  clk

set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]

set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]

set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile
# -map_effort high -incremental_mapping

report_timing > ./report_timing.txt

#with clk = 2.67 area = 3872.161999
report_area > ./report_area.txt

ungroup -all -flatten

change_names -hierarchy -rules verilog

write_sdf ../netlist/myfir.sdf

write -f verilog -hierarchy -output ../netlist/myfir.v

write_sdc ../netlist/myfir.sdc

#quit

