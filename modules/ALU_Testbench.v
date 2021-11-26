module e3_testbench();
    logic [31:0] instruction;
    logic i_type_ALUSrc;

    logic [5:0] Opcode; 
    logic [15:0] immediate;

    #i added immediate and opcode inacse i needed it.

    logic [31:0]alu_a;
    logic [31:0]alu_b;
    logic [31:0]alu_out;
    


    initial begin
        $dumpfile("e3_testbench.vcd");
        $dumpvars(0, e3_testbench);



        instruction=32'b00000010110101100000000000011000;
        assign Opcode = instruction [31:26];
        assign immediate = instruction  [15:0];
        assign alu_a = 32'b11111111111111111111111111111011;
        assign alu_b = 32'b00000000000000000000000000000010;
        #1; 
        assert(i_type_ALUSrc == 0);
        assert(alu_out == alu_a * alu_b);
        
        
        instruction=32'b00000010110101100000000000011001;
        assign Opcode = instruction [31:26];
        assign immediate = instruction  [15:0];
        assign alu_a = 32'b00000000000000000000000000000101;
        assign alu_b = 32'b00000000000000000000000000000010;
        #1;
        assert(i_type_ALUSrc == 0);
        assert(alu_out == alu_a *alu_b);


        instruction=32'b00000010110101101001100000100101;
        assign Opcode = instruction [31:26];
        assign immediate = instruction  [15:0];
        assign alu_a = 32'b00000000000000000000000000000101;
        assign alu_b = 32'b00000000000000000000000000000010;
        #1;
        assert(i_type_ALUSrc == 0);
        assert(alu_out == alu_a | alu_b);
        
       
        instruction=32'b00110110110101100000000000000000;
        assign Opcode = instruction [31:26];
        assign immediate = instruction  [15:0];
        assign alu_a = 32'b00000000000000000000000000000101;
        #1;
        assert(i_type_ALUSrc == 1);
        assert(alu_out == alu_a | immediate);


        instruction=32'b00000010110101101001100000100011;
        assign Opcode = instruction [31:26];
        assign immediate = instruction  [15:0];
        assign alu_a = 32'b00000000000000000000000000000101;
        assign alu_b = 32'b00000000000000000000000000000010;
        #1;
        assert(i_type_ALUSrc == 0);
        assert(alu_out == alu_a - alu_b);


        instruction=32'b00000010110101100000000000011000;
        assign Opcode = instruction [31:26];
        assign immediate = instruction  [15:0];
        assign alu_a = 32'b00000000000000000000000000000101;
        assign alu_b = 32'b00000000000000000000000000000010;
        #1;
        assert(i_type_ALUSrc == 0);
        assert(alu_out == alu_a ^ alu_b);

        instruction=32'b00111010110101100000000000000000;
        assign Opcode = instruction [31:26];
        assign immediate = instruction  [15:0];
        assign alu_a = 32'b00000000000000000000000000000101;
        #1;
        assert(i_type_ALUSrc == 0);
        assert(alu_out == alu_a ^ immediate);

    end

    ALU dd(
        .opcode(opcode),
        .itype(itype),  
        .rtype(rtype),
        .jtype(jtype)
    );
endmodule