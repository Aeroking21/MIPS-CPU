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
    logic[31:0] reg_read1, reg_read2, jump_address, PC_next; //reg_write;
    logic[5:0] reg_addr1, reg_addr2; //reg_addrw;
    logic[15:0] astart; 
    logic next_active; 
    logic reset_prev; 

       //simplified decoder
    typedef enum logic[5:0] {
        R = 6'b0,
        ADDIU = 6'b001001,
        SW = 6'b101011,
        LW = 6'b100011
    } t_OP; 

    typedef enum logic[5:0]{
        JR = 6'b001000,
        ADDU = 6'b100001
    } t_funct; 

    reg [31:0] reg_file [31:0];

    assign reg_addr1 = instr[25:21]; 
    assign reg_addr2 = instr[20:16]; 
    assign reg_addrw = (OP == R) ? instr[15:11] : instr[20:16]; //which part of the instruction word determines the address to write depends on the type of instruction

// register file reading 
// will this work or do I need a case statement? 
    assign reg_read1 = reg_file[reg_addr1]; 
    assign reg_read2 = reg_file[reg_addr2]; 

    assign reg_v0 = reg_file[2]; 
    assign reg_t1 = reg_file[9];
    assign reg_t0 = reg_file[8];

// Instruction decoding and control signals 
    assign OP = instr[31:26]; 
    assign funct = instr[5:0];

    assign astart = instr[15:0]; 

    assign data_read = reset ? 0 : (OP == LW) ? 1: 0; // this has to be added to make sure this two bits are paralised during reset (since there can't be anything coming out of RAM)
    assign data_write = reset ? 0: (OP == SW) ? 1: 0; // not sure if I can do this 
    assign data_address = (reg_read1 + astart); 

// save the previous reset for the initialisation of instr_address
    always_ff@(negedge clk) begin 
        reset_prev <= reset;
    end 


    always_ff @(posedge clk) begin 
        active <= next_active; 
    end // this means that probably some of the asserts will be wrong 

//what each op does
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

        case (reg_addrw)
            0: reg_file[0] <= reg_write; 
            1: reg_file[1] <= reg_write; 
            2: reg_file[2] <= reg_write; 
            3: reg_file[3] <= reg_write; 
            4: reg_file[4] <= reg_write; 
            5: reg_file[5] <= reg_write; 
            6: reg_file[6] <= reg_write; 
            7: reg_file[7] <= reg_write; 
            8: reg_file[8] <= reg_write; 
            9: reg_file[9]<= reg_write; 
            10: reg_file[10] <= reg_write; 
            11: reg_file[11] <= reg_write; 
            12: reg_file[12] <= reg_write; 
            13: reg_file[13] <= reg_write; 
            14: reg_file[14] <= reg_write; 
            15: reg_file[15] <= reg_write; 
            16: reg_file[16] <= reg_write; 
            17: reg_file[17] <= reg_write; 
            18: reg_file[18] <= reg_write; 
            19: reg_file[19] <= reg_write; 
            20: reg_file[20] <= reg_write; 
            21: reg_file[21] <= reg_write; 
            22: reg_file[22] <= reg_write; 
            23: reg_file[23] <= reg_write; 
            24: reg_file[24] <= reg_write; 
            25: reg_file[25] <= reg_write; 
            26: reg_file[26] <= reg_write; 
            27: reg_file[27] <= reg_write; 
            28: reg_file[28] <= reg_write; 
            29: reg_file[29] <= reg_write; 
            30: reg_file[30] <= reg_write; 
            31: reg_file[31] <= reg_write; 
        endcase 
        // for the above example try reg_file[reg_addrw] = reg_file
        
    end 
    
endmodule
