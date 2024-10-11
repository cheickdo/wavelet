module mac(
    input [size-1:0] a,
    input [size-1:0] b,
    input [size-1:0] c,
    input [size-1:0] cons,
    output reg [size-1:0] d
);
    parameter size = 32;

    wire [size-1:0] in;
    wire [size-1:0] temp;
    
    //assign in = a + b;
    //assign temp = in * const;
    assign d = ((a+b)*cons) + c;

endmodule