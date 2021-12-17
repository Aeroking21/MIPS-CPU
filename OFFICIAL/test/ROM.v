module ROM_module(
input logic[31:0] addr,



output logic[31:0]instruction
);
// ROM
reg [7:0] ROM_0 [0:255];
reg [7:0] ROM_RESET_V [3217031168:3217031168+3000];
parameter ROM_INIT_FILE = "";
reg [7:0] PRE_RESET_V [3217031160:3217031160+8];


assign instruction[7:0] = (addr >= 3217031168) ? ROM_RESET_V[addr] : PRE_RESET_V[addr];
assign instruction[15:8] = (addr >= 3217031168) ? ROM_RESET_V[addr+1] : PRE_RESET_V[addr+1];
assign instruction[23:16] = (addr >= 3217031168) ? ROM_RESET_V[addr+2] : PRE_RESET_V[addr+2];
assign instruction[31:24] = (addr >= 3217031168) ? ROM_RESET_V[addr+3] : PRE_RESET_V[addr+3];


initial begin
    //$readmemh("instructions.mem", ROM_RESET_V,3217031168);
    $readmemh(ROM_INIT_FILE, ROM_RESET_V,3217031168);
    $readmemh("test/pre_reset_v.mem", PRE_RESET_V,3217031160); 
    $display("Instruction = %h",ROM_RESET_V[32'hBFC00000]);
    $display("Instruction r = %h",ROM_RESET_V[3217031168]);
end


endmodule
