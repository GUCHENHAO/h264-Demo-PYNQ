// ============================================================================
//  Project Name: rgb2yuv_with_axi
//  File Name: V.v
// ============================================================================
//  Revision History
//      v0.0.1 - Gu Chen Hao - 20171125
//      File created.
// ============================================================================

`define XILINX

module rgb2yuv_if(
    // global
    clk                 ,
    rstn                ,
    // apb_s    
    apb_s_prdata        ,
    apb_s_pready        ,
    apb_s_pslverr       ,
    apb_s_paddr         ,
    apb_s_penable       ,
    apb_s_psel          ,
    apb_s_pwdata        ,
    apb_s_pwrite        ,
    // gm
    gm_maddr           ,
    gm_mburst          ,
    gm_mcache          ,
    gm_mdata           ,
    gm_mid             ,
    gm_mlen            ,
    gm_mlock           ,
    gm_mprot           ,
    gm_mread           ,
    gm_mready          ,
    gm_msize           ,
    gm_mwrite          ,
    gm_mwstrb          ,
    gm_saccept         ,
    gm_sdata           ,
    gm_sid             ,
    gm_slast           ,
    gm_sresp           ,
    gm_svalid                                         
    );
    

//*** PARAMETER DECLARATION ***************************************************

    parameter   AXI_DW            = 64              ,
                AXI_AW            = 32              ,
                APB_DW            = 'd32            ,
                APB_AW            = 'd32            ,
                AXI_WID           = 1               ;
                    
    parameter   BST_LEN           = 16              ;
   
    parameter   ADDR_START        = 'h00            ;
    parameter   ADDR_RGB_BASE    = 'h01            ;
    parameter   ADDR_Y_BASE       = 'h02            ;   
    parameter   ADDR_ROW_LEN      = 'h03            ;
    parameter   ADDR_COL_LEN      = 'h04            ;
    parameter   ADDR_PIX_LEN      = 'h05            ;
                                                  
    parameter   ADDR_DONE         = 'h06            ;

    parameter   WR_DEPTH          = 64              ;

    parameter   IDLE              = 0               ,
                READ_RGB          = 1               ,
                WRITE_Y           = 2               ,
                WRITE_UV          = 3               ;

//*** INPUT/OUTPUT DECLARATION ************************************************

    // global
    input                           clk         ;
    input                           rstn        ;

    // apb
    output reg  [APB_DW-1   : 0]    apb_s_prdata    ;
    input       [APB_AW-1   : 0]    apb_s_paddr     ;
    input                           apb_s_penable   ;
    input                           apb_s_psel      ;
    input       [APB_DW-1   : 0]    apb_s_pwdata    ;
    input                           apb_s_pwrite    ;
    output reg                      apb_s_pready    ;
    output reg                      apb_s_pslverr   ;

    // gm
    input                           gm_saccept      ;
    input       [AXI_DW-1   : 0]    gm_sdata        ;
    input       [3          : 0]    gm_sid          ;
    input                           gm_slast        ;
    input       [2          : 0]    gm_sresp        ;
    input                           gm_svalid       ;
    
    output reg  [AXI_AW-1   : 0]    gm_maddr        ;
    output      [1          : 0]    gm_mburst       ;
    output      [3          : 0]    gm_mcache       ;
    output reg  [AXI_DW-1   : 0]    gm_mdata        ;
    output      [3          : 0]    gm_mid          ;
    output      [3          : 0]    gm_mlen         ;
    output                          gm_mlock        ;
    output      [2          : 0]    gm_mprot        ;
    output                          gm_mread        ;
    output                          gm_mready       ;
    output      [2          : 0]    gm_msize        ;
    output                          gm_mwrite       ;
    output      [AXI_DW/8-1 : 0]    gm_mwstrb       ;


//*** WIRE/REG DECLARATION ****************************************************

    //*** GLOBAL **************************************************************    
    reg                             reg_start       ;
    reg         [11         : 0]    reg_row_len     ;
    reg         [11         : 0]    reg_col_len     ;    
    reg         [31         : 0]    reg_rgb_base    ;
    reg         [31         : 0]    reg_y_base      ;
    reg         [31         : 0]    reg_pix_len     ;

    reg                             axi_start_r     ;
    reg                             axi_start_r_r   ;
    wire                            self_rstn_axi   ;

    reg         [1:0]               cur_state       ;
    reg         [1:0]               nxt_state       ;
    reg                             done            ;
    
    //*** RGB *****************************************************************
    wire                            fifo_rst        ;
    wire                            push_req_rgb    ;
    wire                            pop_req_rgb     ;
    wire        [31         : 0]    pre_data_rgb    ;
    reg         [31         : 0]    data_rgb        ;
    reg                             valid_rgb       ;

    reg         [11         : 0]    cnt_rgb         ; //2048 bytes
    reg         [31         : 0]    addr_offset_rgb ;
    wire                            empty_rgb       ;

    //*** YUV *****************************************************************
    wire        [7          : 0]    data_y          ;
    wire        [7          : 0]    data_u          ;   
    wire        [7          : 0]    data_v          ;
    wire        [15         : 0]    data_uv         ;
    wire        [63         : 0]    wr_y            ;
    wire        [63         : 0]    wr_uv           ;
    wire                            valid_yuv       ;


    wire        [6          : 0]    cnt_y           ;
    wire        [6          : 0]    cnt_uv          ;
    wire                            start_y         ;
    wire                            start_uv        ;
    reg         [31         : 0]    addr_offset_y   ;
    reg         [31         : 0]    addr_offset_uv  ;

    wire                            push_req_y      ;
    wire                            full_y          ;
    wire                            pop_req_y       ;
    wire        [63         : 0]    gm_wr_y         ;
    wire                            empty_y         ;

    wire                            push_req_uv     ;
    wire                            full_uv         ;
    wire                            pop_req_uv      ;
    wire        [63         : 0]    gm_wr_uv        ;
    wire                            empty_uv        ;

    wire                            burst_finish     ;  
    reg         [3          : 0]    gm_mwrite_counter; 

    reg         [11         : 0]    index_x         ;
    reg         [11         : 0]    index_y         ;
    reg         [31         : 0]    pixels          ; 
    reg         [31         : 0]    counter         ;
    
//*** GLOBAL ******************************************************************

  always @(posedge clk or negedge rstn) begin
    if( !rstn )
      axi_start_r <= 0 ;
    else
      axi_start_r <= reg_start ;
  end

always @(posedge clk or negedge rstn) begin
    if( !rstn )
      axi_start_r_r <= 0 ;
    else begin
        if (done) 
            axi_start_r_r <= 0; 
        else
            if (axi_start_r)
                axi_start_r_r <= 1 ;
    end
  end

  assign self_rstn_axi = ~( (~axi_start_r_r)&&axi_start_r );

//*** APB *********************************************************************

    always @(posedge clk or negedge rstn) begin
        if( !rstn ) begin
          reg_row_len   <= 'd0 ;
          reg_col_len   <= 'd0 ;
          reg_rgb_base <= 'd0 ;
          reg_y_base    <= 'd0 ;
        end
        else if( apb_s_psel && apb_s_pwrite ) begin
          case( apb_s_paddr[6:2] )
              ADDR_COL_LEN    : reg_col_len   <= apb_s_pwdata[11:0] ;
              ADDR_ROW_LEN    : reg_row_len   <= apb_s_pwdata[11:0] ;
              ADDR_RGB_BASE   : reg_rgb_base  <= apb_s_pwdata[31:0] ;
              ADDR_Y_BASE     : reg_y_base    <= apb_s_pwdata[31:0] ;
              ADDR_PIX_LEN    : reg_pix_len   <= apb_s_pwdata[31:0] ;
          endcase
        end
    end
    
    always @(*) begin
                            apb_s_prdata = 'd0                     ;
      case( apb_s_paddr[6:2] )
        ADDR_START          : apb_s_prdata = {31'd0, reg_start   } ;
        ADDR_COL_LEN        : apb_s_prdata = {20'd0, reg_col_len } ;
        ADDR_ROW_LEN        : apb_s_prdata = {20'd0, reg_row_len } ;
        ADDR_RGB_BASE       : apb_s_prdata = reg_rgb_base          ;
        ADDR_Y_BASE         : apb_s_prdata = reg_y_base            ;
        ADDR_PIX_LEN        : apb_s_prdata = reg_pix_len           ;
        ADDR_DONE           : apb_s_prdata = {31'd0, done   }      ;
        default             : apb_s_prdata = 'd0                   ;
      endcase
    end

    always @(posedge clk or negedge rstn) begin
        if( !rstn )
          reg_start <= 'd0;
        else if( apb_s_psel && apb_s_pwrite && (apb_s_paddr[6:2]==ADDR_START) )
          reg_start <= apb_s_pwdata[0];
    end

    always @(posedge clk or negedge rstn) begin
        if ( !rstn ) begin 
          apb_s_pslverr <= 0;
          apb_s_pready <= 0;
        end
        else begin
          if (apb_s_penable && ~apb_s_pready )
              apb_s_pready <= 1;
              else begin
                apb_s_pready <= 0;
              end
        end
    end

//*** MAIN **********************************************************************

    assign gm_mburst  = 2'b01     ;
    assign gm_mcache  = 4'b0000   ;
    assign gm_mid     = AXI_WID   ;
    assign gm_mlen    = BST_LEN-1 ;
    assign gm_mlock   = 0         ;
    assign gm_mprot   = 3'b000    ;
    assign gm_mready  = 1         ;
    assign gm_msize   = 3'b011    ; // 64 bits
    assign gm_mwstrb  = 16'hff    ; // 8 bytes

    // state
    always @(posedge clk or negedge rstn ) begin
        if( !rstn )
          cur_state <= 0 ;
        else begin
          cur_state <= nxt_state ;
        end
    end

    always @(*) begin       
        case( cur_state )
            IDLE : 
                if( axi_start_r_r && !done) begin
                    if (start_y)
                        nxt_state = WRITE_Y;
                    else 
                        if (start_uv)
                            nxt_state = WRITE_UV;
                        else
                            if (cnt_rgb < 12'd2048)
                                nxt_state = READ_RGB;
                            else
                                nxt_state = IDLE;    
                end
            READ_RGB :
                if (gm_mread && gm_saccept)
                    nxt_state = IDLE;
                else
                    nxt_state = READ_RGB;
            WRITE_Y :
                if (burst_finish)
                    nxt_state = IDLE;
                else
                    nxt_state = WRITE_Y;
            WRITE_UV :
                if (burst_finish)
                    nxt_state = IDLE;
                else
                    nxt_state = WRITE_UV;
            default :
                nxt_state = IDLE;    
        endcase
    end

    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            cnt_rgb <= 0;
        end 
        else begin
            if (gm_mread && gm_saccept) begin
                if (pop_req_rgb)              
                    cnt_rgb <= cnt_rgb + 128 - 4;
                else 
                    cnt_rgb <= cnt_rgb + 128;
            end
            else begin
                if (pop_req_rgb)              
                    cnt_rgb <= cnt_rgb - 4;
            end
        end
    end

    assign burst_finish = (gm_mwrite_counter == BST_LEN-1) && gm_saccept && gm_mwrite ;

    always @(posedge clk or negedge rstn) begin
        if( !rstn )
          gm_mwrite_counter <= 0 ;
        else if( !gm_mwrite )
          gm_mwrite_counter <= 0 ;
        else if( gm_saccept & gm_mwrite ) begin
            gm_mwrite_counter <= gm_mwrite_counter + 1 ;
        end
    end

    // fifo rst
    assign fifo_rst =  !(rstn && self_rstn_axi);

    always @(posedge clk or negedge rstn) begin  
        if(~rstn) begin
            addr_offset_rgb <= 0;
        end 
        else begin
            if (!self_rstn_axi)
                addr_offset_rgb <= 0;
            else
                if (gm_mread && gm_saccept)
                    addr_offset_rgb <= addr_offset_rgb + 128;
        end
    end

    always @(posedge clk or negedge rstn) begin  
        if(~rstn) begin
            addr_offset_y <= 0;
        end 
        else begin
            if (!self_rstn_axi)
                addr_offset_y <= 0;
            else
                if (pop_req_y)
                    addr_offset_y <= addr_offset_y + 8;
        end
    end

    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            addr_offset_uv <= 0;
        end 
        else begin
            if (!self_rstn_axi)
                addr_offset_uv <= 0;
            else
                if (pop_req_uv)
                    addr_offset_uv <= addr_offset_uv + 8;
        end
    end

    always @(*) begin
        case (cur_state)
            READ_RGB : gm_maddr = reg_rgb_base + addr_offset_rgb;
            WRITE_Y  : gm_maddr = reg_y_base   + addr_offset_y  ;
            WRITE_UV : gm_maddr = reg_y_base   + reg_pix_len + addr_offset_uv  ;
        endcase
    end

   

    // *** RGB ****************************************************************

    //64 in 32 out 
    `ifdef XILINX
     wire [31:0] pre_data_rgb_0;
     wire [63:0] gm_sdata_1    ;
        fifo_64_32 fifo_rgb(
            .full   (full_rgb),
            .din    (gm_sdata_1),
            .wr_en  (push_req_rgb),
            .empty  (empty_rgb),
            //.dout   (pre_data_rgb_0),
            .dout   (pre_data_rgb),
            .rd_en  (pop_req_rgb),
            .rst    (fifo_rst),
            .rd_clk (clk),
            .wr_clk (clk),
            .rd_data_count (),
            .wr_data_count ()
            );
     assign gm_sdata_1 = {gm_sdata[31:0],gm_sdata[63:32]};
     //assign pre_data_rgb = {pre_data_rgb_0[7:0],pre_data_rgb_0[15:8],pre_data_rgb_0[23:16],pre_data_rgb_0[31:24]};
    `endif

    `ifdef ALTERA
        fifo_rgb_alt fifo_rgb (
            // global
            .aclr       ( fifo_rst      ),
            // wr_side
            .wrclk      ( clk           ),
            .wrreq      ( push_req_rgb  ),
            .data       ( gm_sdata      ),
            //.wrusedw    (               ),
            .wrfull     ( full_rgb      ),
            // rd_size 
            .rdclk      ( clk       ),
            .rdreq      ( pop_req_rgb   ),
            .q          ( pre_data_rgb  ),
            //.rdusedw    (               ),
            .rdempty    ( empty_rgb     )
        );//8 in 128 out
    `endif

    assign gm_mread = (cur_state == READ_RGB);

    assign push_req_rgb = gm_svalid && (gm_sresp==2'b00);

    assign pop_req_rgb  = !empty_rgb && (cnt_rgb > 0) && !full_y && !full_uv;

    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            valid_rgb <= 0;
        end 
        else begin
            valid_rgb <= pop_req_rgb;
        end
    end

    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            data_rgb <= 0;
        end 
        else begin
            data_rgb <= pre_data_rgb;
        end
    end

    // *** RGB2YUV ************************************************************

    rgb2ycrcb_top rgb2ycrcb_top(
        .Clock (clk         ),      
        .Reset (~rstn        ),      
        .Vi    (valid_rgb       ),  
        .Red   (data_rgb[7:0]   ),  
        .Green (data_rgb[15:8]  ),    
        .Blue  (data_rgb[23:16] ),    
        .Vo    (valid_yuv       ),
        .Y     (data_y          ),  
        .Cb    (data_u          ),  
        .Cr    (data_v          )  
    );

    // *** YUV ****************************************************************

    `ifdef XILINX
        wire [63:0] wr_y_0;
         fifo_8_64 fifo_y(
            .full   (full_y),
            .din    (data_y),
            .wr_en  (push_req_y),
            .empty  (empty_y),
            .dout   (wr_y_0),
            //.dout   (wr_y),
            .rd_en  (pop_req_y),
            .rst    (fifo_rst),
            .rd_clk (clk),
            .wr_clk (clk),
            .rd_data_count (cnt_y),
            .wr_data_count ()
        );
        assign wr_y = {wr_y_0[7:0],wr_y_0[15:8],wr_y_0[23:16],wr_y_0[31:24],wr_y_0[39:32],wr_y_0[47:40],wr_y_0[55:48],wr_y_0[63:56]};
        wire [63:0] wr_uv_0;
        fifo_16_64 fifo_uv(
           .full   (full_uv),
           .din    (data_uv),
           .wr_en  (push_req_uv),
           .empty  (empty_uv),
           .dout   (wr_uv_0),
           //.dout   (wr_uv),
           .rd_en  (pop_req_uv),
           .rst    (fifo_rst),
           .rd_clk (clk),
           .wr_clk (clk),
           .rd_data_count (cnt_uv),
           .wr_data_count ()
       );
       assign wr_uv = {wr_uv_0[15:0],wr_uv_0[31:16],wr_uv_0[47:32],wr_uv_0[63:48]};
    `endif

    `ifdef ALTERA
        fifo_y_alt fifo_y (
            // global
            .aclr       ( fifo_rst      ),
            // wr_side
            .wrclk      ( clk           ),
            .wrreq      ( push_req_y    ),
            .data       ( data_y        ),
            .wrusedw    (               ),
            .wrfull     ( full_y        ),
            // rd_size
            .rdclk      ( clk           ),
            .rdreq      ( pop_req_y     ),
            .q          ( wr_y          ),
            .rdusedw    ( cnt_y         ),
            .rdempty    ( empty_y       ) 
        );//8 in 64 out

        fifo_uv_alt fifo_uv (
            // global
            .aclr       ( fifo_rst      ),
            // wr_side
            .wrclk      ( clk           ),
            .wrreq      ( push_req_uv   ),
            .data       ( data_uv       ),
            .wrusedw    (               ),
            .wrfull     ( full_uv       ),
            // rd_size
            .rdclk      ( clk           ),
            .rdreq      ( pop_req_uv    ),
            .q          ( wr_uv         ),
            .rdusedw    ( cnt_uv        ),
            .rdempty    ( empty_uv      ) 
        );//16 in 64 out
    `endif

    assign push_req_y  = valid_yuv  ;
    assign push_req_uv = valid_yuv &&  ~index_x[0] && ~index_y[0];
    assign data_uv = {data_v,data_u};

    assign start_y  = {cnt_y  >= WR_DEPTH >> 2};
    assign start_uv = {cnt_uv >= WR_DEPTH >> 2};

    assign gm_mwrite = (cur_state == WRITE_Y) || (cur_state == WRITE_UV);

    always @ (*) begin
        case (cur_state)
            WRITE_Y  : gm_mdata = wr_y ;
            WRITE_UV : gm_mdata = wr_uv;
            default  : gm_mdata = 0    ;
        endcase
    end

    assign pop_req_y  = gm_mwrite && gm_saccept && (cur_state == WRITE_Y );
    assign pop_req_uv = gm_mwrite && gm_saccept && (cur_state == WRITE_UV);

    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            index_x <= 0;
        end 
        else begin
            if (!self_rstn_axi)
                index_x <= 0;
            else
            if (valid_yuv) begin
                if (index_x == (reg_col_len - 1))
                    index_x <= 0;
                else
                    index_x <= index_x + 1;
            end
        end
    end

    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            index_y <= 0;
        end 
        else begin
            if (!self_rstn_axi)
                index_y <= 0;
            else
            if (valid_yuv && index_x == (reg_col_len - 1))
                index_y  <= index_y + 1;
        end
    end

    always @(posedge clk or negedge rstn) begin  
        if(~rstn) begin
            pixels <= 0;
        end 
        else begin
            if (!self_rstn_axi)
                pixels <= 0;
            else
                if (gm_mwrite && gm_saccept && (cur_state == WRITE_Y))
                    pixels <= pixels + 8;
        end
    end

    always @(posedge clk or negedge rstn) begin 
        if(~rstn) begin
            done <= 0;
        end else begin
            if (axi_start_r)
                done <= 0;
            else
                if ((pixels == reg_pix_len - 8) && (gm_mwrite && gm_saccept))
                    done <= 1;
        end
    end

endmodule // rgb2yuv_if
