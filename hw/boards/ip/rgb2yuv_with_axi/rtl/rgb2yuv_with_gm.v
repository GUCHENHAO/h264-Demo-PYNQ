// =============================================================================
//  Project Name: rgb2yuv_with_axi
//  File Name: rgb2yuv_with_gm.v
// =============================================================================
//  Revision History
//      v0.0.1 - Gu Chen Hao - 20171125
//      File created.
// =============================================================================
module rgb2yuv_with_gm(
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
    //apb_pready       ,
    //apb_pslverr      ,
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

    parameter  AXI_DW                = 64          ,
               AXI_AW                = 32          ,
               AXI_MIDW              = 4           ,
               AXI_SIDW              = 8           ;//used to be 8

    parameter  AXI_WID               = 0           ,
               AXI_RID               = 0           ;

    parameter  APB_DW                =32            ;
    parameter  APB_AW                =32            ;    

    
    input                           clk         ;
    input                           rstn        ;

    // apb
    output      [APB_DW-1   : 0]    apb_prdata  ;
    input       [APB_AW-1   : 0]    apb_paddr   ;
    input                           apb_penable ;
    input                           apb_psel    ;
    input       [APB_DW-1   : 0]    apb_pwdata  ;
    input                           apb_pwrite  ;
    //output                        apb_pready  ;
    //output                        apb_pslverr ;

    // gm
    input                     gm_saccept    ;
    input   [AXI_DW-1   : 0]  gm_sdata      ;
    input   [3          : 0]  gm_sid        ;
    input                     gm_slast      ;
    input   [2          : 0]  gm_sresp      ;
    input                     gm_svalid     ;
    
    output  [AXI_AW-1   : 0]  gm_maddr      ;
    output  [1          : 0]  gm_mburst     ;
    output  [3          : 0]  gm_mcache     ;
    output  [AXI_DW-1   : 0]  gm_mdata      ;
    output  [3          : 0]  gm_mid        ;
    output  [3          : 0]  gm_mlen       ;
    output                    gm_mlock      ;
    output  [2          : 0]  gm_mprot      ;
    output                    gm_mread      ;
    output                    gm_mready     ;
    output  [2          : 0]  gm_msize      ;
    output                    gm_mwrite     ;
    output  [AXI_DW/8-1 : 0]  gm_mwstrb     ;

    rgb2yuv_if rgb2yuv_if_0 (
        // global
        .clk          (clk          ),   
        .rstn         (rstn         ),          
        // apb_s           
        .apb_s_prdata (apb_prdata   ),       
        //.apb_s_pready (apb_pready   ),       
        //.apb_s_pslverr(apb_pslverr  ),       
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

endmodule // rgb2yuv_with_gm
    