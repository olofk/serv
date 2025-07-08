`default_nettype none
module complete_bridge
  #(parameter AW = 13)
  (
   input wire i_clk,
   input wire i_rst,

   // AXI2WB WISHBONE SIGNALS FROM BRIDGE TO SERVING
   output reg [AW-1:2] o_mwb_adr,
   output reg [31:0] o_mwb_dat,
   output reg [3:0] o_mwb_sel,
   output reg o_mwb_we,
   output reg o_mwb_stb,

   input wire [31:0] i_mwb_rdt,
   input wire i_mwb_ack,
   
   //WB2AXI WISHBONE SIGNALS FROM SERVING TO BRIDGE
   input wire [AW-1:2] i_swb_adr,
   input wire [31:0] i_swb_dat,
   input wire [3:0] i_swb_sel,
   input wire i_swb_we,
   input wire i_swb_stb,

   output reg [31:0] o_swb_rdt,
   output reg o_swb_ack,
  

   // AXI2WB AXI SIGNALS FROM EXTERNAL(BUS/PERIPHERAL/ADAPTER) TO BRIDGE
   // AXI adress write channel
   input wire [AW-1:0] i_awaddr,
   input wire i_awvalid,
   output reg o_awready,
   //AXI adress read channel
   input wire [AW-1:0] i_araddr,
   input wire i_arvalid,
   output reg o_arready,
   //AXI write channel
   input wire [31:0] i_wdata,
   input wire [3:0] i_wstrb,
   input wire i_wvalid,
   output reg o_wready,
   //AXI response channel
   output wire [1:0] o_bresp,
   output reg o_bvalid,
   input wire i_bready,
   //AXI read channel
   output reg [31:0] o_rdata,
   output wire [1:0] o_rresp,
   output wire o_rlast,
   output reg o_rvalid,
   input wire i_rready,
   
   
   // AXI2WB AXI SIGNALS FROM BRIDGE TO EXTERNAL(PERIPHERAL/ADAPTER/BUS)
   // AXI adress write channel
   output reg [AW-1:0] o_awmaddr,
   output reg o_awmvalid,
   input wire i_awmready,
   //AXI adress read channel
   output reg [AW-1:0] o_armaddr,
   output reg o_armvalid,
   input wire i_armready,
   //AXI write channel
   output reg [31:0] o_wmdata,
   output reg [3:0] o_wmstrb,
   output reg o_wmvalid,
   input wire i_wmready,
   //AXI response channel
   input wire [1:0] i_bmresp,
   input wire i_bmvalid,
   output reg o_bmready,
   //AXI read channel
   input wire[31:0] i_rmdata,
   input wire [1:0] i_rmresp,
   input wire i_rmlast,
   input wire i_rmvalid,
   output reg o_rmready
   );

localparam          bridge_idle=4'd0, 
                    AXI2WB_start=4'd1,     //AXI2WB BRIDGE STATES:START
                    AXI2WB_WBWACK= 4'd2,           
                    AXI2WB_AWACK=4'd3, 
                    AXI2WB_WBRACK = 4'd4 ,
                    AXI2WB_BAXI = 4'd5,
                    AXI2WB_RRAXI = 4'd6,     //AXI2WB BRIDGE STATES:END
                    WB2AXI_start=4'd7,       //WB2AXI BRIDGE STATES:START
                    WBREAD=4'd8, 
                    WBWRITE=4'd9, 
                    WB2AXI_WRESP= 4'd10,     //WB2AXI BRIDE STATES:END
                    WB2AXI_RRESP= 4'd11;
reg [3:0] state, next_state;
reg arbiter;
 assign o_bresp = 2'b00;
 assign o_rresp = 2'b00;
 assign o_rlast = 1'b1;

// present state sequential logic
always @(posedge i_clk)  begin
    if(i_rst) 
        state <= bridge_idle;
    else
        state <= next_state;
end

//next state combinational logic
always @(*) begin
    case(state)
        bridge_idle: next_state <= (i_awvalid || i_arvalid)? AXI2WB_start: 
                                   (i_swb_stb)?WB2AXI_start:
                                   bridge_idle;
        
        AXI2WB_start: next_state <= (i_awvalid && arbiter) ? (i_wvalid ? AXI2WB_WBWACK : AXI2WB_AWACK) :
                                    (i_arvalid) ? AXI2WB_WBRACK :
                                     AXI2WB_start;
        AXI2WB_AWACK: next_state <= (i_wvalid)? AXI2WB_WBWACK :AXI2WB_AWACK;
        AXI2WB_WBWACK: next_state <= (i_mwb_ack) ? AXI2WB_BAXI : AXI2WB_WBWACK;
        AXI2WB_WBRACK: next_state <= (i_mwb_ack) ? AXI2WB_RRAXI : AXI2WB_WBRACK;
        AXI2WB_BAXI: next_state <= (i_bready) ? bridge_idle : AXI2WB_BAXI;
        AXI2WB_RRAXI: next_state <= (i_rready) ? bridge_idle : AXI2WB_RRAXI;
        
        WB2AXI_start: next_state <= i_swb_we ? (i_awmready ? WBWRITE : WB2AXI_start) 
                                               :(i_armready ? WBREAD : WB2AXI_start) ;
                                   

       WBWRITE: next_state <=(i_wmready)? WB2AXI_WRESP: WBWRITE;
       WBREAD: next_state <= (i_rmvalid)? WB2AXI_RRESP: WBREAD;
       WB2AXI_WRESP: next_state <= bridge_idle;
       WB2AXI_RRESP: next_state <= bridge_idle;
       default: next_state <= bridge_idle;
    endcase
end
//output sequential logic
    always @(posedge i_clk) begin
      if (i_rst)  begin
         //RESETTING ALL OUTPUT VALUES OF BRIDGE SIGNALS TO ZERO
         //AXI SIGNALS (AXI2WB)
          o_awready <= 1'b0;
          o_arready <= 1'b0;
          o_wready <= 1'b0;
          o_bvalid <= 1'b0;
          o_rdata <= 32'b0;
          o_rvalid <= 1'b0;
         //AXI SIGNALS (WB2AXI)
          o_awmaddr <= {AW{1'b0}};
          o_awmvalid <= 1'b0;
          o_armvalid <= 1'b0;
          o_armaddr <= {AW{1'b0}};
          o_wmdata <= 32'b0;
          o_wmstrb <= 4'b0;
          o_wmvalid <= 1'b0;
          o_bmready <= 1'b0;
          o_rmready <= 1'b0;
          
        // WISHBONE SIGNALS (AXI2WB)
         o_mwb_adr <= {AW-2{1'b0}};
         o_mwb_dat <= 32'b0;
         o_mwb_sel <= 4'b0;
         o_mwb_we <= 1'b0;
         o_mwb_stb <= 1'b0;
         // WISHBONE SIGNALS (WB2AXI)
         o_swb_rdt <= 32'b0;
         o_swb_ack <= 1'b0;
         //sel lines
         sel_radr <=1'b0;    //1 for external 0 for internal
         sel_wadr <=1'b0;    //1 for external 0 for internal         
         sel_wdata <= 1'b0;  //1 for external 0 for internal
         sel_rdata <= 1'b1;  //1 to return rdt to interface and 0 to return rdt to brg
         sel_wen <=1'b0;     //1 for external 0 for internal 
      end
      else begin
      
    case(state) 
    bridge_idle : begin
         //AXI SIGNALS (AXI2WB)
          o_awready <= 1'b0;
          o_arready <= 1'b0;
          o_wready <= 1'b0;
          o_bvalid <= 1'b0;
          o_rdata <= 32'b0;
          o_rvalid <= 1'b0;
          arbiter <= 1'b1;
         //AXI SIGNALS (WB2AXI)
          o_awmaddr <= {AW{1'b0}};
          o_awmvalid <= 1'b0;
          o_armvalid <= 1'b0;
          o_armaddr <= {AW{1'b0}};
          o_wmdata <= 32'b0;
          o_wmstrb <= 4'b0;
          o_wmvalid <= 1'b0;
          o_bmready <= 1'b0;
          o_rmready <= 1'b0;
         // WISHBONE SIGNALS (AXI2WB)
         o_mwb_adr <= {AW-2{1'b0}};
         o_mwb_dat <= 32'b0;
         o_mwb_sel <= 4'b0;
         o_mwb_we <= 1'b0;
         o_mwb_stb <= 1'b0;
         // WISHBONE SIGNALS (WB2AXI)
         o_swb_rdt <= 32'b0;
         o_swb_ack <= 1'b0;
         //sel lines
          sel_radr <=1'b0;    //1 for external 0 for internal
          sel_wadr <=1'b0;    //1 for external 0 for internal         
          sel_wdata <= 1'b0;  //1 for external 0 for internal
          sel_rdata <= 1'b1;  //1 to return rdt to interface and 0 to return rdt to brg
          sel_wen <=1'b0;     //1 for external 0 for internal
    end
    
// AXI2WB Bridge states start  /////
        AXI2WB_start: begin
            if (i_awvalid && arbiter) begin
                o_mwb_adr[AW-1:2] <= i_awaddr[AW-1:2];
                o_awready <= 1'b1;
                arbiter <= 1'b0;
                //sel lines asserted for external read and write to serving ram
                sel_wadr <= 1'b1;
                sel_radr <= 1'b1;
                sel_wen  <= 1'b1;
                sel_rdata<= 1'b0;
                sel_wdata<= 1'b1;
                

                if (i_wvalid) begin               
                    o_mwb_stb <= 1'b1;
                    o_mwb_sel <= i_wstrb;
                    o_mwb_dat <= i_wdata[31:0];
                    o_mwb_we <= 1'b1;
                    o_wready <= 1'b1;
//sel lines asserted for external read and write to serving ram
                    sel_wadr <= 1'b1;
                    sel_radr <= 1'b1;
                    sel_wen  <= 1'b1;
                    sel_rdata<= 1'b0;
                    sel_wdata<= 1'b1;
                 end
            end
            else if (i_arvalid) begin
                 o_mwb_adr[AW-1:2] <= i_araddr[AW-1:2];
                 o_mwb_sel <= 4'hF;
                 o_mwb_stb <= 1'b1;
                 o_arready <= 1'b1;
                 o_mwb_we <= 1'b0;
//sel lines asserted for external read and write to serving ram
                 sel_wadr <= 1'b1;
                 sel_radr <= 1'b1;
                 sel_wen  <= 1'b1;
                 sel_rdata<= 1'b0;
                 sel_wdata<= 1'b1;
	        end
	   end
        
        AXI2WB_AWACK : begin
              if (i_wvalid) begin
                    o_mwb_stb <= 1'b1;
                    o_mwb_sel <= i_wstrb;
                    o_mwb_dat <= i_wdata[31:0];
                    o_mwb_we <= 1'b1;
                    o_wready <= 1'b1;
//sel lines asserted for external read and write to serving ram
                    sel_wadr <= 1'b1;
                    sel_radr <= 1'b1;
                    sel_wen  <= 1'b1;
                    sel_rdata<= 1'b0;
                    sel_wdata<= 1'b1;
               end
           end

        AXI2WB_WBWACK : begin
              if ( i_mwb_ack ) begin
                 o_mwb_stb <= 1'b0;
                 o_mwb_sel <= 4'h0;
                 o_mwb_we <= 1'b0;
                 o_bvalid <= 1'b1;
//sel lines asserted for external read and write to serving ram
                 sel_wadr <= 1'b1;
                 sel_radr <= 1'b1;
                 sel_wen  <= 1'b1;
                 sel_rdata<= 1'b0;
                 sel_wdata<= 1'b1;
                 
              end
          end

        AXI2WB_WBRACK : begin
              if ( i_mwb_ack) begin
                     o_mwb_stb <= 1'b0;
                     o_mwb_sel <= 4'h0;
                     o_mwb_we <= 1'b0;
                     o_rvalid <= 1'b1;
                     o_rdata <= i_mwb_rdt;
//sel lines asserted for external read and write to serving ram
                     sel_wadr <= 1'b1;
                     sel_radr <= 1'b1;
                     sel_wen  <= 1'b1;
                     sel_rdata<= 1'b0;
                     sel_wdata<= 1'b1; 
                     
              end
           end

        AXI2WB_BAXI : begin
                    o_bvalid <= 1'b1;
 //sel lines asserted for external read and write to serving ram
                    sel_wadr <= 1'b1;
                    sel_radr <= 1'b1;
                    sel_wen  <= 1'b1;
                    sel_rdata<= 1'b0;
                    sel_wdata<= 1'b1;   
                      if (i_bready) begin
                           o_bvalid <= 1'b0; 
                        end                    
               end

        AXI2WB_RRAXI : begin
                      o_rvalid <= 1'b1;
  //sel lines for external read and write to serving ram
                        sel_wadr <= 1'b1;
                        sel_radr <= 1'b1;
                        sel_wen  <= 1'b1;
                        sel_rdata<= 1'b0;
                        sel_wdata<= 1'b1;   
                      if (i_rready)
                         o_rvalid <= 1'b0;
                     end      //AXI2WB Bridge states end 

       ///   WB2AXI BRIDGE AND STATES START  ////
                          WB2AXI_start: begin
                                 o_swb_ack <= 1'b0;
                         //sel lines
                                   sel_radr <=1'b0;    //1 for external 0 for internal
                                   sel_wadr <=1'b0;    //1 for external 0 for internal         
                                   sel_wdata <= 1'b0;  //1 for external 0 for internal
                                   sel_rdata <= 1'b1;  //1 to return rdt to interface and 0 to return rdt to brg
                                   sel_wen <=1'b0;     //1 for external 0 for internal
                                  if (i_swb_we) begin
                                         o_awmvalid <= 1'b1;
                                           if(i_awmready)
                                               o_awmaddr <= {i_swb_adr, 2'b00}; // Convert word address to byte address      
                                     end else begin
                                         o_armvalid <= 1'b1;
                                           if (i_armready)
                                             o_armaddr <= {i_swb_adr, 2'b00};
                                              $display("data read address is: 0x%h",i_swb_adr);
                                     end
                                
                             end
                              
                           WBWRITE: begin
                               o_wmvalid <=1'b1;
                               o_swb_ack <=1'b0;
  //sel lines for internal selection
                             sel_radr <=1'b0;    //1 for external 0 for internal
                             sel_wadr <=1'b0;    //1 for external 0 for internal         
                             sel_wdata <= 1'b0;  //1 for external 0 for internal
                             sel_rdata <= 1'b1;  //1 to return rdt to interface and 0 to return rdt to brg
                             sel_wen <=1'b0;     //1 for external 0 for internal
                               if(i_wmready) begin
                                  o_wmdata <= i_swb_dat;
                                  o_wmstrb <= i_swb_sel;
                                  o_bmready <=1'b1;        
                               end 
                           end
    
                         WB2AXI_WRESP: begin
                                o_bmready <=1'b1;
  //sel lines
                      sel_radr <=1'b0;    //1 for external 0 for internal
                      sel_wadr <=1'b0;    //1 for external 0 for internal         
                      sel_wdata <= 1'b0;  //1 for external 0 for internal
                      sel_rdata <= 1'b1;  //1 to return rdt to interface and 0 to return rdt to brg
                      sel_wen <=1'b0;     //1 for external 0 for internal
                                if(i_bmvalid) begin
                                 o_swb_ack <=1'b1;
                                           if (i_bmresp != 2'b00)
                                                $display("Error while writing");
                                             else  begin
                                                $display("Successfully data written --- message from bridge");
                                                 end
                                end     
                         end 
                         
                          WBREAD: begin
                               o_rmready <=1'b1; 
                                //sel lines
                                 sel_radr <=1'b0;    //1 for external 0 for internal
                                 sel_wadr <=1'b0;    //1 for external 0 for internal         
                                 sel_wdata <= 1'b0;  //1 for external 0 for internal
                                 sel_rdata <= 1'b1;  //1 to return rdt to interface and 0 to return rdt to brg
                                 sel_wen <=1'b0;     //1 for external 0 for internal
                               end 
                               
                          WB2AXI_RRESP: begin
                          //sel lines
                               sel_radr <=1'b0;    //1 for external 0 for internal
                               sel_wadr <=1'b0;    //1 for external 0 for internal         
                               sel_wdata <= 1'b0;  //1 for external 0 for internal
                               sel_rdata <= 1'b1;  //1 to return rdt to interface and 0 to return rdt to brg
                               sel_wen <=1'b0;     //1 for external 0 for internal
                             if (i_rmresp != 2'b00) begin
                                              $display("Error while reading data");
                                          end else if (i_rmlast) begin
                                              o_swb_rdt <= i_rmdata;
                                              o_swb_ack <= 1'b1;
                                              $display("Successfully data read -----message from bridge");
                                              $display("data read is: 0x%h",i_rmdata);
                                          end
                             end
                          default: begin
                              //AXI SIGNALS (AXI2WB)
                               o_awready <= 1'b0;
                               o_arready <= 1'b0;
                               o_wready <= 1'b0;
                               o_bvalid <= 1'b0;
                               o_rdata <= 32'b0;
                               o_rvalid <= 1'b0;
                              //AXI SIGNALS (WB2AXI)
                               o_awmaddr <= {AW{1'b0}};
                               o_awmvalid <= 1'b0;
                               o_armvalid <= 1'b0;
                               o_armaddr <= {AW{1'b0}};
                               o_wmdata <= 32'b0;
                               o_wmstrb <= 4'b0;
                               o_wmvalid <= 1'b0;
                               o_bmready <= 1'b0;
                               o_rmready <= 1'b0;
                               
                             // WISHBONE SIGNALS (AXI2WB)
                              o_mwb_adr <= {AW-2{1'b0}};
                              o_mwb_dat <= 32'b0;
                              o_mwb_sel <= 4'b0;
                              o_mwb_we <= 1'b0;
                              o_mwb_stb <= 1'b0;
                              // WISHBONE SIGNALS (WB2AXI)
                              o_swb_rdt <= 32'b0;
                              o_swb_ack <= 1'b0;
                              //sel lines
                               sel_radr <=1'b0;    //1 for external 0 for internal
                               sel_wadr <=1'b0;    //1 for external 0 for internal         
                               sel_wdata <= 1'b0;  //1 for external 0 for internal
                               sel_rdata <= 1'b1;  //1 to return rdt to interface and 0 to return rdt to brg
                               sel_wen <=1'b0;     //1 for external 0 for internal 
                          end
                         
                        endcase
                     end
                     end
  endmodule
