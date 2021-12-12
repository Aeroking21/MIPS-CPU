module RAM_module(
input logic[31:0] addr,
input logic [31:0] data_in,
input data_read,
input data_write,


output logic[31:0]data_out
);

// RAM
reg [7:0] RAM [0:1000];
logic [7:0] byte0_in, byte1_in, byte2_in, byte3_in;

assign byte0_in = data_in[7:0];
assign byte1_in = data_in[15:8];
assign byte2_in = data_in[23:16];
assign byte3_in = data_in[31:24];

assign data_out[7:0] = (data_read && !data_write) ? RAM[addr+0]:0; //make sure that the CPU won't do anything with data_out when it shouldn't as the value won't be right 
assign data_out[15:8] = (data_read && !data_write) ? RAM[addr+1]:0;
assign data_out[23:16] = (data_read && !data_write) ? RAM[addr+2]:0;
assign data_out[31:24] = (data_read && !data_write) ? RAM[addr+3]:0;

always_comb begin
    if(!data_read && data_write) begin
        RAM[addr] = byte0_in;
        RAM[addr+1] = byte1_in;
        RAM[addr+2] = byte2_in;
        RAM[addr+3] = byte3_in;
    end
end

// assign dummy = (!data_read && data_write) ? data_in[7:0] : dummy2;
// assign RAM[addr+1] = (!data_read && data_write) ? data_in[15:8] : RAM[addr+1];
// assign RAM[addr+2] = (!data_read && data_write) ? data_in[23:16] : RAM[addr+2];
// assign RAM[addr+3] = (!data_read && data_write) ? data_in[31:24] : RAM[addr+3];




initial begin
    $readmemh("data.mem", RAM, 0, 1000);
end


endmodule