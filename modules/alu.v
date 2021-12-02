module alu(
    input logic clk,
    input logic [31:0] op1,
    input logic [31:0] op2,
    input logic [3:0] shamt,
    input logic [5:0] alu_control, //opcode is always 0 for this module
    output logic [0:31] out,
    output logic [0:31] out2

); 
    logic [31:0] a;
    logic [31:0] b;
    logic [0:31] high;
    logic [0:31] low;

    always_comb begin
        case(alu_control):
        default: begin end
        4'b0000: begin out = low; out2 = high; end //MulT
        4'b1101 out = a/b;
        //4'1100 = DIVU
        4'b0001: out = $unsigned(op1) + $unsigned(op2); //ADDU
        4'b0010 = out = (op1<op2); //Set on less than SLY
        4'b0100: out = op1&op2;//AND
        4'b0101: out = (op1|op2); //OR
        //4'b0111: out = Load upper immediate (Lui)
        //4'b100111: out = (op1~|op2); //NOR (Doesn't exist in MIPS)
      
        //6'b101010: out = //set on less than immediate
        4'b0010: out = $unsigned(op1) < $unsigned(op2); //SLTU
        4'b0011: out = $unsigned(op1) - $unsigned(op2); //SUBU
        4'b0110: out = (op1^op2); //XOR
        4'b1011: out = $signed(op2) >>> shamt; //arithmetic shift right
        4'b0100: out = op2 << shamt; // SLL Logical Shift left/arithmetic shift left (same operation)
        4'b1010: out = op2 >> shamt; //SRL Logical Shift right.
        4'b0100: out = op2 << op1; // SLLV
        4'b1010: out = op2 >> op1; //SRLV
    endcase
    end
    mult m(.clk(clk), .a(a), .b(b), .high(high), .low(low));
endmodule

