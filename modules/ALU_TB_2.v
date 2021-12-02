module ALU_TB_2();

logic ALUsrc;
logic[31:0] alu_a, alu_b, alu_out;
logic[31:0] instruction;
logic[5:0] opcode, func_code;
logic[15:0] immediate;

//Note the Machine code is placeholder.
//Only the opcode and func_code portions matter.

initial begin

    //ADDU
    #1;
    //Test 1

    ALUsrc = 0;
    alu_a = 32'h80000000;
    alu_b = 32'h00000001;
    instruction = 32'b00000000010000110000100000100001;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert(alu_out == (alu_a + alu_b))
    #1;

    //Test 2


    ALUsrc = 0;
    alu_a = 32'hfffffffe;
    alu_b = 32'h00000001;
    instruction = 32'b00000000010000110000100000100001;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert(alu_out == (alu_a + alu_b))
    #1;

    //Test 3

    ALUsrc = 0;
    alu_a = 32'h00010001;
    alu_b = 32'h11101110;
    instruction = 32'b00000000010000110000100000100001;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert(alu_out == (alu_a + alu_b))
    #1;

    //AND

    //Test 1

    ALUsrc = 0;
    alu_a = 32'h80000000;
    alu_b = 32'h00000001;
    instruction = 32'b00000000010000110000100000100100;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert(alu_out == (alu_a & alu_b))
    #1;

    //Test 2

    ALUsrc = 0;
    alu_a = 32'hffffffff;
    alu_b = 32'h1f000001;
    instruction = 32'b00000000010000110000100000100100;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert(alu_out == (alu_a & alu_b))
    #1;

    //Test 3

    ALUsrc = 0;
    alu_a = 32'hffffffff;
    alu_b = 32'hffffffff;
    instruction = 32'b00000000010000110000100000100100;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert(alu_out == (alu_a & alu_b))
    #1;

    //ANDI - Here we use the immediate portion

    //Test 1

    ALUsrc = 1;
    alu_a = 32'hffffffff;
    instruction = 32'b00110000010000011111111111111111; 
    immediate = instruction[15:0]; //Immediate = 0xffff
    opcode = instruction[31:26];
    
    assert (alu_out == (alu_a & immediate));
    #1;

    //Test 2

    ALUsrc = 1;
    alu_a = 32'hffffffff;
    instruction = 32'b00110000010000000000000000000000; 
    immediate = instruction[15:0]; //Immediate = 0x0000
    opcode = instruction[31:26];
    
    assert (alu_out == (alu_a & immediate));
    #1;

    //Test 3

    ALUsrc = 1;
    alu_a = 32'hffffffff;
    instruction = 32'b00110000010000010101010101010101; 
    immediate = instruction[15:0]; //Immediate = 0xffff
    opcode = instruction[31:26];
    
    assert (alu_out == (alu_a & immediate));
    #1;

    //DIV

    //Test 1

    ALUsrc = 0;
    alu_a = 32'h00000004;
    alu_b = 32'h00000001;
    instruction = 00000000001000100000000000011010;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert (alu_out = (alu_a/alu_b); //Should give 
    #1;
    //Test2

    ALUsrc = 0;
    alu_a = 32'h00000100;
    alu_b = 32'h00000100;
    instruction = 00000000001000100000000000011010;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert (alu_out = (alu_a/alu_b); //should give 1
    #1;
    //Test 3

    ALUsrc = 0;
    alu_a = 32'hFFFFFFCE; //signed, this is -50 in 2s complement form
    alu_b = 32'h00000005; //5
    instruction = 00000000001000100000000000011010;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert (alu_out = (alu_a/alu_b); //should give -10
    #1;
    //DIVU

    //Test 1

    ALUsrc = 0;
    alu_a = 32'h00010001;
    alu_b = 32'h00010001;
    instruction = 00000000001000100000000000011011;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert (alu_out = (alu_a/alu_b); //Should be 1
    #1;

    //Test 2

    ALUsrc = 0;
    alu_a = 32'hffffffff;
    alu_b = 32'h00000001;
    instruction = 00000000001000100000000000011011;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert (alu_out = (alu_a/alu_b); //Should be equal to alu_a
    #1;

    //Test 3

    ALUsrc = 0;
    alu_a = 32'h000001F4; //500
    alu_b = 32'h00000005; //5
    instruction = 00000000001000100000000000011011;
    opcode = instruction[31:26];
    func_code = instruction[5:0];

    assert (alu_out = (alu_a/alu_b); //Should be 100
    #1;


end


//insert alu module here


endmodule


