//Delayed multiply and accumulate units
module z_mac(
    input clk,
    input [size-1:0] in0,
    input [size-1:0] in1,
    input [size-1:0] cons,
    input [size-1:0] in3,
    output reg [size-1:0] d
);
    parameter size = 32;

    wire [size-1:0] in;
    wire [size-1:0] temp;
    wire [size-1:0] mult;
    wire [size-1:0] sum0;

    assign sum0 = in0 + in1;

    fixed_mult m0(.in0(sum0), .in1(cons), .product(mult));

    //assign in = a + b;
    //assign temp = in * const;


    //assign d = ((in0+in1)*cons) + in3;
    //assign d = mult + in3;

    always@(posedge clk) begin
        d <= mult + in3;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(2, z_mac);
    end

endmodule

//Non-delayed multiply and accumulate units
module mac(
    input clk,
    input [size-1:0] in0,
    input [size-1:0] in1,
    input [size-1:0] cons,
    input [size-1:0] in3,
    output reg [size-1:0] d
);
    parameter size = 32;

    wire [size-1:0] in;
    wire [size-1:0] temp;
    wire [size-1:0] mult;
    wire [size-1:0] sum0;

    assign sum0 = in0 + in1;

    fixed_mult m0(.in0(sum0), .in1(cons), .product(mult));

    //assign in = a + b;
    //assign temp = in * const;


    //assign d = ((in0+in1)*cons) + in3;
    assign d = mult + in3;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(2, mac);
    end

endmodule