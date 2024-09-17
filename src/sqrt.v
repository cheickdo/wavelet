
//fixed point square root via goldschmidth algorithm
module sqrt(
    input [size-1::0] in,
    output [size-1::0] sqrt;
);
    parameter size = 32;

    wire [size-1::0] f;
    wire [size-1::0] msb;

    assign f =  log(in);
    assign msb = f - 16;


    // Dump waves
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, sqrt);
    end

endmodule