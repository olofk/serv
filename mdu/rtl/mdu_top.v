`default_nettype none

/* Multiplication & Division Unit */
module mdu_top
#(
  parameter WIDTH = 32
)(
  input  wire             i_clk,  
  input  wire             i_rst,
  input  wire [WIDTH-1:0] i_mdu_rs1,
  input  wire [WIDTH-1:0] i_mdu_rs2,
  input  wire [ 2:0]      i_mdu_op,
  input  wire             i_mdu_valid,
  output wire             o_mdu_ready,
  output wire [WIDTH-1:0] o_mdu_rd
);

  wire valid  = i_mdu_valid;

  // START MUL //
  reg  [32:0] rdata_a;
  reg  [32:0] rdata_b;
  reg  [63:0] rd;
  wire [31:0] mul_rd; 

  // Control Signals
  reg  mul_en;
  reg  mul_done;
  wire mul_ready;
  wire is_mul          = !i_mdu_op[2];
  wire unsign_mul      =  i_mdu_op[1]; 
  wire sign_unsign_mul =  i_mdu_op[0]; 
  wire is_mulh         = (|i_mdu_op) & is_mul;

  always @(posedge i_clk) begin
    if (valid & is_mul) begin
      mul_en <= valid;
      if (unsign_mul) begin
        /* verilator lint_off WIDTH */
        rdata_a <= sign_unsign_mul ? $unsigned(i_mdu_rs1) : $signed({i_mdu_rs1[31],i_mdu_rs1}); //$signed(i_mdu_rs1);
        rdata_b <= $unsigned(i_mdu_rs2);
      end else begin
        rdata_a <= $signed(i_mdu_rs1);
        rdata_b <= $signed(i_mdu_rs2);
      end
    end else begin
      mul_en <= 1'b0;
    end
  end

  always @(posedge i_clk) begin
    if (!i_rst & is_mul & mul_en) begin
      rd <= $signed(rdata_a)*$signed(rdata_b);
    end
    mul_done <= mul_en;
  end

  assign mul_ready = mul_done & valid;
  assign mul_rd = is_mulh ? rd >> 32 : rd;

  // DIV STARTS //  
  reg        outsign;
  reg [62:0] divisor;
  reg [31:0] dividend;
  reg [31:0] quotient;  
  reg [31:0] quotient_msk;
  reg [31:0] div_rd;

  reg  div_ready;
  reg  running;

  wire is_div = i_mdu_op[2] & (!i_mdu_op[1]);
  wire is_rem = i_mdu_op[2] & i_mdu_op[1];
  wire unsign_div_rem = i_mdu_op[0];
  wire prep   = valid & (is_div | is_rem) & !running & !div_ready;	
  
  always @(posedge i_clk) begin
    if (i_rst)  
      running <= 1'b0;
    else if (prep) begin
      dividend <= (!unsign_div_rem & i_mdu_rs1[31]) ? -i_mdu_rs1 : i_mdu_rs1;
      divisor  <= ((!unsign_div_rem & i_mdu_rs2[31]) ? -i_mdu_rs2 : i_mdu_rs2) << 31; 
      outsign  <= (!unsign_div_rem & is_div & (i_mdu_rs1[31] != i_mdu_rs2[31]) & (|i_mdu_rs2)) 
                   | (!unsign_div_rem & is_rem & i_mdu_rs1[31]);
      quotient <= 32'b0;
      quotient_msk <= 1 << 31;
      running <= 1'b1;
      div_ready <= 1'b0;
    end else if (!quotient_msk && running) begin
      running   <= 1'b0;
      div_ready <= 1'b1;
      if (is_div) begin
        div_rd <= outsign ? -quotient : quotient;
      end else begin
        div_rd <= outsign ? -dividend : dividend; 
      end
    end else begin
      div_ready <= 1'b0; 
      if (divisor <= dividend) begin
		  	dividend <= dividend - divisor;
		  	quotient <= quotient | quotient_msk;
		  end
      divisor <= divisor >> 1;
		  quotient_msk <= quotient_msk >> 1;
    end
  end

  assign o_mdu_ready = mul_ready | div_ready;
  assign o_mdu_rd = is_mul ? mul_rd : div_rd;

endmodule
`default_nettype wire
