module z_fixed_mult(
    input clk,
    input [size-1:0] in0,
    input [size-1:0] in1,
    output reg [size-1:0] product
);
    parameter size = 32;
    reg [(size*2) - 1: 0] interm;

    assign interm = {{32{in0[31]}}, in0} * {{32{in1[31]}},in1};

    always @(posedge clk) begin
        product <= interm[2*size-1-(size/2):(size/2)];
    end


    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(3, z_fixed_mult);
    end

endmodule

module fixed_mult(
    input [size-1:0] in0,
    input [size-1:0] in1,
    output [size-1:0] product
);
    parameter size = 32;
    reg [(size*2) - 1: 0] interm;

    assign interm = {{32{in0[31]}}, in0} * {{32{in1[31]}},in1};
    assign product = interm[2*size-1-(size/2):(size/2)];


    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(3, fixed_mult);
    end

endmodule