vcom ../tb/clk_gen.vhd
vcom ../tb/data_maker_new.vhd
vcom ../tb/data_sink.vhd
vcom ../src/REG.vhd
vcom ../src/FD.vhd
vcom ../src/stage1.vhd
vcom ../src/stage2.vhd
vcom ../src/stage3.vhd
vcom ../src/my_fir.vhd
vlog ../tb/tb_fir.v

vsim work.tb_fir
add wave *
run 1000ns
