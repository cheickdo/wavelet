module fixed_mult(
    input [size-1:0] in0,
    input [size-1:0] in1,
    output [size-1:0] product
);
    parameter size = 32;
    reg [(size*2) - 1: 0] interm;

    assign interm = in0 * in1;
    assign product = interm[2*size-1-(size/2):(size/2)];


    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(3, fixed_mult);
    end

endmodule