
//computes the absolute value of the input number
module abs(
    input [size-1:0] num,
    output [size-1:0] num_plus
);

    assign num_plus = {1'b0, num[size-2:0]};

endmodule