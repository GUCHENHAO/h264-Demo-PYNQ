// =============================================================================
//  Project Name: rgb2yuv_with_axi
//  File Name: rgb2yuv_with_gm.v
// =============================================================================
//  Revision History
//      v0.0.1 - Gu Chen Hao - 20171125
//      File created.
// =============================================================================

`define DUMP_TIME    0
`define DUMP_FILE    "dump/wave_form.fsdb"
`timescale 1ns/100ps

module test_rgb2yuv();

    parameter  AXI_DW                = 64          ,
               AXI_AW                = 32          ,
               AXI_MIDW              = 4           ,
               AXI_SIDW              = 8           ;//used to be 8

    parameter  AXI_WID               = 0           ,
               AXI_RID               = 0           ;

    reg                     clk           ;
    reg                     rstn          ;    

    reg                     gm_saccept    ;
    reg   [AXI_DW-1   : 0]  gm_sdata_0    ;
    // reg   [AXI_DW-1   : 0]  gm_sdata     ;
    reg   [3          : 0]  gm_sid        ;
    reg                     gm_slast      ;
    reg   [2          : 0]  gm_sresp      ;
    reg                     gm_svalid     ;

    wire  [AXI_AW-1   : 0]  gm_maddr      ;
    wire  [1          : 0]  gm_mburst     ;
    wire  [3          : 0]  gm_mcache     ;
    wire  [AXI_DW-1   : 0]  gm_mdata      ;
    wire  [3          : 0]  gm_mid        ;
    wire  [3          : 0]  gm_mlen       ;
    wire                    gm_mlock      ;
    wire  [2          : 0]  gm_mprot      ;
    wire                    gm_mread      ;
    wire                    gm_mready     ;
    wire  [2          : 0]  gm_msize      ;
    wire                    gm_mwrite     ;
    wire  [AXI_DW/8-1 : 0]  gm_mwstrb     ;

    wire  [AXI_DW-1   : 0]  gm_sdata      ;
    wire  [AXI_DW-1   : 0]  gm_mdata_1    ;

    reg [32:0] count;

    rgb2yuv_with_gm rgb2yuv_with_gm_0(
        // global
        .clk  (clk ),              
        .rstn (rstn),                   
        // gm
        .gm_maddr   (gm_maddr ),        
        .gm_mburst  (gm_mburst),        
        .gm_mcache  (gm_mcache),        
        .gm_mdata   (gm_mdata ),        
        .gm_mid     (gm_mid   ),        
        .gm_mlen    (gm_mlen  ),        
        .gm_mlock   (gm_mlock ),        
        .gm_mprot   (gm_mprot ),        
        .gm_mread   (gm_mread ),        
        .gm_mready  (gm_mready),        
        .gm_msize   (gm_msize ),        
        .gm_mwrite  (gm_mwrite),        
        .gm_mwstrb  (gm_mwstrb),        
        .gm_saccept (gm_saccept),        
        .gm_sdata   (gm_sdata ),        
        .gm_sid     (gm_sid   ),        
        .gm_slast   (gm_slast ),        
        .gm_sresp   (gm_sresp ),        
        .gm_svalid  (gm_svalid)       
    );

   integer fp;
   integer fp_0;
   integer tp_y;
    integer tp_y_0;
   integer tp_uv;
    integer tp_uv_0;

    initial begin
        clk = 1;
        rstn = 1;
        gm_sid = 1;
        gm_slast = 0;
       fp = $fopen("./infile_rgb32","rb");
       tp_y = $fopen("./dat_y");
       tp_uv = $fopen("./dat_uv");
        #10;
        rstn = 0;
        #10;
        rstn = 1;
        #10;
        rgb2yuv_with_gm_0.rgb2yuv_if_0.reg_col_len = 1920;
        rgb2yuv_with_gm_0.rgb2yuv_if_0.reg_row_len = 5;
        rgb2yuv_with_gm_0.rgb2yuv_if_0.reg_pix_len   = 1920*5;
        rgb2yuv_with_gm_0.rgb2yuv_if_0.reg_rgb_base = 32'h02000000;
        rgb2yuv_with_gm_0.rgb2yuv_if_0.reg_y_base   = 32'h04000000;
        #10;
        rgb2yuv_with_gm_0.rgb2yuv_if_0.reg_start = 1;
        $monitor("x:%03d  y:%03d\n\r",rgb2yuv_with_gm_0.rgb2yuv_if_0.index_x,rgb2yuv_with_gm_0.rgb2yuv_if_0.index_y);
        #10;
        rgb2yuv_with_gm_0.rgb2yuv_if_0.reg_start = 0;
        //wait(count == 4096);
        wait(rgb2yuv_with_gm_0.rgb2yuv_if_0.done);
        #100;
        $finish;
    end


    always #5 clk = ~clk;

    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            gm_saccept <= 0;
            count <= 0;
        end 
        else begin
            if (gm_mread || gm_mwrite) begin
                gm_saccept <= 1;
                count <= count + 1;
            end
            else begin
                gm_saccept <= 0;
                count <= count;
            end
        end
    end

    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            gm_svalid <= 0;
            gm_sresp <= 0;
        end 
        else begin
            if (gm_mread && gm_saccept) begin
                #1000;
                gm_svalid <= 1;
                gm_sresp <= 0;
                #160;
                gm_svalid <= 0;
                gm_sresp <= 0;
            end
            if (gm_mwrite && gm_saccept) begin
                #1000;
                gm_svalid <= 1;
                gm_sresp <= 1;
                #160;
                gm_svalid <= 0;
                gm_sresp <= 1;
            end


        end
    end

    
    
   always @(posedge clk or negedge rstn) begin
       if(~rstn) begin
           gm_sdata_0 <= 0;
       end 
       else begin
           if (gm_svalid && ~gm_sresp)
               //gm_sdata <= gm_sdata + 64'h0202020202020202;
               fp_0 = $fread(gm_sdata_0,fp);
       end
   end
    
    // always @(posedge clk or negedge rstn) begin
    //     if(~rstn) begin
    //         gm_sdata <= 64'h0706050403020100;
    //     end 
    //     else begin
    //         if (gm_svalid && ~gm_sresp)
    //             gm_sdata <= gm_sdata + 64'h0101010101010101;
    //     end
    // end

   assign gm_sdata = {gm_sdata_0[7:0],gm_sdata_0[15:8],gm_sdata_0[23:16],gm_sdata_0[31:24],gm_sdata_0[39:32],gm_sdata_0[47:40],gm_sdata_0[55:48],gm_sdata_0[63:56]};

   assign gm_mdata_1 = {gm_mdata[7:0],gm_mdata[15:8],gm_mdata[23:16],gm_mdata[31:24],gm_mdata[39:32],gm_mdata[47:40],gm_mdata[55:48],gm_mdata[63:56]};

   always @(posedge clk or negedge rstn) begin
       if (gm_mwrite && gm_saccept && rgb2yuv_with_gm_0.rgb2yuv_if_0.cur_state == 2)
           $fwrite(tp_y,"%h\n",gm_mdata_1);
       if (gm_mwrite && gm_saccept && rgb2yuv_with_gm_0.rgb2yuv_if_0.cur_state == 3)
           $fwrite(tp_uv,"%h\n",gm_mdata_1);
   end





   initial begin
       #`DUMP_TIME ;
       $fsdbDumpfile( `DUMP_FILE );
       $fsdbDumpvars( test_rgb2yuv ) ;
       #100 ;
   end



endmodule
