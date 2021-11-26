module MIPS5_tb(
); 
    logic[31:0] data_out, data_in;
    logic[31:0] instr; 
    logic[31:0] reg_v0, reg_t1, reg_t0, reg_write;
    logic[31:0] instr_address, data_address;
    logic data_write, data_read; 
    logic active, reset, clk; 
    logic [5:0] OP, reg_addrw; 
    //for now I'm not implementing clock enable because I don't understand it
    
    initial begin 
        clk = 0; 
        repeat (1000) begin 
            #5; 
            clk = !clk; 
        end 
        $finish(0); 
    end 


    //this tb checks the functionality of the simple modules and the cooperation inside the CPU, NOT the RAM addressing (or bus mapping), since the instructions are fed manually
    initial begin 
        $dumpfile ("MIPS5_tb.vcd"); 
        $dumpvars(0, MIPS5_tb); 

        // RESET 
        @(posedge clk); 
        reset = 1;
        #1; 
        $display("reg_t1 = %d, instr_address = %d, data_write = %d, data_read = %d, op = %b", reg_t1, instr_address, data_write, data_read, OP);
        // check that all registers are equal to 0, stampane un paio a caso (estrai gli output con nome temp)
        assert(reg_t1 == 0); 
        assert(reg_v0 == 0); 
        assert(instr_address == 0); 

        //check control signals are paralised
        assert(!data_write); // you need to add it manually to check them because when reset is 0 there is nothing comign from memory
        assert(!data_read); 

         // check active (NOT SURE ABOUT THIS ONE; WHEN SHOULD ACTIVE BE ASSERTED?)
        //assert(active); 

        @(posedge clk); 
        reset = 0; 
        #1;
         // check next PC address (needs to be 0xBFC00000) from previous reset 
        assert(instr_address == 32'hBFC00000); 
        //lw $t1, 8($zero) 
        // lw has OPCODE 0x23 or 0b100011
        instr = 32'b10001100000010010000000000001000;
        #1; 
        $display("instruction is lw $t1, 8(zero)");
        $display("reg_t1 = %d, instr_address = %d, data_write = %d, data_read = %d, op = %b, data_address = %d, reg_addrw = %d", reg_t1, instr_address, data_write, data_read, OP, data_address, reg_addrw);
        assert(data_read); 
        assert(data_address == 8); 
        data_in = 4985; 
        

        @(posedge clk);
        #1; 
        
        assert(reg_t1 == 4985); //from previous cycle, to do this you need to add a special output to the register file
        //addiu $t0, $zero, 12
        // $t0 = 0 + 12
        // opcode of addiu is 0x9 or 0b01001
        instr = 32'b00100100000010000000000000001100;
        #1;
        $display("instruction is addiu $t0, $zero, 12");
        $display("op = %b, reg_t0 =%d, reg_addrw = %d, reg_write = %d", OP, reg_t0, reg_addrw, reg_write);
        assert(!data_read); 
        assert(!data_write);
        assert(active);
       

        @(posedge clk); 
        #1;
         assert(reg_t0 == 12); 
        //jump to zero so that you can check the halting functionality (if the PC is 0 at the next posedge active will go to 0)
        // jr wher r = 0
        instr = 32'b01000;
        #1;
        $display("instruction is jr where r = zero"); 

        @(posedge clk); 
        #1; 
        assert(instr_address == 0); 
        assert(!active);
        
        // addu  $v0, $t1, $t0
        // $v0 = 456 + 12
        instr = 32'b01001010000001000000100001;
        #1; 
        $display("reg_t1 = %d, reg_t0 = %d instr_address = %d, data_write = %d, data_read = %d, op = %b, data_address = %d, reg_addrw = %d", reg_t1, reg_t0,instr_address, data_write, data_read, OP, data_address, reg_addrw);
        @(posedge clk);
        #1;
        assert(reg_v0 == (4985+12));

    end 

    MIPS5 m(
        .clk(clk),
        .data_out(data_out), 
        .instr(instr),
        .reset(reset),

        .data_in(data_in),
        .reg_v0(reg_v0),
        .reg_t1(reg_t1),
        .instr_address(instr_address),
        .data_address(data_address),
        .data_write(data_write),
        .data_read(data_read),
        .active(active), 
        .OP(OP),
        .reg_addrw(reg_addrw),
        .reg_t0(reg_t0),
        .reg_write(reg_write)
    );

endmodule 


        

        
        // check active

        //RESET high only for half a cycle 
        // check that it didn't send everything down as it wasn't high for a full cycle 

        //RESET high for a full cycle
        //check that t1 è di nuovo zero

        


