// =============================================================================
//  Project Name: rgb2yuv_with_axi
//  File Name: rgb2yuv_with_axi.v
// =============================================================================
//  Revision History
//      v0.0.1 - Gu Chen Hao - 20171125
//      File created.
// =============================================================================
module rgb2yuv_with_axi(
    // global
    clk                ,
    rstn               ,
    //apb
    apb_prdata         ,
    apb_paddr          ,
    apb_penable        ,
    apb_psel           ,
    apb_pwdata         ,
    apb_pwrite         ,
    apb_pready       ,
    apb_pslverr      ,
    // axi_m
    axi_m_arready      ,
    axi_m_awready      ,
    axi_m_bid          ,
    axi_m_bresp        ,
    axi_m_bvalid       ,
    axi_m_rdata        ,
    axi_m_rid          ,
    axi_m_rlast        ,
    axi_m_rresp        ,
    axi_m_rvalid       ,
    axi_m_wready       ,
    axi_m_araddr       ,
    axi_m_arburst      ,
    axi_m_arcache      ,
    axi_m_arid         ,
    axi_m_arlen        ,
    axi_m_arlock       ,
    axi_m_arprot       ,
    axi_m_arsize       ,
    axi_m_arvalid      ,
    axi_m_awaddr       ,
    axi_m_awburst      ,
    axi_m_awcache      ,
    axi_m_awid         ,
    axi_m_awlen        ,
    axi_m_awlock       ,
    axi_m_awprot       ,
    axi_m_awsize       ,
    axi_m_awvalid      ,
    axi_m_bready       ,
    axi_m_rready       ,
    axi_m_wdata        ,
    axi_m_wid          ,
    axi_m_wlast        ,
    axi_m_wstrb        ,
    axi_m_wvalid                                          
    );
    

    parameter  AXI_DW                = 64             ,
               AXI_AW                = 32             ,
               AXI_MIDW              = 4              ,
               AXI_SIDW              = 6              ;//used to be 8
      
    parameter  AXI_WID               = 0              ,
               AXI_RID               = 0              ;
    parameter  APB_DW                = 32             ;
    parameter  APB_AW                = 32             ;      

    
    input                              clk            ;
    input                              rstn           ;
      
    // apb    
    output      [APB_DW-1   : 0]       apb_prdata     ;
    input       [APB_AW-1   : 0]       apb_paddr      ;
    input                              apb_penable    ;
    input                              apb_psel       ;
    input       [APB_DW-1   : 0]       apb_pwdata     ;
    input                              apb_pwrite     ;
    output                             apb_pready     ;
    output                             apb_pslverr    ;

    // axi
    input                              axi_m_arready  ;
    input                              axi_m_awready  ;
    input  [AXI_SIDW-1        : 0]     axi_m_bid      ;
    input  [1                 : 0]     axi_m_bresp    ;
    input                              axi_m_bvalid   ;
    input  [AXI_DW-1          : 0]     axi_m_rdata    ;
    input  [AXI_SIDW-1        : 0]     axi_m_rid      ;
    input                              axi_m_rlast    ;
    input  [1                 : 0]     axi_m_rresp    ;
    input                              axi_m_rvalid   ;
    input                              axi_m_wready   ;
    output [AXI_AW-1          : 0]     axi_m_araddr   ;
    output [1                 : 0]     axi_m_arburst  ;
    output [3                 : 0]     axi_m_arcache  ;
    output [AXI_SIDW-1        : 0]     axi_m_arid     ;
    output [3                 : 0]     axi_m_arlen    ;
    output [1                 : 0]     axi_m_arlock   ;
    output [2                 : 0]     axi_m_arprot   ;
    output [2                 : 0]     axi_m_arsize   ;
    output                             axi_m_arvalid  ;
    output [AXI_AW-1          : 0]     axi_m_awaddr   ;
    output [1                 : 0]     axi_m_awburst  ;
    output [3                 : 0]     axi_m_awcache  ;
    output [AXI_SIDW-1        : 0]     axi_m_awid     ;
    output [3                 : 0]     axi_m_awlen    ;
    output [1                 : 0]     axi_m_awlock   ;
    output [2                 : 0]     axi_m_awprot   ;
    output [2                 : 0]     axi_m_awsize   ;
    output                             axi_m_awvalid  ;
    output                             axi_m_bready   ;
    output                             axi_m_rready   ;
    output [AXI_DW-1          : 0]     axi_m_wdata    ;
    output [AXI_SIDW-1        : 0]     axi_m_wid      ;
    output                             axi_m_wlast    ;
    output [AXI_DW/8-1        : 0]     axi_m_wstrb    ;
    output                             axi_m_wvalid   ;
    
    // gen_m
    wire   [AXI_AW-1           : 0]    gm_maddr       ;
    wire   [1                  : 0]    gm_mburst      ;
    wire   [3                  : 0]    gm_mcache      ;
    wire   [AXI_DW-1           : 0]    gm_mdata       ;
    wire   [AXI_MIDW-1         : 0]    gm_mid         ;
    wire   [3                  : 0]    gm_mlen        ;
    wire                               gm_mlock       ;
    wire   [2                  : 0]    gm_mprot       ;
    wire                               gm_mread       ;
    wire                               gm_mready      ;
    wire   [2                  : 0]    gm_msize       ;
    wire                               gm_mwrite      ;
    wire   [AXI_DW/8-1         : 0]    gm_mwstrb      ;
    wire                               gm_saccept     ;
    wire   [AXI_DW-1           : 0]    gm_sdata       ;
    wire   [AXI_MIDW-1         : 0]    gm_sid         ;
    wire                               gm_slast       ;
    wire   [2                  : 0]    gm_sresp       ;
    wire                               gm_svalid      ;

    rgb2yuv_if rgb2yuv_if_0 (
        // global
        .clk          (clk          ),   
        .rstn         (rstn         ),        
        // apb_s           
        .apb_s_prdata (apb_prdata   ),       
        .apb_s_pready (apb_pready   ),       
        .apb_s_pslverr(apb_pslverr  ),       
        .apb_s_paddr  (apb_paddr    ),       
        .apb_s_penable(apb_penable  ),       
        .apb_s_psel   (apb_psel     ),       
        .apb_s_pwdata (apb_pwdata   ),       
        .apb_s_pwrite (apb_pwrite   ),       
        // gm           
        .gm_maddr     (gm_maddr     ),     
        .gm_mburst    (gm_mburst    ),     
        .gm_mcache    (gm_mcache    ),     
        .gm_mdata     (gm_mdata     ),     
        .gm_mid       (gm_mid       ),     
        .gm_mlen      (gm_mlen      ),     
        .gm_mlock     (gm_mlock     ),     
        .gm_mprot     (gm_mprot     ),     
        .gm_mread     (gm_mread     ),     
        .gm_mready    (gm_mready    ),     
        .gm_msize     (gm_msize     ),     
        .gm_mwrite    (gm_mwrite    ),     
        .gm_mwstrb    (gm_mwstrb    ),     
        .gm_saccept   (gm_saccept   ),     
        .gm_sdata     (gm_sdata     ),     
        .gm_sid       (gm_sid       ),     
        .gm_slast     (gm_slast     ),     
        .gm_sresp     (gm_sresp     ),     
        .gm_svalid    (gm_svalid    )                        
    );

    gm_1_DW_axi_gm gm_1_DW_axi_gm_0(
        // Outputs
        .saccept           ( gm_saccept    ),
        .sid               ( gm_sid        ),
        .svalid            ( gm_svalid     ),
        .slast             ( gm_slast      ),
        .sdata             ( gm_sdata      ),
        .sresp             ( gm_sresp      ),
        .awid              ( axi_m_awid       ),
        .awvalid           ( axi_m_awvalid    ),
        .awaddr            ( axi_m_awaddr     ),
        .awlen             ( axi_m_awlen      ),
        .awsize            ( axi_m_awsize     ),
        .awburst           ( axi_m_awburst    ),
        .awlock            ( axi_m_awlock     ),
        .awcache           ( axi_m_awcache    ),
        .awprot            ( axi_m_awprot     ),
        .wid               ( axi_m_wid        ),
        .wvalid            ( axi_m_wvalid     ),
        .wlast             ( axi_m_wlast      ),
        .wdata             ( axi_m_wdata      ),
        .wstrb             ( axi_m_wstrb      ),
        .bready            ( axi_m_bready     ),
        .arid              ( axi_m_arid       ),
        .arvalid           ( axi_m_arvalid    ),
        .araddr            ( axi_m_araddr     ),
        .arlen             ( axi_m_arlen      ),
        .arsize            ( axi_m_arsize     ),
        .arburst           ( axi_m_arburst    ),
        .arlock            ( axi_m_arlock     ),
        .arcache           ( axi_m_arcache    ),
        .arprot            ( axi_m_arprot     ),
        .rready            ( axi_m_rready     ),
        // Inputs
        .aclk              ( clk              ),
        .aresetn           ( rstn             ),
        .gclken            ( 1'b1             ),
        .mid               ( gm_mid           ),
        .maddr             ( gm_maddr         ),
        .mread             ( gm_mread         ),
        .mwrite            ( gm_mwrite        ),
        .mlock             ( gm_mlock         ),
        .mlen              ( gm_mlen          ),
        .msize             ( gm_msize         ),
        .mburst            ( gm_mburst        ),
        .mcache            ( gm_mcache        ),
        .mprot             ( gm_mprot         ),
        .mdata             ( gm_mdata         ),
        .mwstrb            ( gm_mwstrb        ),
        .mready            ( gm_mready        ),
        .awready           ( axi_m_awready    ),
        .wready            ( axi_m_wready     ),
        .bid               ( axi_m_bid        ),
        .bvalid            ( axi_m_bvalid     ),
        .bresp             ( axi_m_bresp      ),
        .arready           ( axi_m_arready    ),
        .rid               ( axi_m_rid        ),
        .rvalid            ( axi_m_rvalid     ),
        .rlast             ( axi_m_rlast      ),
        .rdata             ( axi_m_rdata      ),
        .rresp             ( axi_m_rresp      )
    );
    
endmodule // rgb2yuv_with_axi
