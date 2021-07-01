`default_nettype none

/* Multiplication Division Unit */
module mdu_top
#(
  parameter WIDTH = 1;
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
  wire [31:0] rdata_a;
  wire [31:0] rdata_b;
  reg  [31:0] rs1; 
  reg  [31:0] rs2;
  reg  [ 4:0] cnt;
  reg         en;
  wire        busy;

  always @(posedge i_clk) begin
    if (i_rst) begin
      rs1 <= 32'b0;
      rs2 <= 32'b0;
      cnt <=  5'b0;
      en  <=  1'b0;
    end else if (i_mdu_valid & (!(&cnt))) begin
      rs1 <= {rs1[30:0], i_mdu_rs1};
      rs2 <= {rs2[30:0], i_mdu_rs2};
      en  <= 1'b0;
      cnt <= cnt + 1'b1;
    end else if (!busy & (&cnt)) begin
      cnt <= 5'b0;
      en  <= 1'b1;
    end
  end

  assign rdata_a = (&cnt) ? rs1 : 32'b0;
  assign rdata_b = (&cnt) ? rs2 : 32'b0;
  assign busy    = (&cnt) ? 1'b1: 1'b0;

  reg [31:0] result;

  always @(posedge i_clk) begin
    result = 32'b0;

    case (i_mdu_op)
      3'b000: begin
        result = rdata_a * rdata_b;
      end
      default: result = result;
  end

//  TODO: The result sending part
endmodule
`default_nettype wire