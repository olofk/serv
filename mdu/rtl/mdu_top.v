`default_nettype none

/* Multiplication Division Unit */
module mdu_top
#(
  parameter WIDTH = 1
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
  wire [31:0] rdata_a;
  wire [31:0] rdata_b;
  reg  [31:0] rs1_d, rs1_q; 
  reg  [31:0] rs2_d, rs2_q;
  reg  [ 4:0] cnt_d, cnt_q;
  reg         en_d, en_q;
  reg         done;
  reg [31:0]  temp;
  reg [63:0]  result_64;
  reg [31:0]  result_32;

  /* FSM starts*/
  parameter RESET   = 3'b000;
  parameter IDLE    = 3'b001;
  parameter GET     = 3'b010;
  parameter BUSY    = 3'b011;
  parameter SEND    = 3'b100;

  reg [2:0] fsm_cs, fsm_ns;
  reg valid_d, valid_q;

  always @(*) begin
    en_d   = 1'b1;
    o_mdu_rd =1'b0;
    cnt_d  = cnt_q;
    fsm_ns = fsm_cs;
    case (fsm_cs)
      RESET: begin
        o_mdu_rd = 1'b0;
        cnt_d  = 5'b0;
      end
      IDLE: begin
        cnt_d = 5'b0;
        valid_d = 1'b1;
        if (i_mdu_valid) begin
          fsm_ns = GET;
        end else begin
          fsm_ns = IDLE;
        end
      end
      GET: begin
        if (&cnt_q) begin
          fsm_ns = BUSY;
        end else begin
          rs1_d  = {rs1_q[30:0], i_mdu_rs1};
          rs2_d  = {rs2_q[30:0], i_mdu_rs2};
          en_d   = 1'b0;
          cnt_d += 1'b1;
          fsm_ns = GET;
        end
      end
      BUSY: begin
        valid_d = 1'b0;
        fsm_ns  = SEND;
      end
      SEND: begin
        valid_d = 1'b1;
        if (&cnt_q) begin
          fsm_ns = IDLE;
        end else begin
          if (done) begin
            temp = result_32;
          end else begin
            o_mdu_rd = temp[31];
            temp = {temp[30:0],1'b0};
            cnt_d += 1'b1;
            fsm_ns = SEND;
          end
        end
      end
      default: begin
        o_mdu_rd = 1'b0;
        fsm_ns = IDLE;
      end
    endcase
  end

  always @(posedge i_clk) begin
    if (i_rst) begin
      rs1_q <= 32'b0;
      rs2_q <= 32'b0;
      cnt_q <= 5'b0;
      valid_q <= 1'b0;
      en_q  <= 1'b0;
      fsm_cs <= RESET;
    end else begin
      rs1_q <= rs1_d;
      rs2_q <= rs2_d;
      cnt_q <= cnt_d;
      valid_q <= valid_d;
      en_q  <= en_d;
      fsm_cs <= fsm_ns; 
    end
  end
  /* FSM ends*/

/*
  always @(posedge i_clk) begin
    if (i_rst) begin
      rs1 <= 32'b0;
      rs2 <= 32'b0;
      cnt <=  5'b0;
      en  <=  1'b0;
    end else if (i_mdu_valid | (!(&cnt))) begin
      rs1 <= {rs1[30:0], i_mdu_rs1};
      rs2 <= {rs2[30:0], i_mdu_rs2};
      en  <= 1'b0;
      cnt <= cnt + 1'b1;
    end

    if (&cnt) begin
      cnt <= 5'b0;
      en  <= 1'b1;
      o_mdu_ready = 1'b0;
    end
  end
*/
  assign rdata_a = en_q ? rs1_q : 32'b0;
  assign rdata_b = en_q ? rs2_q : 32'b0;

  always @(posedge i_clk) begin
    if (i_rst) begin
      done        = 1'b0;
      o_mdu_ready = 1'b0;
      result_32   = 32'b0;
      result_64   = 64'b0;
    end else begin
      o_mdu_ready = 1'b1;
      result_32   = 32'hffffffff;
      result_64   = {result_32,result_32};
      case (i_mdu_op)
        3'b000: begin  // MUL
          if (en_q) begin
            result_64 = rdata_a * rdata_b;
            result_32 = result_64[31:0];
            o_mdu_ready = 1'b1;
            done = 1'b1;
          end
        end
        3'b001: begin  // MULH
          if (en_q) begin
            result_64 = $signed(rdata_a) * $signed(rdata_b);
            result_32 = result_64[63:32];
            o_mdu_ready = 1'b1;
            done = 1'b1;
          end
        end
        3'b010: begin  // MULHSU  
          if (en_q) begin
            result_64 = $signed(rdata_a) * $unsigned(rdata_b);
            result_32 = result_64[63:32];
            o_mdu_ready = 1'b1;
            done = 1'b1;
          end
        end
        3'b011: begin  // MULHU
          if (en_q) begin
            result_64 = $unsigned(rdata_a) * $unsigned(rdata_b);
            result_32 = result_64[63:32];
            o_mdu_ready = 1'b1;
            done = 1'b1;
          end
        end
        3'b100: begin  // DIV
          if (en_q) begin
            result_32 = $signed(rdata_a) / $signed(rdata_b);
            // result_32 = result_64[31:0];
            o_mdu_ready = 1'b1;
            done = 1'b1;
          end
        end
        3'b101: begin  // DIVU
          if (en_q) begin
            result_32 = $unsigned(rdata_a) * $unsigned(rdata_b);
            // result_32 = result_64[31:0];
            o_mdu_ready = 1'b1;
            done = 1'b1;
          end
        end
        3'b110: begin  // REM 
          if (en_q) begin
            result_32 = $signed(rdata_a) % $signed(rdata_b);
            // result_32 = result_64[31:0];
            o_mdu_ready = 1'b1;
            done = 1'b1;
          end
        end
        3'b111: begin  // REMU
          if (en_q) begin
            result_32 = $unsigned(rdata_a) % $unsigned(rdata_b);
            // result_32 = result_64[31:0];
            o_mdu_ready = 1'b1;
            done = 1'b1;
          end
        end
        default: begin
          result_32 = 32'hffffffff;
          result_64 = {result_32,result_32};
          o_mdu_ready = 1'b1;
        end
      endcase
    end
  end

//  TODO: Set the transmission side from core part
endmodule
`default_nettype wire