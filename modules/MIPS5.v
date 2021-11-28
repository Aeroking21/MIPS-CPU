module MIPS5(
    input logic [31:0] data_in, 
    input logic [31:0] instr, 
    input logic clk, 
    input logic reset, 
    
    output logic [31:0] reg_v0, 
    output logic [31:0] reg_t1,
    output logic [31:0] instr_address, 
    output logic [31:0] data_address, 
    output logic [31:0] data_out, 
    output logic active,
    output logic data_read,
    output logic data_write,
    output logic [5:0] OP, 
    output logic [5:0] reg_addrw,
    output logic[31:0] reg_t0, 
    output logic[31:0] reg_write
);

    //logic[5:0] OP; 
    logic[5:0] funct;
    logic[31:0] op_1, op_2 jump_address, PC_next; //reg_write;
    logic[5:0] reg_addr1, reg_addr2, shamt; //reg_addrw;
    logic[15:0] astart; 
    logic next_active; 
    logic reset_prev; 
    logic write_enable;
    logic shift; 
    logic[3:0] ALU_code;
    logic[2:0] funct_tail, OP_tail; 
    logic[2:0] subtype;
     
    reg signed [31:0] HI, LO; 

//decoder
    typedef enum logic[5:0] {
        R = 6'b0,
        ADDIU = 6'b001001,
        ANDI = 6'b001100,
        SLTI = 6'b 001010,
        SLTIU= 6'b001011,
        SW = 6'b101011,
        LW = 6'b100011,
        XORI = 6'b001110,
        BEQ = 6'b000100,
        LUI = 6'b001111,
        ORI = 6'b001101,
    } t_OP; 

    typedef enum logic[5:0]{
        JR = 6'b001000,
        ADDU = 6'b100001,
        AND = 6'b100100,
        SLT = 6'b101010,
        SLTU = 6'b101011,
        SUBU = 6'b100011,
        XOR = 6'b100110,
        SLL = 6'b0,
        SLLV = 6'b000100,
        SRA = 6'b000011,
        SRAV = 6'b000111,
        SRL = 6'b000010,
        SRLV = 6'b000110,
        DIV = 6'b011010,
        DIVU = 6'b011011,
        OR = 6'b100101,
        MULT = 6'b011000,
        MULTU = 6'b011001
    } t_funct; 

// IDK if this is necessary, I could just put it as a condition in the write enable definition (since it's in an assign I can parse )
    typedef enum logic[2:0]{
        Branch = 3'b0, //this has further separation when it's J type, because the second half of the word is the target 
        Imm = 3'b001,
        Load = 3'b100,
        Store = 3'b101
    } sub_t;

// Instruction decoding and control signals 
    assign OP = instr[31:26]; 
    assign funct = instr[5:0];
    assign shift = (funct[5:3] == 3'b0) ? 1 : 0; 
    assign funct_tail = funct[2:0]; 
    assign OP_tail = OP[2:0]; 

    assign astart = instr[15:0]; 


// ALU control definition 
    always_comb begin 

        if (R==0) begin 
            if (shift) begin 
                ALU_code = {1'b1, funct_tail}; 
            end 
            else if (funct == MULTU) begin 
                ALU_code = 4'b1001;
            end 
            else if (funct == DIV) begin 
                ALU_code = 4'b1101; 
            end 
            else if (funct == DIVU) begin 
                ALU_code = 4'b1100; 
            end 
        end 

        else begin
            ALU_code = {0'b, OP_tail}; 
        end 

    end 
            
        
    reg [31:0] reg_file [31:0];

    assign reg_addr1 = instr[25:21]; 
    assign reg_addr2 = instr[20:16]; 
    assign reg_addrw = (OP == R) ? instr[15:11] : instr[20:16]; //which part of the instruction word determines the address to write depends on the type of instruction

    assign write_enable = (OP == R OR subtype == Imm) ? 1 : 0; 
// register file reading 
    assign op_1 = reg_file[reg_addr1]; 
    assign op_2 = (R==0) ? reg_file[reg_addr2] : {16'b0, astart}; 
    assign shamt = instr[10:7];

    assign reg_v0 = reg_file[2]; 
    assign reg_t1 = reg_file[9];  //DEBUGGING
    assign reg_t0 = reg_file[8];   // DEBUGGING





// full load/store instructions
    assign data_read = reset ? 0 : (OP == LW) ? 1: 0; // this has to be added to make sure this two bits are paralised during reset (since there can't be anything coming out of RAM)
    assign data_write = reset ? 0: (OP == SW) ? 1: 0; // not sure if I can do this 
    assign data_address = (reg_read1 + astart); 

////////////TO DO/////////
    // add the half word / byte instructions for load and store



// save the previous reset for the initialisation of instr_address
    always_ff@(negedge clk) begin 
        reset_prev <= reset;
    end 

    always_ff @(posedge clk) begin 
        active <= next_active; 
    end // this means that probably some of the asserts will be wrong 

//what each op does this will need to be changed since the ALU will be in a separate module 
    always_comb begin 
        if (reset) begin 
            reg_write = 0;
        end 

        else begin 
            case(OP)
            R: case (funct)
                 ADDU: reg_write = reg_read1 + reg_read2; // depending on how we are going to separate the ALU this can be written as: 
                 // reg_file[reg_addrw] = reg_file[reg_addr1] + reg_file[reg_addr2]
                 JR: ; // JR do nothing here, IDK if it's needed or if it's going to stall it 
                endcase
            LW: reg_write = data_in;
            SW: data_out = reg_read1; 
            ADDIU: reg_write = reg_read1 + {16'b0, astart};
            endcase
        end     
    end 

//save the register address as it will change as soon as the next instruction is brought up 

    always_ff @(negedge clk) begin 
        if (JR == funct) begin 
            PC_next <=  (reg_read1*4);
        end 
        else if (reset) begin 
            PC_next <= 32'hBFC00000;
        end
        else begin 
            PC_next <= instr_address + 4;
        end 
    end

//qui si definisce il next instr_address
    always_ff @(posedge clk) begin 
        //MUX con default for PC+4
        case (OP)
            R: case (funct)
                JR: instr_address <=  PC_next;
                default: instr_address <= PC_next; //this is the default case for all the R instructions 
            endcase 
            default: begin 
                if (reset == 0) begin
                    instr_address <= PC_next; 
                end 
                else begin 
                    instr_address <= 0; 
                end 
            end 
        endcase
    end

    always_comb begin 
        if (reset) begin 
            next_active = 1; 
        end 
        else if (instr_address != 0) begin 
            next_active = active; 
        end 
        else begin 
            next_active = 0; 
        end 
       // next_active = reset ? 1: (instr_address == 0) ? 0: active;
    end 





//register file writing
// what is relevant here is what reg_write is (defined in the logic block)

    always_ff @(posedge clk)  begin
        //add clock enable statement 
        // add a condition so that, if reset is 1, reg_write is 0
        if (reset) begin 
            int i; 
            for (i=0; i<32; i= i+1) begin 
                reg_file[i] <= 0; 
            end 
        end 
        
        if (write_enable) begin 
            reg_file[reg_addrw] <= reg_write; 
        end 
     
        // for the above example try reg_file[reg_addrw] = reg_file
        
    end 
    
endmodule
