module tb_fir();

   wire clk_i;
   wire rst_n_i;
   wire [7:0] Din_i;
   wire vin_i;
   wire [7:0] H0_i;
   wire [7:0] H1_i;
   wire [7:0] H2_i;
   wire [7:0] H3_i;
   wire [7:0] H4_i;
   wire [7:0] H5_i;
   wire [7:0] H6_i;
   wire [7:0] H7_i;
   wire [7:0] H8_i;
   wire [7:0] Dout_i;
   wire Vout_i;
   wire END_SIM_i;

   clk_gen CG(.END_SIM(END_SIM_i),
  	      .clk(clk_i),
	      .rst_n(rst_n_i));

   data_maker SM(.clk(clk_i),
	         .rst_n(rst_n_i),
		 .Vout(vin_i),
		 .Dout(Din_i),
		 .H0(H0_i),
		 .H1(H1_i),
		 .H2(H2_i),
		 .H3(H3_i),
		 .H4(H4_i),
		 .H5(H5_i),
		 .H6(H6_i),
		 .H7(H7_i),
		 .H8(H8_i),
		 .END_SIM(END_SIM_i));

   myfir UUT(.clk(clk_i),
	     .rst_n(rst_n_i),
	     .Din(Din_i),
             .vin(vin_i),
	     .H0(H0_i),
	     .H1(H1_i),
	     .H2(H2_i),
	     .H3(H3_i),
		 .H4(H4_i),
		 .H5(H5_i),
		 .H6(H6_i),
		 .H7(H7_i),
		 .H8(H8_i),
             .Dout(Dout_i),
             .Vout(Vout_i));

   data_sink DS(.clk(clk_i),
		.rst_n(rst_n_i),
		.vin(Vout_i),
		.Din(Dout_i));   
endmodule

		   
