module mult(
    input logic clk,
    input logic[31:0] a,
    input logic[31:0] b,
    output logic [31:0] high,
    output logic [31:0] low
);
    logic [63:0] multc, multc_next; // 3 registers
    logic [31:0] multp, multp_next;
    logic [63:0] prod, prod_next;
    logic [4:0] count, count_next; //forloop for multiplication count



    always_comb begin
        if (a&b==0) begin //if a or b = 0 then multiplier should just output 0
            prod = 0;
            count = 32;
        end

        if (count == 0) begin

            multc_next = a;
            multp_next = b;
            prod_next = 0;
        end
        else begin
            prod_next = (multc & 1) ? (product + multp) : product; //If lsb of multp is 1, add multp to product
            multc_next = multc<<1;
            multp_next = multp >>1;
            count_next = count + 1;

        end
    end

    assign low = prod[31:0];
    assign high = prod[63:32];


    always_ff @(posedge clk) begin //updates values at positive clock edge after combinatorial stage calculates the values for the next cycle
        prod <= prod_next;
        multc <= multc_next;
        multp <= multp_next;
        count <= count_next;
    end
endmodule