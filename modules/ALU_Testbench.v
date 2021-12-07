module alu_testbench(

);
    logic[31:0] out;
    logic[31:0] high;
    logic[31:0] low;
    logic[31:0] op1;
    logic[31:0] op2;
    logic [3:0] shamt;
    logic[31:0] instruction;
    logic[5:0] alu_control;
    //logic[15:0] immediate;

    initial begin
    //ADDU
    //Test 1
    op1 = 32'h00000001;
    op2 = 32'h00000001;
    instruction = 32'b00000000010000110000100000100001;
    alu_control = 4'b0001;
    #1
    $display(out);  
    assert(out==$unsigned(op1) + $unsigned(op2));
    $display(out);
    #1;
    //Test 2
    op1 = 32'h00000011;
    op2 = 32'h00000011;
    instruction = 32'b00000000010000110000100000100001;
    alu_control = 4'b1101;
    #1
    $display(out);

    assert(out == (op1 + op2));
    
    #1;
    end

    alu dd(
    .op1(op1),
    .op2(op2),  
    .out(out),
    .high(high),
    .shamt(shamt),
    .low(low),
    .alu_control(alu_control)
    );
endmodule
