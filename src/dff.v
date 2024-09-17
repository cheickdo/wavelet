
`timescale 1us/1ns

module dff(
    input clk,
    input [size-1:0]d,
    input resetn,
    output reg [size-1:0] l,
    output reg [size-1:0] q
);

    parameter size = 32;

    always@(posedge clk) begin
        if (!resetn)
            q <= 0;
        else
            q <= d;
    end

// Dump waves
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, dff);
end

endmodule