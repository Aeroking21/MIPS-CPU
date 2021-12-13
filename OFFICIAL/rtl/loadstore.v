module loadstore (
    input [31:0] op_1,
    input [15:0] astart,
    //input [31:0] data_address, //guarda in che formato è e che informazioni contiene
    input [31:0] read_data, 
    input [31:0] op_2,
    input clk,
    input [5:0] OP,
    input stall,
    
    output[31:0] data,
    output [31:0] data_address

);
    logic[1:0] byte_enable; 
    logic[1:0] word_address; 
    logic[7:0] byte0, byte1, byte2, byte3, op_2_b0, op_2_b1, op_2_b2, op_2_b3;
    logic [31:0] data_prev;
    logic stall_prev;
    logic [31:0] address; 
    logic [31:0] data_temp; 
    logic sign0, sign1, sign2, sign3;
    // what is actually accessed in memory+
    assign address = op_1 +{{16{astart[15]}}, astart}; 
    assign byte_enable = address[1:0]; // this will tell me what byte I have 
    assign data_address = {address[31:2], 2'b0}; //the effective aligned address is the specified address but made aligned, so with last two bits = 0. We can do this as we always move words so we need to tell the RAM the aligned address for all the instructions  
    assign byte0 = read_data[7:0];
    assign byte1 = read_data[15:8]; 
    assign byte2 = read_data[23:16];
    assign byte3 = read_data[31:24];
    assign op_2_b0 = op_2[31:24]; //big-endian
    assign op_2_b1 =op_2[23:16];
    assign op_2_b2 = op_2[15:8];
    assign op_2_b3 = op_2[7:0];
    assign sign0 = byte0[7];
    assign sign1 = byte1[7];
    assign sign2 = byte2[7];
    assign sign3 = byte3[7];
    

    typedef enum logic[5:0]{
        SW = 6'b101011,
        LW = 6'b100011,
        LB = 6'b100000,
        LBU = 6'b100100,
        LH = 6'b 100001,
        LHU = 6'b100101,
        SB = 6'b101000,
        SH = 6'b101001,
        LWL = 6'b100010,
        LWR = 6'b100110
    }t_ls_OP;

//loads
    always_comb begin 
        case (OP)
        LWL: begin 
            case (byte_enable) 
            0: data_temp = {byte0, byte1, byte2, byte3}; 
            1: data_temp = {byte1, byte2, byte3, op_2_b3};
            2: data_temp= {byte2, byte3, op_2_b2, op_2_b3};
            3: data_temp= {byte3, op_2_b1, op_2_b2, op_2_b3};
            endcase 
        end 
        LB: begin
            case(byte_enable)
            0: data_temp= {{24{sign0}},byte0};
            1: data_temp= {{24{sign1}}, byte1};
            2: data_temp= {{24{sign2}}, byte2};
            3: data_temp= {{24{sign3}}, byte3};
            endcase
        end 
        LBU: begin 
            case(byte_enable)
            0: data_temp= {24'b0,byte0};
            1: data_temp= {24'b0, byte1};
            2: data_temp= {24'b0, byte2};
            3: data_temp= {24'b0, byte3};
            endcase
        end 
        LWR: begin
            case(byte_enable)
            0: data_temp= {op_2_b0, op_2_b1, op_2_b2, byte0};
            1: data_temp= {op_2_b0, op_2_b1, byte0, byte1};
            2: data_temp= {op_2_b0, byte0, byte1, byte2};
            3: data_temp= {byte0, byte1, byte2, byte3}; 
            endcase
        end
        LW: data_temp= {byte0, byte1, byte2, byte3};
        LH: data_temp= {{16{sign2}}, byte2, byte3}; //non so quale metà della parola vada caricata
        LHU: data_temp={16'b0, byte2, byte3}; 
        endcase
    end

//stores
    always_comb begin 
        case(OP)
        SW: data_temp= {op_2_b3, op_2_b2, op_2_b1, op_2_b0};
        SB: begin 
            if (stall) begin
                case(byte_enable)
                    0: data_prev = {byte3, byte2, byte1, op_2_b3};
                    1: data_prev = {byte3, byte2, op_2_b3, byte0};
                    2: data_prev = {byte3, op_2_b3, byte1, byte0};
                    3: data_prev = {op_2_b3, byte2, byte1, byte0};
                endcase
            end
            else begin 
                data_temp= data_prev; //so that in the next cycle we will store the patchworked word 
            end
        end
        SH: begin 
            if (stall) begin
                data_prev = {op_2_b3, op_2_b2, byte1, byte0};
            end
            else begin 
                data_temp= data_prev;
            end 
        end
        endcase  
    end

    assign data = data_temp; //for some reason you can't bind wires within an always_comb statement 


endmodule
    
 
