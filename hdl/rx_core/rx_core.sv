`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//------------------
//-___           ___
//|   |         |   |
//|   |         |   |
//|   |         |   |
//|   |_________|   |
//|                 |
//|    H128B717     |
//|    _________    |
//|   |         |   |
//|   |         |   |
//|   |         |   |
//|___|         |___|
//-------------------
// Engineer: HosseinBehshti
//////////////////////////////////////////////////////////////////////////////////

module rx_core
  #(
     parameter NUMBER_OF_LINE = 8
   )
   (
     input clock,
     input clock_down4,
     input [16*NUMBER_OF_LINE-1:0] adc_data,
     input [16-1:0] ddc_phase_inc,
     input [16-1:0] demix_phase_inc,
     input [16-1:0] duc1_phase_inc,
     input [16-1:0] duc2_phase_inc,
     input [16-1:0] duc3_phase_inc,
     input [16-1:0] lpf1_gain,
     input [16-1:0] lpf2_gain,
     input [16-1:0] lpf3_gain,
     input [16-1:0] lpf4_gain,
     output logic [16*NUMBER_OF_LINE-1:0] dac1_data,
     output logic [16*NUMBER_OF_LINE-1:0] dac2_data,
     output logic [16*NUMBER_OF_LINE-1:0] dac3_data
   );

  genvar i;
  logic [15:0] adc_data_array[NUMBER_OF_LINE];
  logic [15:0] dac1_data_re_array[NUMBER_OF_LINE];
  logic [15:0] dac2_data_re_array[NUMBER_OF_LINE];
  logic [15:0] dac3_data_re_array[NUMBER_OF_LINE];

  generate
    for (i = 0; i < NUMBER_OF_LINE; i = i + 1)
    begin
      always @(posedge clock)
      begin
        adc_data_array[i] <= adc_data[16*(i+1)-1:16*i];
      end
    end
  endgenerate

  centeral_rx_dsp_core centeral_rx_dsp_core_inst (
                         .adc_data0(adc_data_array[0]),
                         .adc_data1(adc_data_array[1]),
                         .adc_data2(adc_data_array[2]),
                         .adc_data3(adc_data_array[3]),
                         .adc_data4(adc_data_array[4]),
                         .adc_data5(adc_data_array[5]),
                         .adc_data6(adc_data_array[6]),
                         .adc_data7(adc_data_array[7]),
                         .ddc_phase_inc(ddc_phase_inc),
                         .demix_phase_inc(demix_phase_inc),
                         .duc1_phase_inc(duc1_phase_inc),
                         .duc2_phase_inc(duc2_phase_inc),
                         .duc3_phase_inc(duc3_phase_inc),
                         .lpf1_gain(lpf1_gain),
                         .lpf2_gain(lpf2_gain),
                         .lpf3_gain(lpf3_gain),
                         .lpf4_gain(lpf4_gain),
                         .ddc_ss_clk(clock),
                         .duc_ss_clk(clock),
                         .demix_ss_clk(clock_down4),
                         .data_re1_duc1(dac1_data_re_array[0]),
                         .data_re2_duc1(dac1_data_re_array[1]),
                         .data_re3_duc1(dac1_data_re_array[2]),
                         .data_re4_duc1(dac1_data_re_array[3]),
                         .data_re5_duc1(dac1_data_re_array[4]),
                         .data_re6_duc1(dac1_data_re_array[5]),
                         .data_re7_duc1(dac1_data_re_array[6]),
                         .data_re8_duc1(dac1_data_re_array[7]),
                         .data_im1_duc1(),
                         .data_im2_duc1(),
                         .data_im3_duc1(),
                         .data_im4_duc1(),
                         .data_im5_duc1(),
                         .data_im6_duc1(),
                         .data_im7_duc1(),
                         .data_im8_duc1(),
                         .data_re1_duc2(dac2_data_re_array[0]),
                         .data_re2_duc2(dac2_data_re_array[1]),
                         .data_re3_duc2(dac2_data_re_array[2]),
                         .data_re4_duc2(dac2_data_re_array[3]),
                         .data_re5_duc2(dac2_data_re_array[4]),
                         .data_re6_duc2(dac2_data_re_array[5]),
                         .data_re7_duc2(dac2_data_re_array[6]),
                         .data_re8_duc2(dac2_data_re_array[7]),
                         .data_im1_duc2(),
                         .data_im2_duc2(),
                         .data_im3_duc2(),
                         .data_im4_duc2(),
                         .data_im5_duc2(),
                         .data_im6_duc2(),
                         .data_im7_duc2(),
                         .data_im8_duc2(),
                         .data_re1_duc3(dac3_data_re_array[0]),
                         .data_re2_duc3(dac3_data_re_array[1]),
                         .data_re3_duc3(dac3_data_re_array[2]),
                         .data_re4_duc3(dac3_data_re_array[3]),
                         .data_re5_duc3(dac3_data_re_array[4]),
                         .data_re6_duc3(dac3_data_re_array[5]),
                         .data_re7_duc3(dac3_data_re_array[6]),
                         .data_re8_duc3(dac3_data_re_array[7]),
                         .data_im1_duc3(),
                         .data_im2_duc3(),
                         .data_im3_duc3(),
                         .data_im4_duc3(),
                         .data_im5_duc3(),
                         .data_im6_duc3(),
                         .data_im7_duc3(),
                         .data_im8_duc3()
                       );

  generate
    for (i = 0; i < NUMBER_OF_LINE; i = i + 1)
    begin
      always @(posedge clock)
      begin
        dac1_data[16*(i+1)-1:16*i] <= dac1_data_re_array[i];
        dac2_data[16*(i+1)-1:16*i] <= dac2_data_re_array[i];
        dac3_data[16*(i+1)-1:16*i] <= dac3_data_re_array[i];
      end
    end
  endgenerate

endmodule
