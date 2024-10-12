//Implementation of a one-dimensional recursive 9/7 DWT architecture

module transform (
    input clk,
    input [size-1:0] x,
    input [1:0] S1,
    input [1:0] S2,
    input [1:0] S3,
    input [1:0] S4,
    input [1:0] S5,
    input [1:0] S6,
    input S7,
    output [size-1:0] L,
    output [size-1:0] H
    //Add register and delay unit enables to signal IO list

);

    //enable signals
    input EnR4;
    input EnR3;
    input EnR2;
    input EnR1;
    input EnD1a;
    input EnD2a;
    input EnD3a;
    input EnD4a;
    input EnD1b;
    input EnD2b;
    input EnD3b;
    input EnD4b;
    input EnD1c;
    input EnD2c;
    input EnD3c;
    input EnD4c;
    input EnD1d;
    input EnD2d;
    input EnD3d;
    input EnD4d;

    wire [size-1: 0] Even0;
    wire [size-1: 0] Even1;
    wire [size-1: 0] Even2;
    wire [size-1: 0] Even3;
    wire [size-1: 0] Even4;
    wire [size-1: 0] Even5;

    wire [size-1: 0] Odd0;
    wire [size-1: 0] Odd1;
    wire [size-1: 0] Odd2;
    wire [size-1: 0] Odd3;
    wire [size-1: 0] Odd4;
    wire [size-1: 0] Odd5;

    parameter size = 32;

    //Even registers
    reg [size-1:0] Rl;
    reg [size-1:0] R2;
    reg [size-1:0] R3;
    reg [size-1:0] R4;

    //Odd registers
    reg [size-1:0] Rlp;
    reg [size-1:0] R2p;
    reg [size-1:0] R3p;
    reg [size-1:0] R4p;

    //Delay units
    reg [size-1:0] D1a;
    reg [size-1:0] D2a;
    reg [size-1:0] D3a;
    reg [size-1:0] D4a;

    reg [size-1:0] D1b;
    reg [size-1:0] D2b;
    reg [size-1:0] D3b;
    reg [size-1:0] D4b;

    reg [size-1:0] D1c;
    reg [size-1:0] D2c;
    reg [size-1:0] D3c;
    reg [size-1:0] D4c;

    reg [size-1:0] D1d;
    reg [size-1:0] D2d;
    reg [size-1:0] D3d;
    reg [size-1:0] D4d;

    mac u0(.a(x), .b(S1), .c(S2), .d(temp), .cons(3));

    //Send the output of the registers through wires
    always@(*)
        case(S1)
        endcase

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, transform);
    end


endmodule