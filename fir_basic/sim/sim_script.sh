vcom ../src/packg.vhd
vcom ../tb/clk_gen.vhd
vcom ../tb/data_maker.vhd
vcom ../tb/data_sink.vhd
vcom ../src/adder.vhd
vcom ../src/multiplier.vhd
vcom ../src/reg.vhd
vcom ../src/FD.vhd
vcom ../src/vout_gen.vhd
vcom ../src/stage.vhd
vcom ../src/myfir.vhd
vlog ../tb/tb_fir.v

vsim -t 100ps ./work.tb_fir

view wave

add wave clk_i rst_n_i Din_i Dout_i vin_i Vout_i

run 500ns
