`timescale 1ns / 1ps
module debug_dm(
    // Global control
    input  wire        i_clk,
    input  wire        i_rst,
    input  wire        i_cpu_debug, // cpu in debug mode
    // Debug Module Interface (DMI)
    input  wire        i_dmi_req_valid,
    output wire        o_dmi_req_ready,
    input  wire [5:0]  i_dmi_req_address,
    input  wire [1:0]  i_dmi_req_op,
    input  wire [31:0] i_dmi_req_data,
    output reg         o_dmi_rsp_valid,
    input  wire        i_dmi_rsp_ready,
    output reg  [31:0] o_dmi_rsp_data,
    output wire [1:0]  o_dmi_rsp_op,
    // Wishbone bus slave interface
    input  wire [31:0] i_sbus_adr,
    input  wire [31:0] i_sbus_dat,
    input  wire [3:0]  i_sbus_sel,
    input  wire        i_sbus_we,
    input  wire        i_sbus_cyc,
    output reg  [31:0] o_sbus_rdt,
    output reg         o_sbus_ack,
    // CPU control
    output wire        o_cpu_ndmrst,
    output wire        o_cpu_req_halt
);
                        
    //============== RISC-V DM =============
    // DM configurations
    localparam DM_BASE      = 32'hfffff800;
    localparam DM_SIZE      = 32'd256; // debug ROM address space size in bytes
    localparam DM_CODE_BASE = 32'hfffff800;
    localparam DM_PBUF_BASE = 32'hfffff840;
    localparam DM_DATA_BASE = 32'hfffff880;
    localparam DM_SREG_BASE = 32'hfffff8c0;
    // park loop entry points - these need to be sync with the OCD firmware (sw/ocd-firmware/park_loop.S)
    localparam DM_EXC_ENTRY  = DM_CODE_BASE + 0;
    localparam DM_LOOP_ENTRY = DM_CODE_BASE + 8;
    localparam DM_NSCRATCH   = 4'b0001; // number of dscratch registers in CPU
    localparam DM_DATASIZE   = 4'b0001; // number of data registers in memory/CSR space
    localparam DM_DATAADDR   = DM_DATA_BASE[11:0];
    localparam DM_DATAACCESS = 1'b1;
        
    // CPU Bus Interface
    localparam HI_ABB = 31; // high address boundary bit
    localparam LO_ABB = 8;
        
    // Status and Control registers
    localparam SREG_HALT_ACK      = 0;  // CPU is halted in debug mode and waits in loop
    localparam SREG_RESUME_REQ    = 8;  // DM request CPU to resume
    localparam SREG_RESUME_ACK    = 8;  // CPU starts resuming
    localparam SREG_EXECUTE_REQ   = 16; // DM requests to execute program buffer
    localparam SREG_EXECUTE_ACK   = 16; // CPU starts to execute program buffer
    localparam SREG_EXCEPTION_ACK = 24; // CPU has detected an exception
    
    // DMI operations
    localparam DMI_OP_NOP     = 2'b00;
    localparam DMI_OP_READ    = 2'b01;
    localparam DMI_OP_WRITE   = 2'b10;
    localparam DMI_OP_RESERVE = 2'B11;
                   
    // DMI registers
    localparam DMI_ADDR_DATA0       = {2'b00, 4'b0100}; // 04
    localparam DMI_ADDR_DMCONTROL   = {2'b01, 4'b0000}; // 10
    localparam DMI_ADDR_DMSTATUS    = {2'b01, 4'b0001}; // 11
    localparam DMI_ADDR_HARTINFO    = {2'b01, 4'b0010}; // 12
    localparam DMI_ADDR_ABSTRACTS   = {2'b01, 4'b0110}; // 16
    localparam DMI_ADDR_COMMAND     = {2'b01, 4'b0111}; // 17
    localparam DMI_ADDR_ABSRACTAUTO = {2'b01, 4'b1000}; // 18
    localparam DMI_ADDR_NEXTDM      = {2'b01, 4'b1101}; // 19
    localparam DMI_ADDR_PROGBUF0    = {2'b10, 4'b0000}; // 20
    localparam DMI_ADDR_PROGBUF1    = {2'b10, 4'b0001}; // 21
    localparam DMI_ADDR_SBCS        = {2'b11, 4'b1000}; // 31
        
    // RISC-V Instruction           
    localparam INSTR_NOP    = 32'h00000013; // NOP
    localparam INSTR_LW     = 32'h00002003; // lw zero, 0(zero)
    localparam INSTR_SW     = 32'h00002023; // sw zero, 0(zero)
    localparam INSTR_EBREAK = 32'h00100073; // ebreak

               
    // DMI access
    wire dmi_wren;
    reg  dmi_wren_delay;
    wire dmi_rden;
    
    reg  r_dmi_req_valid;
    // Output registers
//    reg         o_dmi_rsp_valid;
//    reg [31:0]  o_dmi_rsp_data;
    
//    reg [31:0]  o_sbus_rdt;
//    reg         o_sbus_ack;
    
    // Debug module DMI registers
    reg         dm_reg_dmcontrol_ndmreset;
    reg         dm_reg_dmcontrol_dmactive;
    reg         dm_reg_abstractauto_autoexecdata;
    reg [1:0]   dm_reg_abstractauto_autoexecprogbuf;
    reg [31:0]  dm_reg_progbuf0;
    reg [31:0]  dm_reg_progbuf1;    
    reg [31:0]  dm_reg_command;
    reg         dm_reg_halt_req;
    reg         dm_reg_resume_req;
    reg         dm_reg_reset_ack;
    reg         dm_reg_wr_acc_err;
    reg         dm_reg_rd_acc_err;
    reg         dm_reg_clr_acc_err;
    reg         dm_reg_autoexec_wr;
    reg         dm_reg_autoexec_rd;
    
    // CPU program buffer
    wire [31:0] cpu_progbuf0;
    wire [31:0] cpu_progbuf1;
    wire [31:0] cpu_progbuf2;
    wire [31:0] cpu_progbuf3;
   
    // Debug Core Interface (DCI)
    reg         dci_halt_ack;
    wire        dci_resume_req;
    reg         dci_resume_ack;
    reg         dci_execute_req;
    reg         dci_execute_ack;
    reg         dci_exception_ack;
    reg [255:0] dci_progbuf;
    wire        dci_data_we;
    wire        dci_data_autowe;
    wire [31:0] dci_wdata;
    wire [31:0] dci_rdata;
    
    wire misc_mem = i_dmi_req_data[6:2] == 5'b00011;
    
    // Global access control
    wire       acc_en;
    wire       rden;
    wire       wren;
    wire [1:0] maddr;
    
    // Data buffer
    reg [31:0] data_buf;
    
    // Program buffer access
    reg [31:0] prog_buf0;
    reg [31:0] prog_buf1;
    reg [31:0] prog_buf2;
    reg [31:0] prog_buf3;
    
    // Debug module control registers
    wire        dm_ctrl_busy;
    reg [31:0]  dm_ctrl_ldsw_progbuf;
    reg         dm_ctrl_pbuf_en;
    // error flag
    reg         dm_ctrl_illegal_state;
    reg         dm_ctrl_illegal_cmd;
    reg [2:0]   dm_ctrl_cmderr;
    // hart status
    reg         dm_ctrl_hart_halted;
    reg         dm_ctrl_hart_resume_req;
    reg [1:0]   dm_ctrl_hart_resume_state;
    reg         dm_ctrl_hart_resume_ack;
    reg         dm_ctrl_hart_reset;
        
    /*================================================================
    ============ Debug Module (DM) control FSM =======================
    ================================================================*/
    localparam CMD_IDLE         = 0,
               CMD_EXE_CHECK    = 1,
               CMD_EXE_PREAPRE  = 2,
               CMD_EXE_TRIGGER  = 3,
               CMD_EXE_BUSY     = 4,
               CMD_EXE_ERROR    = 5;
    
    reg [2:0] dm_ctrl_state;

    always @(posedge i_clk)
        if (i_rst) dm_ctrl_state <= CMD_IDLE;
        else
            case (dm_ctrl_state)
                CMD_IDLE        : // wait for abstract command
                    if (dmi_wren && (dm_ctrl_cmderr == 3'b000) && (i_dmi_req_address == DMI_ADDR_COMMAND))
                        dm_ctrl_state <= CMD_EXE_CHECK;
                    else if ((dm_reg_autoexec_rd == 1'b1) || ((dm_reg_autoexec_wr == 1'b1) && o_dmi_rsp_valid))
                        dm_ctrl_state <= CMD_EXE_CHECK;
                CMD_EXE_CHECK   : // check if command is valid / supported
                    if ((dm_reg_command[31:24] == 8'h00)    &&
                        (dm_reg_command[23] == 1'b0)        &&
                        (dm_reg_command[22:20] == 3'b010)   &&
                        (dm_reg_command[19] == 1'b0)        &&
                        ((dm_reg_command[17] == 1'b0) || (dm_reg_command[15:5] == 11'b000_1000_0000)))
                    begin
                        if (dm_ctrl_hart_halted == 1'b1) // CPU is halted
                            dm_ctrl_state <= CMD_EXE_PREAPRE;
                        else // error CPU is still running
                            dm_ctrl_state <= CMD_EXE_ERROR;            
                    end
                    else // Invalid command
                        dm_ctrl_state <= CMD_EXE_ERROR;    
                CMD_EXE_PREAPRE : // setup program buffer
                    dm_ctrl_state <= CMD_EXE_TRIGGER;    
                CMD_EXE_TRIGGER : // request cpu to execute command
                    if (dci_execute_ack) // CPU start execution
                        dm_ctrl_state <= CMD_EXE_BUSY;      
                CMD_EXE_BUSY    : // wait for cpu to finish
                    if (dci_halt_ack) // CPU halted again
                        dm_ctrl_state <= CMD_IDLE;
                CMD_EXE_ERROR   :
                    dm_ctrl_state <= CMD_IDLE;
                default: dm_ctrl_state <= CMD_IDLE;
            endcase
    
    /*================================================================
    ============================ RTL =================================
    ================================================================*/
    // DMI access
    assign dmi_wren = i_dmi_req_valid && (i_dmi_req_op == DMI_OP_WRITE);
    assign dmi_rden = i_dmi_req_valid && (i_dmi_req_op == DMI_OP_READ);
    
    always @(posedge i_clk) begin
        if (i_rst) dmi_wren_delay <= 1'b0;
        else if (dm_reg_abstractauto_autoexecdata) begin
            if (dmi_wren) dmi_wren_delay <= 1'b1;
            else if (dmi_wren_delay && (!dm_ctrl_busy)) dmi_wren_delay <= 1'b0;
        end
        else dmi_wren_delay <= 1'b0;
    end
    
    // Debug module command controller
    always @(posedge i_clk)
        if (i_rst) dci_execute_req <= 1'b0;
        else dci_execute_req <= dm_ctrl_state == CMD_EXE_TRIGGER;
    
    always @(posedge i_clk)
        if (i_rst) begin
            dm_ctrl_ldsw_progbuf  <= INSTR_SW;
            dm_ctrl_pbuf_en       <= 1'b0;
            dm_ctrl_illegal_cmd   <= 1'b0;
            dm_ctrl_illegal_state <= 1'b0;
            dm_ctrl_cmderr        <= 3'b000;
        end
        else begin
            if (dm_ctrl_state == CMD_EXE_PREAPRE)
                if (dm_reg_command[17] == 1'b1) // transfer
                    if (dm_reg_command[16] == 1'b0) // Read from GPR
                    begin
                        dm_ctrl_ldsw_progbuf[31:25] <= DM_DATAADDR[11:5]; // Destination address
                        dm_ctrl_ldsw_progbuf[24:20] <= dm_reg_command[4:0]; // source register
                        dm_ctrl_ldsw_progbuf[19:12] <= INSTR_SW[19:12];
                        dm_ctrl_ldsw_progbuf[11:7]  <= DM_DATAADDR[4:0]; // Destination address   
                        dm_ctrl_ldsw_progbuf[6:0]   <= INSTR_SW[6:0];
                    end
                    else // Write to GPR
                    begin
                        dm_ctrl_ldsw_progbuf[31:20] <= DM_DATAADDR;         // Source register
                        dm_ctrl_ldsw_progbuf[19:12] <= INSTR_LW[19:12];
                        dm_ctrl_ldsw_progbuf[11:7]  <= dm_reg_command[4:0]; // Destination register
                        dm_ctrl_ldsw_progbuf[6:0]   <= INSTR_LW[6:0];
                    end
                else dm_ctrl_ldsw_progbuf <= INSTR_NOP;
                
           dm_ctrl_pbuf_en <= dm_reg_command[18];
           
           dm_ctrl_illegal_cmd <= !((dm_reg_command[31:24] == 8'h00) &&
                                  (dm_reg_command[23] == 1'b0)      &&
                                  (dm_reg_command[22:20] == 3'b010) &&
                                  (dm_reg_command[19] == 1'b0)      &&
                                  ((dm_reg_command[17] == 1'b0) || (dm_reg_command[15:5] == 11'b000_1000_0000))) &&
                                  (dm_ctrl_state == CMD_EXE_CHECK); 
                                  
           dm_ctrl_illegal_state <= ((dm_reg_command[31:24] == 8'h00) &&
                                  (dm_reg_command[23] == 1'b0)      &&
                                  (dm_reg_command[22:20] == 3'b010) &&
                                  (dm_reg_command[19] == 1'b0)      &&
                                  ((dm_reg_command[17] == 1'b0) || (dm_reg_command[15:5] == 11'b000_1000_0000))) &&
                                  (dm_ctrl_state == CMD_EXE_CHECK) &&
                                  (dm_ctrl_hart_halted == 1'b0);
           
           if (dm_ctrl_cmderr == 3'b000) begin // ready to set new error
                if (dm_ctrl_illegal_state) // cannot execute since hart is not in expected state
                    dm_ctrl_cmderr <= 3'b100;
                else if (dci_exception_ack) // exception during execution
                    dm_ctrl_cmderr <= 3'b011;
                else if (dm_ctrl_illegal_cmd) // unsupported command
                    dm_ctrl_cmderr <= 3'b010;
                else if (dm_reg_rd_acc_err || dm_reg_wr_acc_err)
                    dm_ctrl_cmderr <= 3'b001;
           end
           else if (dm_reg_clr_acc_err == 1'b1) // acknowledge/clear error flags 
                dm_ctrl_cmderr <= 3'b000;                              
        end
    
    assign dm_ctrl_busy = !(dm_ctrl_state == CMD_IDLE);
    
    // Hart status
    always @(posedge i_clk)
        if (i_rst) begin
          dm_ctrl_hart_halted     <= 1'b0;
          dm_ctrl_hart_resume_req <= 1'b0;
          dm_ctrl_hart_resume_ack <= 1'b0;
          dm_ctrl_hart_reset      <= 1'b0;
          dm_ctrl_hart_resume_state <= 2'b00;            
        end
        else begin
            // HALTED ACK
            if (dm_reg_dmcontrol_ndmreset == 1'b1)
                dm_ctrl_hart_halted <= 1'b0;
            else if (dci_halt_ack == 1'b1)
                dm_ctrl_hart_halted <= 1'b1;
            else if (dci_resume_ack == 1'b1)
                dm_ctrl_hart_halted <= 1'b0;  
            
          if (dm_reg_dmcontrol_ndmreset == 1'b1)
            dm_ctrl_hart_resume_state <= 2'b00; // idle
          else begin
            case (dm_ctrl_hart_resume_state)
                2'b00: dm_ctrl_hart_resume_state <= dm_reg_resume_req? 2'b01: 2'b00;    // idle
                2'b01: dm_ctrl_hart_resume_state <= dci_resume_ack? 2'b10: 2'b01;       // active
                2'b10: dm_ctrl_hart_resume_state <= !dm_reg_resume_req? 2'b00: 2'b10;   // unactive
                default: dm_ctrl_hart_resume_state <= 2'b00;
            endcase
          end
          
          if (dm_reg_dmcontrol_ndmreset == 1'b1)
            dm_ctrl_hart_resume_req <= 1'b0;
          else dm_ctrl_hart_resume_req <= dm_ctrl_hart_resume_state == 2'b01;
                    
          // RESUME ACK
          if (dm_reg_dmcontrol_ndmreset == 1'b1)
            dm_ctrl_hart_resume_ack <= 1'b0;
          else if (dci_resume_ack == 1'b1)
            dm_ctrl_hart_resume_ack <= 1'b1;
          else if ((dm_reg_resume_req == 1'b1) && (dm_ctrl_hart_resume_state == 2'b00))
            dm_ctrl_hart_resume_ack <= 1'b0;
              
          // hart has been RESET
          if (dm_reg_dmcontrol_ndmreset == 1'b1) // explicit RESET triggered by DM
            dm_ctrl_hart_reset <= 1'b1;
          else if (dm_reg_reset_ack == 1'b1)
            dm_ctrl_hart_reset <= 1'b0;        
        end
  
  
  
   // Debug Module Interface - Write access
  always @(posedge i_clk)
    if (i_rst)
    begin
      dm_reg_dmcontrol_ndmreset <= 1'b0; // no system SoC reset
      dm_reg_dmcontrol_dmactive <= 1'b0; // DM is in reset state after hardware reset
      
      dm_reg_halt_req    <= 1'b0;
      dm_reg_resume_req  <= 1'b0;
      dm_reg_reset_ack   <= 1'b0;
      dm_reg_wr_acc_err  <= 1'b0;
      dm_reg_clr_acc_err <= 1'b0;
      dm_reg_autoexec_wr <= 1'b0;
      
      dm_reg_abstractauto_autoexecdata    <= 1'b0;
      dm_reg_abstractauto_autoexecprogbuf <= 2'b00;
      
      dm_reg_command <= 32'd0;
      dm_reg_progbuf0 <= INSTR_NOP;
      dm_reg_progbuf1 <= INSTR_NOP;
    end
    else if (dmi_wren) // valid DMI write request
    begin
      if (i_dmi_req_address == DMI_ADDR_DMCONTROL) begin
        dm_reg_dmcontrol_ndmreset <= i_dmi_req_data[1]; // ndmreset (r/w): soc reset
        dm_reg_dmcontrol_dmactive <= i_dmi_req_data[0]; // dmactive (r/w): DM reset
        dm_reg_halt_req           <= i_dmi_req_data[31];
      end
      
      dm_reg_resume_req   <= i_dmi_req_data[30] && (i_dmi_req_address == DMI_ADDR_DMCONTROL); // resumereq (-/w1): write 1 to request resume; auto-clears
      dm_reg_reset_ack    <= i_dmi_req_data[28] && (i_dmi_req_address == DMI_ADDR_DMCONTROL); // ackhavereset (-/w1): write 1 to ACK reset; auto-clears
      // Invalid access while command is executing
      dm_reg_wr_acc_err   <= dm_ctrl_busy &&      
                       ((i_dmi_req_address == DMI_ADDR_ABSTRACTS)   ||
                        (i_dmi_req_address == DMI_ADDR_COMMAND)     ||
                        (i_dmi_req_address == DMI_ADDR_ABSRACTAUTO) ||
                        (i_dmi_req_address == DMI_ADDR_DATA0)       ||
                        (i_dmi_req_address == DMI_ADDR_PROGBUF0)    ||
                        (i_dmi_req_address == DMI_ADDR_PROGBUF1));
      // ACK command error
      dm_reg_clr_acc_err  <= (i_dmi_req_address == DMI_ADDR_ABSTRACTS) &&
                             (i_dmi_req_data[10:8] == 3'b111);
      // Auto execution trigger                
      dm_reg_autoexec_wr  <= ((i_dmi_req_address == DMI_ADDR_DATA0) && dm_reg_abstractauto_autoexecdata)          ||
                             ((i_dmi_req_address == DMI_ADDR_PROGBUF0) && dm_reg_abstractauto_autoexecprogbuf[0]) ||
                             ((i_dmi_req_address == DMI_ADDR_PROGBUF1) && dm_reg_abstractauto_autoexecprogbuf[1]);
      
     
      // Write abstract command autoxec
      if (i_dmi_req_address == DMI_ADDR_ABSRACTAUTO)
        if (!dm_ctrl_busy) begin
            dm_reg_abstractauto_autoexecdata <= i_dmi_req_data[0];
            dm_reg_abstractauto_autoexecprogbuf[0] <= i_dmi_req_data[16];
            dm_reg_abstractauto_autoexecprogbuf[1] <= i_dmi_req_data[17];       
        end
        
     
     // Write abstract command
     if (i_dmi_req_address == DMI_ADDR_COMMAND)
        if (!dm_ctrl_busy && (dm_ctrl_cmderr == 3'b000))
            dm_reg_command <= i_dmi_req_data;
            
            
     // Write program bufer
     if (i_dmi_req_address[5:1] == DMI_ADDR_PROGBUF0[5:1])
        if (!dm_ctrl_busy)   
            if (~i_dmi_req_address[0])
                dm_reg_progbuf0 <= misc_mem? INSTR_NOP: i_dmi_req_data;
            else
                dm_reg_progbuf1 <= misc_mem? INSTR_NOP: i_dmi_req_data;                              
   end
            
   // ===== Direct control ====================================
   // Abtract data register
   assign dci_data_we     = dmi_wren && (i_dmi_req_address == DMI_ADDR_DATA0) && (!dm_ctrl_busy);
   assign dci_data_autowe = dmi_wren_delay && (i_dmi_req_address == DMI_ADDR_DATA0) && (!dm_ctrl_busy);
   assign dci_wdata       = i_dmi_req_data;   

   // CPU halt/resume request
  assign o_cpu_req_halt = dm_reg_halt_req && dm_reg_dmcontrol_dmactive; // single-shot
  assign dci_resume_req = dm_ctrl_hart_resume_req; // active until explicitly cleared   
   
  // SOC reset
  assign o_cpu_ndmrst =  dm_reg_dmcontrol_ndmreset && dm_reg_dmcontrol_dmactive; // to processor's reset generator
  
  // construct program buffer array for CPU access
  assign cpu_progbuf0 = dm_ctrl_ldsw_progbuf; // pseudo program buffer for GPR access
  assign cpu_progbuf1 = !dm_ctrl_pbuf_en? INSTR_NOP : dm_reg_progbuf0;
  assign cpu_progbuf2 = !dm_ctrl_pbuf_en? INSTR_NOP : dm_reg_progbuf1;
  assign cpu_progbuf3 = INSTR_EBREAK; // implicit ebreak instruction
  
  // DMI status
  assign o_dmi_rsp_op    = 2'b00; // operation success
  assign o_dmi_req_ready = 1'b1; // always ready for new read/write
  
  // ===== Debug Module Interface ==========================ndmodule
  // Read access
  always @(posedge i_clk)
  begin
    o_dmi_rsp_valid <= i_dmi_req_valid;
    
    if (i_rst) 
        r_dmi_req_valid <= 1'b0;
    else if (i_dmi_req_valid) 
        r_dmi_req_valid <= 1'b1;
    else if (dm_ctrl_state == CMD_IDLE)
        r_dmi_req_valid <= 1'b0;
    
    case (i_dmi_req_address)
        DMI_ADDR_DMSTATUS   : 
        begin
            o_dmi_rsp_data[31:23]   <= 9'd0;
            o_dmi_rsp_data[22]      <= 1'b1;
            o_dmi_rsp_data[21:20]   <= 2'b00;
            o_dmi_rsp_data[19]      <= dm_ctrl_hart_reset;
            o_dmi_rsp_data[18]      <= dm_ctrl_hart_reset;
            o_dmi_rsp_data[17]      <= dm_ctrl_hart_resume_ack;
            o_dmi_rsp_data[16]      <= dm_ctrl_hart_resume_ack;
            o_dmi_rsp_data[15]      <= 1'b0;
            o_dmi_rsp_data[14]      <= 1'b0;
            o_dmi_rsp_data[13]      <= dm_reg_dmcontrol_ndmreset;
            o_dmi_rsp_data[12]      <= dm_reg_dmcontrol_ndmreset;
            o_dmi_rsp_data[11]      <= !dm_ctrl_hart_halted;
            o_dmi_rsp_data[10]      <= !dm_ctrl_hart_halted;
            o_dmi_rsp_data[9]       <= dm_ctrl_hart_halted;
            o_dmi_rsp_data[8]       <= dm_ctrl_hart_halted;
            o_dmi_rsp_data[7]       <= 1'b1;
            o_dmi_rsp_data[6]       <= 1'b0;
            o_dmi_rsp_data[5]       <= 1'b0;
            o_dmi_rsp_data[4]       <= 1'b0;
            o_dmi_rsp_data[3:0]     <= 4'b0011;
        end
        DMI_ADDR_DMCONTROL  : 
        begin
            o_dmi_rsp_data[31]    <= 1'b0;
            o_dmi_rsp_data[30]    <= 1'b0;
            o_dmi_rsp_data[29]    <= 1'b0;
            o_dmi_rsp_data[28]    <= 1'b0;
            o_dmi_rsp_data[27]    <= 1'b0;
            o_dmi_rsp_data[26]    <= 1'b0;
            o_dmi_rsp_data[25:16] <= 10'd0;
            o_dmi_rsp_data[15:6]  <= 10'd0;
            o_dmi_rsp_data[5:4]   <= 2'b00;
            o_dmi_rsp_data[3]     <= 1'b0;
            o_dmi_rsp_data[2]     <= 1'b0;
            o_dmi_rsp_data[1]     <= dm_reg_dmcontrol_ndmreset;
            o_dmi_rsp_data[0]     <= dm_reg_dmcontrol_dmactive;
        end
        DMI_ADDR_HARTINFO   :
        begin
            o_dmi_rsp_data[31:24] <= 8'd0;
            o_dmi_rsp_data[23:20] <= DM_NSCRATCH;
            o_dmi_rsp_data[19:17] <= 3'b000;
            o_dmi_rsp_data[16]    <= DM_DATAACCESS;
            o_dmi_rsp_data[15:12] <= DM_DATASIZE;
            o_dmi_rsp_data[11:0]  <= DM_DATAADDR; 
        end
        DMI_ADDR_ABSTRACTS  :
        begin
            o_dmi_rsp_data[31:29] <= 3'd0;
            o_dmi_rsp_data[28:24] <= 5'b00010;
            o_dmi_rsp_data[23:13] <= 11'd0;
            o_dmi_rsp_data[12]    <= dm_ctrl_busy;
            o_dmi_rsp_data[11]    <= 1'b1;
            o_dmi_rsp_data[10:8]  <= dm_ctrl_cmderr;
            o_dmi_rsp_data[7:4]   <= 4'b0000;
            o_dmi_rsp_data[3:0]   <= 4'b0001;
        end
        DMI_ADDR_ABSRACTAUTO:
        begin
            o_dmi_rsp_data[0] <= dm_reg_abstractauto_autoexecdata;
            o_dmi_rsp_data[15:1] <= 15'd0;
            o_dmi_rsp_data[16] <= dm_reg_abstractauto_autoexecprogbuf[0];
            o_dmi_rsp_data[17] <= dm_reg_abstractauto_autoexecprogbuf[1];
            o_dmi_rsp_data[31:18] <= 14'd0;
        end
        DMI_ADDR_DATA0:
        begin
            o_dmi_rsp_data <= dci_rdata;
        end
        default: o_dmi_rsp_data <= 32'd0;
    endcase
    
    // invalid read access while command is executing
    dm_reg_rd_acc_err <= dmi_rden && dm_ctrl_busy &&
                        ((i_dmi_req_address == DMI_ADDR_DATA0)    || 
                         (i_dmi_req_address == DMI_ADDR_PROGBUF0) || 
                         (i_dmi_req_address == DMI_ADDR_PROGBUF1)); 
                         
    // auto execution trigger
    dm_reg_autoexec_rd <= dmi_rden &&  
                          (((i_dmi_req_address == DMI_ADDR_DATA0)    && dm_reg_abstractauto_autoexecdata)       ||
                           ((i_dmi_req_address == DMI_ADDR_PROGBUF0) && dm_reg_abstractauto_autoexecprogbuf[0]) ||
                           ((i_dmi_req_address == DMI_ADDR_PROGBUF1) && dm_reg_abstractauto_autoexecprogbuf[1]));  
  end
  
  
  //======== CPU Bus Interface ========================================
  // Access control
  assign acc_en = i_sbus_adr[HI_ABB:LO_ABB] == DM_BASE[HI_ABB:LO_ABB];
  assign rden   = acc_en && i_cpu_debug && i_sbus_cyc && !i_sbus_we;
  assign wren   = acc_en && i_cpu_debug && i_sbus_cyc && i_sbus_we;
  assign maddr  = i_sbus_adr[LO_ABB-1 -: 2];
    
  // Write access
  always @(posedge i_clk)
    if (i_rst) begin
        data_buf            <= 32'd0;
        dci_halt_ack        <= 1'b0;
        dci_resume_ack      <= 1'b0;
        dci_execute_ack     <= 1'b0;
        dci_exception_ack   <= 1'b0;       
    end
    else begin
        if (dci_data_we || dci_data_autowe) // DM write acccess
            data_buf <= dci_wdata;
        else if (wren && (maddr == 2'b10))
            data_buf <= i_sbus_dat;
            
        if ((maddr == 2'b11) && wren) begin
            dci_halt_ack        <= i_sbus_sel[0];
            dci_resume_ack      <= i_sbus_sel[1];
            dci_execute_ack     <= i_sbus_sel[2];
            dci_exception_ack   <= i_sbus_sel[3];
        end
        else begin
            dci_halt_ack        <= 1'b0;
            dci_resume_ack      <= 1'b0;
            dci_execute_ack     <= 1'b0;
            dci_exception_ack   <= 1'b0;
        end       
    end
  
  // DM data buffer read access
  assign dci_rdata = data_buf;
  
  // ROM
  wire [3:0]  rom_addr;
  reg  [31:0] rom_rdata;

  always @(*)
    case (rom_addr)
        // Entry point
        0: rom_rdata = 32'h7b241073;  // ffff_f800 csrrw x0, dscratch0, x8 // backup s0 to dscratch0 so we have a GPR available
        // Wait for resume loop
        1: rom_rdata = 32'h8c000023;  // ffff_f804 sb x0, ffff_f8c0(x0)    // ACK that CPU is halted
        2: rom_rdata = 32'h8c204403;  // ffff_f808 lbu x8, ffff_f8c2(x0)   // request to execute program buffer?
        3: rom_rdata = 32'h00041c63;  // ffff_f80c bne x8, x0, 24        // Jump to execute
        4: rom_rdata = 32'h8c104403;  // ffff_f810 lbu x8, ffff_f8c1(x0)   // request to resume?
        5: rom_rdata = 32'hfe0408e3;  // ffff_f814 beq x8, x0, -16         // return to loop or jump to resume
        // Resume
        6: rom_rdata = 32'h8c8000a3;  // ffff_f818 sb x8, ffff_f8c1(x0)    // ACK that CPU is about to resume
        7: rom_rdata = 32'h7b202473;  // ffff_f824 csrrs x8, dscratch0, x0 // restore s0 from dscratch0
        8: rom_rdata = 32'h7b200073;  // ffff_f828 dret                    // exit debug mode
        // Execute   
        9: rom_rdata = 32'h8c000123; //  ffff_f82c sb x0, ffff_f8c2(x0)    // ACK that execution is about to start
        10: rom_rdata = 32'h7b202473; // ffff_f830 csrrs x8, dscratch0, x0 // restore s0 from dscratch0
        11: rom_rdata = 32'h84000067; // ffff_f834 jalr x0, x0, ffff_f840  // jump to beginning of program buffer (PBUF)
        default: rom_rdata = INSTR_NOP;   
    endcase
      
  assign rom_addr = i_sbus_adr[5:2];
  
  // Read access
  always @(posedge i_clk)
  begin
    o_sbus_ack <= rden || wren;
    
    if (rden)
        case (maddr)
            2'b00: o_sbus_rdt <= rom_rdata; 
            2'b01:
                case (i_sbus_adr[3:2])
                    2'b00: o_sbus_rdt <= cpu_progbuf0;  
                    2'b01: o_sbus_rdt <= cpu_progbuf1; 
                    2'b10: o_sbus_rdt <= cpu_progbuf2;  
                    2'b11: o_sbus_rdt <= cpu_progbuf3; 
                    default: o_sbus_rdt <= cpu_progbuf0;
                endcase
            2'b10: o_sbus_rdt <= data_buf;
            2'b11: begin
                o_sbus_rdt[7:0] <= 8'd0;
                o_sbus_rdt[8] <= dci_resume_req;
                o_sbus_rdt[15:9] <= 7'd0;
                o_sbus_rdt[16] <= dci_execute_req;
                o_sbus_rdt[31:17] <= 15'd0;   
            end
            default: o_sbus_rdt <= 32'd0;
        endcase  
  end
  
endmodule
