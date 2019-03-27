//`timescale 1ns / 10ps

module rgb2ycrcb(Clock, Reset, R, G, B,
  Y, Cb, Cr );

input        Clock; 
input        Reset; 
input  [7:0] R; 
input  [7:0] G; 
input  [7:0] B; 
output [7:0] Y; 
output [7:0] Cb; 
output [7:0] Cr; 


// (  16 + 0.5 ) * 2 * 2^(13-1)
parameter CST_Offset_Y601 = (33<<12);
// ( 128 + 0.5 ) * 2 * 2^(11-1)
parameter CST_Offset_Cb  = (257<<10);  
// ( 128 + 0.5 ) * 2 * 2^(10-1)
parameter CST_Offset_Cr  = (257<<9);  


// Constant multipliers Y601, Cb and Cr components...
reg [20:0] Y_R_KCM,Y_G_KCM,Y_B_KCM;
reg [18:0] Cb_R_KCM,Cb_G_KCM,Cb_B_KCM; 
reg [17:0] Cr_R_KCM,Cr_G_KCM,Cr_B_KCM; 
//
reg [20:0] Y601_full;
reg [18:0] Cb_full; 
reg [17:0] Cr_full; 


//===================================================================
// Compute the Y component...
//===================================================================
// R*0.256 << 13 === R*2105 
wire [20:0] yr1,yr2;
assign yr1 = (R<<11)+(R<<3)+R;
assign yr2 = (R<<5)+(R<<4);
always @(posedge Clock or posedge Reset) begin
    if (Reset)
      Y_R_KCM <= 0; 
    else
      Y_R_KCM <= yr1+yr2;
end 

// G*0.504 << 13 === G*4129 
wire [20:0] yg0,yg2;
assign yg0 = G<<12;
assign yg2 = (G<<5)+G;
always @(posedge Clock or posedge Reset) begin
    if (Reset)
      Y_G_KCM <= 0; 
    else
      Y_G_KCM <= yg0+yg2; 
end 

// B*0.098 << 13 === B*803
wire [20:0] yb1,yb2;
assign yb1 = (B<<9)+(B<<8);
assign yb2 = (B<<5)+(B<<1)+B;
always @(posedge Clock or posedge Reset) begin
    if (Reset)
      Y_B_KCM <= 0; 
    else
      Y_B_KCM <= yb1+yb2; 
end 


// y = 0.257*r + 0.504*g + 0.098*b + 16;
wire [20:0] tmp_y0,tmp_y1;
assign tmp_y0 = Y_G_KCM + CST_Offset_Y601;
assign tmp_y1 = Y_R_KCM + Y_B_KCM;

always @(posedge Clock or posedge Reset) begin
    if (Reset)
        Y601_full <= 0;
    else
        Y601_full <= tmp_y0 + tmp_y1; 
end 

assign  Y  = Y601_full[20:13];  // Y>>13 
//===================================================================



//===================================================================
// Compute the Cb component...
//===================================================================
// R*0.148 << 11 === R*303
wire [18:0] cbr0,cbr2;
assign cbr0 = (R<<8)+(R<<5)+R;
assign cbr2 = (R<<3)+(R<<2)+(R<<1);
always @(posedge Clock or posedge Reset) begin
    if (Reset)
      Cb_R_KCM <= 0;
    else
      Cb_R_KCM <= cbr0+cbr2; 
end 

// G*0.291 << 11 === G*596
wire [18:0] cbg0,cbg1;
assign cbg0 = (G<<9)+(G<<2);
assign cbg1 = (G<<6)+(G<<4);
always @(posedge Clock or posedge Reset) begin
    if (Reset)
        Cb_G_KCM <= 0; 
    else
        Cb_G_KCM <= cbg0+cbg1; 
end 


// B*0.439 << 11 === B*899 
wire [18:0] cbb0,cbb1;
assign cbb0 = (B<<9)+(B<<8);
assign cbb1 = (B<<7)+(B<<1)+B;
always @(posedge Clock or posedge Reset) begin
    if (Reset)
        Cb_B_KCM <= 0; 
    else
        Cb_B_KCM <= cbb0+cbb1; 
end 


// u = -0.148*r - 0.291*g + 0.439*b + 128;
wire [18:0] tmp_cb0,tmp_cb1;
assign tmp_cb0 = Cb_B_KCM + CST_Offset_Cb;
assign tmp_cb1 = Cb_R_KCM + Cb_G_KCM;

always @(posedge Clock or posedge Reset) begin
    if (Reset)
        Cb_full <= 0;
    else
        Cb_full <= tmp_cb0 - tmp_cb1;
end 

assign Cb = Cb_full[18:11];    // Cb>>11
//===================================================================



//===================================================================
// Compute the Cr component...
//===================================================================
//R*0.439 << 10 === R*450
wire [17:0] crr0,crr1;
assign crr0 = (R<<8)+(R<<1);
assign crr1 = (R<<7)+(R<<6);
always @(posedge Clock or posedge Reset) begin
    if (Reset)
        Cr_R_KCM <= 0; 
    else
        Cr_R_KCM <= crr0+crr1; 
end 

//G*0.368 <<10 === G*377
wire [17:0] crg0,crg1;
assign crg0 = (G<<8)+(G<<3)+G;
assign crg1 = (G<<6)+(G<<5)+(G<<4);
always @(posedge Clock or posedge Reset) begin
    if (Reset)
        Cr_G_KCM <= 0; 
    else
        Cr_G_KCM <= crg0+crg1; 
end 

//B*0.071 <<10 === B*73
wire [17:0] crb1,crb2;
assign crb1 = B<<6;
assign crb2 = (B<<3)+B;
always @(posedge Clock or posedge Reset) begin
    if (Reset)
        Cr_B_KCM <= 0; 
    else
        Cr_B_KCM <= crb1+crb2; 
end 


// v = 0.439*r - 0.368*g - 0.071*b + 128;
wire [17:0] tmp_cr0,tmp_cr1;
assign tmp_cr0 = Cr_R_KCM + CST_Offset_Cr;
assign tmp_cr1 = Cr_G_KCM + Cr_B_KCM;

always @(posedge Clock or posedge Reset) begin
    if (Reset)
      Cr_full <= 0; 
    else
      Cr_full <= tmp_cr0 - tmp_cr1;
end 

assign Cr = Cr_full[17:10];    // Cr>>10
//===================================================================


endmodule
