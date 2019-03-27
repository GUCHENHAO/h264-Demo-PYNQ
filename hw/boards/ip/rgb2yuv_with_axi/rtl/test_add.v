`define DUMP_TIME    0
`define DUMP_FILE    "dump/wave_form.fsdb"
`timescale 1ns/100ps


module test_add;

	reg [2:0] a;
	reg [2:0] b;
	wire [3:0] c;
	
	add add0(
	.a(a),
	.b(b),
	.c(c)
	);

	initial begin
	a = 0;
	b = 0;
	#20;
	a = 1;
	b = 2;
	#20;
	a = 3;
	b = 5;
	#20
	$finish;
	end

	initial begin
      	#`DUMP_TIME ;
      	$fsdbDumpfile( `DUMP_FILE );
      	$fsdbDumpvars( test_add ) ;
      	#100 ;
    	end

endmodule

