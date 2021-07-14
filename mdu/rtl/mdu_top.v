`default_nettype none

/* Multiplication Division Unit */
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
  output reg              o_mdu_ready,
  output wire [WIDTH-1:0] o_mdu_rd
);
  reg [31:0] rdata_a;
  reg [31:0] rdata_b;
  reg  [31:0] rs1_d, rs1_q; 
  reg  [31:0] rs2_d, rs2_q;
  reg  [ 4:0] cnt_d, cnt_q;
  reg         en_d, en_q;
  reg         done;
  reg [31:0]  temp;
  reg [63:0]  result_64;
  reg [31:0]  result_32;
  
  assign rdata_a = i_mdu_rs1;
  assign rdata_b = i_mdu_rs2;

  always @(*) begin
    en_q  = i_mdu_valid;
  end

  always @(posedge i_clk) begin
    if (i_rst) begin
      done        = 1'b0;
      o_mdu_ready = 1'b0;
      result_32   = 32'b0;
      result_64   = 64'b0;
      // en_q        = 1'b0;
    end else begin
      o_mdu_ready = 1'b0;
      done        = 1'b0;
      result_32   = 32'b0;
      result_64   = {result_32,result_32};
      case (i_mdu_op)
        3'b000: begin
          if (en_q) begin // MUL
            result_64 = rdata_a * rdata_b;
            result_32 = result_64[31:0];
            // o_mdu_ready = en_q;
            done = 1'b1;
          end
        end
        3'b001: begin  // MULH
          if (en_q) begin
            result_64 = $signed(rdata_a) * $signed(rdata_b);
            result_32 = result_64[63:32];
            // o_mdu_ready = en_q;
            done = 1'b1;
          end
        end
        3'b010: begin  // MULHSU  
          if (en_q) begin
            result_64 = $signed(rdata_a) * $unsigned(rdata_b);
            result_32 = result_64[63:32];
            // o_mdu_ready = en_q;
            done = 1'b1;
          end
        end
        3'b011: begin  // MULHU
          if (en_q) begin
            result_64 = $unsigned(rdata_a) * $unsigned(rdata_b);
            result_32 = result_64[63:32];
            // o_mdu_ready = en_q;
            done = 1'b1;
          end
        end
        3'b100: begin  // DIV
          if (en_q) begin
            result_32 = $signed(rdata_a) / $signed(rdata_b);
            // result_32 = result_64[31:0];
            // o_mdu_ready = en_q;
            done = 1'b1;
          end
        end
        3'b101: begin  // DIVU
          if (en_q) begin
            result_32 = $unsigned(rdata_a) * $unsigned(rdata_b);
            // result_32 = result_64[31:0];
            // o_mdu_ready = en_q;
            done = 1'b1;
          end
        end
        3'b110: begin  // REM 
          if (en_q) begin
            result_32 = $signed(rdata_a) % $signed(rdata_b);
            // result_32 = result_64[31:0];
            // o_mdu_ready = en_q;
            done = 1'b1;
          end
        end
        3'b111: begin  // REMU
          if (en_q) begin
            result_32 = $unsigned(rdata_a) % $unsigned(rdata_b);
            // result_32 = result_64[31:0];
            // o_mdu_ready = en_q;
            done = 1'b1;
          end
        end
        default: begin
          result_32 = 32'b0;
          result_64 = {result_32,result_32};
          // o_mdu_ready = 1'b0;
        end
      endcase
    end
  end

  always @(*) begin
    o_mdu_ready = i_mdu_valid & done;
  end

  assign o_mdu_rd = result_32;

endmodule
`default_nettype wire
