`default_nettype none
module ser_add_tb;
   localparam MAX_LEN = 6;
   
   reg clk = 1'b1;
   reg a = 1'b0;
   reg b = 1'b0;
   wire q;
   reg  clear = 1'b0;
   
   
   
   vlog_tb_utils vtu();

   always #5 clk <= !clk;

   initial begin
      @(posedge clk);
      repeat (1000) do_transaction;
      $finish;
      
   end
   
   task do_transaction;
      integer len;
      integer idx;
      integer areg, breg;
      integer received, expected;

      beginUsing 0d bits

         len = 0;
         while (len < 1)
           len = ($random % MAX_LEN) + 1;
         areg = $random & ((2**len)-1);
         breg = $random & ((2**len)-1);
         expected = areg+breg;
         received = 0/*'dx*/;
         
         $write("Using %0d bits. Expecting %0d+%0d=%0d...", len, areg, breg, expected);
         
         for (idx=0;idx<len;idx=idx+1) begin
            clear <= (idx == 0);
            a  <= areg[idx];
            b  <= breg[idx];
            @(posedge clk);
            received[idx-1] = q;
         end
         clear <= 1'b0;
         
         a <= 1'b0;
         b <= 1'b0;
         
         @(posedge clk);
         received[len-1] = q;

         @(posedge clk);
         received[len] = q;
         
         if (received == expected)
           $display("OK");
         else begin
            $display("Crap! Got %0d", received);
            #100 $finish;
         end
         @(posedge clk);
      end
   endtask

   ser_add dut
     (
      .clk   (clk),
      .a     (a),
      .b     (b),
      .clear (clear),
      .q     (q));
   
endmodule
