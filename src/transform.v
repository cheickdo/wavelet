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


endmodule