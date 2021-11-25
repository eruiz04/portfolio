
//Ruiz Mejia Eugenio Alejandro
//2 to 1 multiplexer

`ifndef Lab1_PKG_SV
    `define Lab1_PKG_SV
package Lab1_pkg;

`ifdef USIGNED_OP
    localparam  DW     = 8;
    typedef logic [DW-1:0]        datawidth_t;
    typedef logic [2*DW-1:0]      prod_dtwd_t;
    typedef logic [DW:0]          sumdif_dw_t;
    typedef logic [DW:0]          w_rshift1_t;
    typedef logic [W+1:0]        w_rshift2_t;
    typedef logic [3*DW-1:0]      datawidt3_t;
`else
    localparam  DW     = 2;
    typedef logic signed [DW-1:0]        datawidth_t;
    typedef logic signed [2*DW-1:0]      prod_dtwd_t;
    typedef logic signed [DW:0]          sumdif_dw_t;
    typedef logic signed [DW:0]          w_rshift1_t;
    typedef logic signed [DW+1:0]        w_rshift2_t;
    typedef logic        [3*DW-1:0]      datawidt3_t;
`endif

endpackage
`endif
