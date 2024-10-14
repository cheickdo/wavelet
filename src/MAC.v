module mac(
    input [size-1:0] in0,
    input [size-1:0] in1,
    input [size-1:0] cons,
    input [size-1:0] in3,
    output reg [size-1:0] d
);
    parameter size = 32;

    wire [size-1:0] in;
    wire [size-1:0] temp;
    
    //assign in = a + b;
    //assign temp = in * const;
    assign d = ((in0+in1)*cons) + in3;

endmodule