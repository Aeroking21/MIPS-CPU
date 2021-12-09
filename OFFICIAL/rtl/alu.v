module alu(
    input logic [31:0] op1,
    input logic [31:0] op2,
    input logic [3:0] alu_control, //opcode is always 0 for this module
    output logic [0:31] low,
    output logic [0:31] high,
    output logic [0:31] out
); 
    logic [63:0] divmult_out;

    always_comb begin
        case(alu_control)
            default: begin end
            4'b0000: begin //MULT
                divmult_out = $signed(op1)* $signed(op2);
                out = 0;
            end
            4'b1001: begin //MULTU
                divmult_out = $unsigned(op1)* $unsigned(op2);
                out = 0;
            end

            4'b1101: begin //DIV
                divmult_out[31:0] = $signed(op1)/$signed(op2);
                divmult_out[63:32] = $signed(op1) % $signed(op2); 
                out = 0; end

            4'b1100: begin //DIVU
                divmult_out[31:0] = ($unsigned(op1)) / ($unsigned(op2));
                divmult_out[63:32] = $unsigned(op1) % $unsigned(op2); 
                out = 0; end

            4'b0001: out = $unsigned(op1) + $unsigned(op2); //ADDU
            4'b0010: out = op1<op2; //Set on less than - SLT
            4'b0011: out = $unsigned(op1) < $unsigned(op2); //SLTU
            4'b0100: out = op1&op2;//AND
            4'b0101: out = (op1|op2); //OR
            4'b0110: out = (op1^op2); //XOR
            4'b0111: out= op1;//Load upper immediate (Lui) (ALU control should handle immediate --> Op1)
            4'b1000: out = op2 << op1; // SLL(V) Logical Shift left/(same as ASL))
            4'b1010: out = op2 >> op1; //SRL(V) Logical Shift right 
            4'b1011: out = $signed(op2) >>> op1; //arithmetic shift right SRA(V). Variable- shiftamount value pushed onto op1 if this is the case.
            4'b1110: out = $unsigned(op1) - $unsigned(op2); //SUBU
            
            
    endcase

    end
    assign low  = divmult_out[31:0];
    assign high = divmult_out[63:32];

endmodule
