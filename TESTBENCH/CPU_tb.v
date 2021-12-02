module CPU_tb(
    
);
    logic [31:0] data_in;
    logic [31:0] instr;
    logic     clk;
    logic     reset;
    logic     clock_enable;

    logic [31:0] reg_v0;
    logic[31:0]  PC;
    logic[31:0]   data_address;
    logic[31:0]   data_out;
    logic   active;
    logic   data_read;
    logic   data_write;



    

    initial begin
       clk = 0;
       repeat (100000) begin
            #1 clk = !clk;
        end 
    end
 
    initial begin
    $dumpfile("CPU_TB.vcd");
    $dumpvars(0, CPU_tb);
        #1
        clock_enable = 1;
        reset = 1;

        $display("ROM MODULE RESULTS:");
        

        @(posedge clk);
        reset = 0;
        $display("CPU started");


        repeat (15) begin
            @(posedge clk)
            $display("REG_V0 = %d", reg_v0);
        end 

        
        


    end

       ROM_module MEM(
        .addr(PC),
        .instruction(instr)
    );

    MIPS5 CPU(
          .data_in(data_in), .instr(instr), .clk(clk), .reset(reset), .clock_enable(clock_enable),
        .reg_v0(reg_v0), .PC(PC), .data_address(data_address), .data_out(data_out), .active(active), 
        .data_read(data.read), .data_write(data_write)
    
    
    );


endmodule