module mips_cpu_harvard(
    input logic [31:0] data_readdata, 
    input logic [31:0] instr_readdata, 
    input logic clk, 
    input logic reset, 
    input logic clock_enable,
    
    output logic [31:0] register_v0, 
    output logic [31:0] instr_address, //this might need to be changed to instr_address to meet the specs 
    output logic [31:0] data_address, 
    output logic [31:0] data_writedata, 
    output logic active, 
    output logic data_read,
    output logic data_write
    
);

    logic[5:0] OP; 
    logic[5:0] funct;
    logic[31:0] op_1, op_2, jump_address, PC_next, reg_write, out, HI, LO, HI_m, LO_m;
    logic[5:0] reg_addr1, reg_addr2, reg_addrw; 
    logic[15:0] astart; 
    logic next_active; 
    logic reset_prev; 
    logic write_enable;
    logic shift; 
    logic[3:0] ALU_code;
    logic[2:0]  OP_tail;
    logic [1:0] funct_tail;
    logic[2:0] subtype;
    logic R_type, I_type, J_type; 
    logic [3:0] PC_upper; 
    logic [25:0] target; 
    logic MSB;
    logic[31:0] instr, instr_address_next, destination, jump_to;
    logic shift_op2;
    logic[31:0] data;
    logic stall, stall_prev, jump, jump_now;
    logic [32:0] branch_to, sign_ext_offset, sign_ext_address;
    logic msb_offset;
    logic[17:0]offset;
    logic[4:0]shamt;
    
    
    
    
     
    reg signed [31:0] HI_reg, LO_reg; 

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
        J = 6'b000010,
        JAL = 6'b000011, 
        B0 = 6'b000001, 
        BLEZ = 6'b000110,
        BGTZ = 6'b000111,
        BNE = 6'b000101,
        LB = 6'b100000,
        LBU = 6'b100100,
        LH = 6'b 100001,
        LHU = 6'b100101,
        SB = 6'b101000,
        SH = 6'b101001,
        LWL = 6'b100010,
        LWR = 6'b100110
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
        MULTU = 6'b011001,
        JALR = 6'b001001,
        MTHI = 6'b010001,
        MTLO = 6'b010011,
        MFHI = 6'b010000,
        MFLO = 6'b010010
    } t_funct; 

    typedef enum logic[2:0]{
        Branch = 3'b0, //this has further separation when it's J type, because the second half of the word is the target 
        Imm = 3'b001,
        Load = 3'b100,
        Store = 3'b101
    } sub_t;


    typedef enum logic[4:0]{
        BLTZAL = 5'b10000,
        BLTZ = 5'b0,
        BGEZ = 5'b00001,
        BGEZAL = 5'b10001
    }B0_t; 

// INSTRUCTION DECODER and CONTROL SIGNALS  
    assign instr = {instr_readdata[7:0], instr_readdata[15:8], instr_readdata[23:16], instr_readdata[31:24]};
    assign OP = instr[31:26]; 
    assign funct = instr[5:0];
    assign shift = (funct[5:3] == 3'b0) ? 1 : 0; 
    assign funct_tail = funct[1:0]; 
    assign OP_tail = OP[2:0]; 
    assign subtype = instr[31:29];
    assign instr_address_next = instr_address + 4; 
    assign PC_upper = instr_address_next[31:28];
    assign target = instr[25:0]; 
    assign shift_op2 = funct[2];
    

    assign R_type = (OP == R) ? 1:0;
    assign J_type = (OP == JAL || OP == J) ? 1:0; 
    assign I_type = (!J_type && !R_type) ? 1:0; 

    assign astart = instr[15:0]; 


// ALU_CONTROL  
    always_comb begin 

        if (OP==R) begin 
            if (shift) begin 
                ALU_code = {2'b10, funct_tail}; 
            end
            else begin 
                case (funct)
                MULT: ALU_code = 4'b0000;
                ADDU: ALU_code = 4'b0001;
                SLT: ALU_code = 4'b0010;
                SLTU: ALU_code = 4'b0011;
                AND: ALU_code = 4'b0100;
                OR: ALU_code = 4'b0101;
                XOR: ALU_code = 4'b0110;
                SUBU: ALU_code = 4'b1110; 
                MULTU: ALU_code = 4'b1001;
                DIVU: ALU_code = 4'b1100;
                DIV: ALU_code = 4'b1101; 
                endcase
            end
        end 
        else begin
            ALU_code = {1'b0, OP_tail}; 
        end 
    end 
    
            
//REG_FILE related DECODER
    reg [31:0] reg_file [31:0]; 
    assign reg_addr1 = instr[25:21]; 
    assign reg_addr2 = instr[20:16]; 
    assign reg_addrw = (OP == R) ? instr[15:11] : ((OP==B0 && (reg_addr2 == BGEZAL || reg_addr2 == BLTZAL)) || OP == JAL) ? 5'd31 : instr[20:16]; 

    assign write_enable = 
    ((OP == R 
        && funct != JR 
        && funct != DIV && funct != DIVU 
        && funct != MTHI && funct != MTLO 
        && funct != MULT && funct != MULTU)
    || subtype == Imm
    || subtype == Load
    || OP == JAL
    || (OP == B0 
        && (reg_addr2 == BGEZAL || reg_addr2 == BLTZAL))) ? 1 : 0; // these are all the occasions in which a register from the register file will have to be written 


    assign shamt = instr[10:6];
    assign op_1 = (OP == R && shift && !shift_op2) ? {27'b0, shamt} : reg_file[reg_addr1]; 
    assign op_2 = (OP==R || OP==BEQ || OP==BNE || OP == SW || OP == SH || OP == SB || OP == LW || OP == LHU || OP == LH || OP == LBU || OP == LB || OP == LWL || OP == LWR) ? reg_file[reg_addr2] :  (OP == XORI || OP == ORI || OP == ANDI) ? {16'b0, astart} : {{16{astart[15]}}, astart};  

    assign MSB = op_1[31];

    assign register_v0 = reg_file[2]; 



//MEMORY_INTERFACE_CONTROLS
always_comb begin 
    stall = (((OP == SB) || (OP == SH)) && !stall_prev) ? 1:0;
    
    data_read = reset ? 0 : ( ( (OP ==  LW) || ( (OP == SH || OP == SB )  && (stall  == 1) ) || (OP == LB) || (OP == LBU) || (OP == LWL) || (OP == LWR) || (OP == LH) || (OP == LHU) ) ? 1  :0 );

    data_write = reset ? 0: ((OP == SW || OP == SB || OP == SH) && !stall) ? 1: 0; 
end  
    
always_ff @(posedge clk) begin 
        stall_prev <= stall; 
end



//REG_WRITE_SELECTION
    always_comb begin
        case(OP)
        JAL: reg_write = instr_address_next+4; 
        B0: begin 
            if (reg_addr2 == BGEZAL || reg_addr2 == BLTZAL) begin 
                reg_write = instr_address_next +4;
            end 
        end
        LUI: reg_write = {astart, 16'b0}; 
        R: begin
            if (funct == JALR) begin 
                reg_write = instr_address_next + 4; 
            end 
            else if (funct == JR) begin 
            end 
            else if (funct == MFHI) begin 
                reg_write = HI_reg;
            end 
            else if (funct == MFLO) begin 
                reg_write = LO_reg; 
            end
            else begin 
                reg_write = out; 
            end 
        end 
        default: begin
            if (subtype == Load) begin 
                reg_write = data; 
            end 
            else if (subtype == Store) begin 
                data_writedata = data; 
            end 
            else begin 
                reg_write = out; //this heavily relies on write_enable to be correct
            end 
        end
        endcase 
    end 

//HI_REG and LO_REG
always_ff @(posedge clk) begin 
    if(OP == R && (funct == MULT || funct == MULTU || funct == DIV || funct == DIVU)) begin 
        HI_reg <= HI; 
        LO_reg <= LO; 
    end 
    else if (OP == R && funct == MTLO) begin 
        LO_reg <= op_1;
    end 
    else if (OP == R && funct == MTHI) begin 
        HI_reg <= op_1;
    end 
end



// PC_BLOCK

    assign offset = $signed(astart)*4;
    assign sign_ext_offset = {{15{offset[17]}}, offset}; 
    assign sign_ext_address = {1'b0, instr_address};


    always_comb begin 
                      
        if (reset) begin 
            PC_next = 32'hBFC00000; //reset address
            jump = 0; 
        end 
        else if (stall) begin 
            PC_next = instr_address; 
            if (jump_now == 1) begin 
                jump = 1; 
            end 
            else begin 
                jump = 0; 
            end 
        end 
        jump_to = (OP == R && ( funct == JR || funct == JALR)) ? op_1 : {PC_upper, target, 2'b00}; //address it needs to go to in case of a jump
        branch_to = sign_ext_address + sign_ext_offset +4;  //address it needs to go to in case of a jump and of met conditions 
        jump =  ((R_type && (funct == JR || funct == JALR))  // controls the jump, will instruct the PC to jump after the branch delay slot instruction is executed
                || J_type 
                || (OP == B0 && 
                    (((reg_addr2 == BGEZ || reg_addr2 == BGEZAL) && !MSB) 
                     || ((reg_addr2 == BLTZ || reg_addr2 == BLTZAL) && MSB)))
                || ((OP == BEQ) && (op_1 == op_2))
                || ((OP == BGTZ) && (op_1 > 0))  
                || ((OP == BNE) && (op_1 != op_2)) 
                || ((OP == BLEZ) && (op_1 <= 0))) ? 1 : 0; 

    end 
    

    always_ff @(posedge clk) begin 
        destination <= stall ? destination : (J_type || (R_type && (funct == JALR || funct == JR))) ? jump_to : branch_to[31:0];
        jump_now <= jump; //to enable the execution of instruction in the branch delay slot 
        if (jump_now && !stall && !reset) begin 
            instr_address <= destination; 
        end 
        else begin 
           instr_address <= (reset || stall ) ? PC_next : instr_address_next; //this ensures that, if reset is not kept high for a whole cycle, reset effectively has no effect
        end
    end 



//ACTIVE_RESET_CONTROL
    always_ff@(posedge clk) begin 
        reset_prev <= reset;
    end 

    always_ff @(posedge clk) begin 
        active <= reset ? 1 : (instr_address == 0) ? 0 : active; 
    end 


//REG_FILE WRITING 

    always_ff @(posedge clk)  begin
        
        if (reset) begin //set everything to 0
            int i; 
            for (i=0; i<32; i= i+1) begin 
                reg_file[i] <= 0; 
            end 
        end 
        
        else if (write_enable && clock_enable) begin 
            reg_file[reg_addrw] <= reg_write; 
        end 
     
        
    end 
    mips_cpu_alu ALU(
        .op1(op_1), .op2(op_2), .alu_control(ALU_code), .low(LO), .high(HI), .out(out)
    );
    mips_cpu_loadstore ls (
        .OP(OP), .op_1(op_1), .astart(astart), .data_address(data_address), .read_data(data_readdata), .op_2(op_2), .clk(clk), .stall(stall), .data(data)
    );
endmodule
