//-------------------------------------------------------------------
//
//  Filename      : rgb2ycrcb_top.v
//  Author        : Yu Lei
//                  Lu Yanheng
//  Created       : 2015-11-11
//  Description   : RGB to YCrCb
//
//-------------------------------------------------------------------

// Simple Test vectors (100% RGB Color Bars):
//   white:   R=255, G=255, B=255   |  Y=235, Cb=128, Cr=128
//   yellow:  R=255, G=255, B=  0   |  Y=210, Cb= 16, Cr=146
//   cyan:    R=  0, G=255, B=255   |  Y=170, Cb=166, Cr= 16
//   green:   R=  0, G=255, B=  0   |  Y=145, Cb= 54, Cr= 34
//   magenta: R=255, G=  0, B=255   |  Y=107, Cb=202, Cr=222
//   red:     R=255, G=  0, B=  0   |  Y= 82, Cb= 90, Cr=240
//   blue:    R=  0, G=  0, B=255   |  Y= 41, Cb=240, Cr=110
//   black:   R=  0, G=  0, B=  0   |  Y= 16, Cb=128, Cr=128
// 

`timescale 1ns / 10ps

module rgb2ycrcb_top
(
  Clock,
  Reset,
  Vi,
  Red,
  Green,
  Blue,
  Vo,
  Y,
  Cb,
  Cr
);

  parameter TOP_OUT_SIZE  =  8; // uncomment to get  8-bit input & output...

  input  Clock; 
  input  Reset; 
  input  Vi;
  input  [(TOP_OUT_SIZE - 1):0] Red; 
  input  [(TOP_OUT_SIZE - 1):0] Green; 
  input  [(TOP_OUT_SIZE - 1):0] Blue; 
  
  output reg [(TOP_OUT_SIZE - 1):0] Y; 
  output reg [(TOP_OUT_SIZE - 1):0] Cb; 
  output reg [(TOP_OUT_SIZE - 1):0] Cr; 
  output reg Vo;
  
  // Define internal signals
  reg [(TOP_OUT_SIZE - 1):0] R; 
  reg [(TOP_OUT_SIZE - 1):0] G; 
  reg [(TOP_OUT_SIZE - 1):0] B; 

  wire [(TOP_OUT_SIZE - 1):0] Y_sig; 
  wire [(TOP_OUT_SIZE - 1):0] Cb_sig; 
  wire [(TOP_OUT_SIZE - 1):0] Cr_sig; 
  
reg [4:0] v_tmp;  
always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        Vo <= 0; v_tmp <= 0;
    end
    else begin
        {Vo,v_tmp[2:0]} <= {v_tmp[2:0],Vi};
    end 
end 

  // Input registers (should be pushed into IOBs)
always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        R <= 0; G <= 0; B <= 0;
    end
    else begin
        R <= Red ; 
        G <= Green ; 
        B <= Blue ; 
    end 
end 

  // Output registers (should be pushed into IOBs)
always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        Y  <= 0; Cb <= 0; Cr <= 0;
    end
    else begin
        Y  <= Y_sig ; 
        Cb <= Cb_sig ; 
        Cr <= Cr_sig ; 
    end 
end 

// CSC instantiation
rgb2ycrcb  rgb2ycrcb_u0(
    .Clock  ( Clock  ),
    .Reset  ( Reset  ),
    .R      ( R      ),
    .G      ( G      ),
    .B      ( B      ),
    .Y      ( Y_sig  ),
    .Cb     ( Cb_sig ),
    .Cr     ( Cr_sig )
);


endmodule