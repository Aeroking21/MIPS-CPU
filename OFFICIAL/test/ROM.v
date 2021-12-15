module ROM_module(
input logic[31:0] addr,



output logic[31:0]instruction
);
// ROM
reg [7:0] ROM_0 [0:255];
reg [7:0] ROM_RESET_V [3217031168:3217031168+3000];
parameter ROM_INIT_FILE = "";

assign instruction[7:0] = ROM_RESET_V[addr];
assign instruction[15:8] = ROM_RESET_V[addr+1];
assign instruction[23:16] = ROM_RESET_V[addr+2];
assign instruction[31:24] = ROM_RESET_V[addr+3];


initial begin
    //$readmemh("instructions.mem", ROM_RESET_V,3217031168);
    $readmemh(ROM_INIT_FILE, ROM_RESET_V,3217031168);
    $display("Instruction = %h",ROM_RESET_V[32'hBFC00000]);
    $display("Instruction r = %h",ROM_RESET_V[3217031168]);
end


endmodule
