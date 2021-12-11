module RAM_module(
input logic[31:0] addr,
input data_in[31:0];
input data_read;
input data_write;


output logic[31:0]data_out;
);
// RAM
reg [7:0] RAM [0:1000];

always_comb begin
    if (data_read == 1 && data_write == 0) begin
        data_out[7:0] = RAM[addr];
        data_out[15:8] = RAM[addr+1];
        data_out[23:16] = RAM[addr+2];
        data_out[31:24] = RAM[addr+3];
    end

    else if (data_read == 0 && data_write == 1) begin
        RAM[addr] = data_in[7:0];
        RAM[addr+1] = data_in[15:8];
        RAM[addr+2] = data_in[23:16];
        RAM[addr+3] = data_in[31:24];
    end
    
end



initial begin
    $readmemh("data.mem", RAM,0);
end


endmodule