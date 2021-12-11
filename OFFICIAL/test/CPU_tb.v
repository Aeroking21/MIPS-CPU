module CPU_tb(
    
);
    logic     clk;
    logic     reset;
    logic    active;
    logic [31:0] register_v0;

    /* New clock enable. See below. */
    logic     clock_enable;

    /* Combinatorial read access to instructions */
    logic[31:0]  instr_address;
    logic[31:0]   instr_readdata;

    /* Combinatorial read and single-cycle write access to instructions */
    logic[31:0]  data_address;
    logic        data_write;
    logic        data_read;
    logic[31:0]  data_writedata;
    logic[31:0]  data_readdata;
   // logic[31:0] dummy;



    

    initial begin
       clk = 0;
       repeat (100000) begin
            #1 clk = !clk;
        end 
    end
 
    initial begin
    $dumpfile("CPU_TB.vcd");
    $dumpvars(0, CPU_tb);

      /*  $display("ROM MODULE RESULTS:");
        instr_address = 32'hBFC00000;
        $display("ROM_RESET_VECTOR[%h] = %h ", instr_address, instr_readdata);
        #1
        instr_address = 3217031172;
        $display("ROM_RESET_VECTOR[%h] = %h ", instr_address, instr_readdata);
        #1
        instr_address = 3217031176;
        $display("ROM_RESET_VECTOR[%h] = %b ", instr_address, instr_readdata);
        #1
        instr_address = 3217031180;
        $display("ROM_RESET_VECTOR[%h] = %b ", instr_address, instr_readdata); */


        #1
        clock_enable = 1;
        reset = 1;

        $display("ROM MODULE RESULTS:");
        

        @(posedge clk);
        reset = 0;
        $display("CPU started");


        repeat (15) begin
            @(posedge clk)
            $display("REG_V0 = %d", register_v0);
            
        end 

        
        


    end

       ROM_module MEM(
        .addr(instr_address),
        .instruction(instr_readdata)
    );

    RAM_module ramx(
    .addr(data_address),
    .data_in(data_writedata),
    .data_read(data_read),
    .data_write(data_write),
    .data_out(data_readdata)
    );

    mips_cpu_harvard CPU(
        .instr_readdata(instr_readdata), .clk(clk), .reset(reset), .clock_enable(clock_enable),
        .register_v0(register_v0), .instr_address(instr_address), .data_address(data_address), .data_writedata(data_writedata), .active(active), 
        .data_readdata(data_readdata), .data_write(data_write), .data_read(data_read)
    
    
    );


endmodule