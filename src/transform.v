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
    //output [size-1:0] L,
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
    input EnR2p;
    input EnR3p;
    input EnR4p;

    parameter size = 32;

    parameter alpha = 2;
    parameter beta = 3;
    parameter gamma = 4;
    parameter delta = 5;
    parameter zeta = 6;

    //Enable signals

    //Even registers
    reg [size-1:0] R1;
    reg [size-1:0] R2;
    reg [size-1:0] R3;
    reg [size-1:0] R4;

    //Odd registers
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

    reg [size-1: 0] Even0;
    reg [size-1: 0] Even1;
    reg [size-1: 0] Even2;
    reg [size-1: 0] Even3;
    reg [size-1: 0] Even4;
    reg [size-1: 0] Even5;

    reg [size-1: 0] Odd0;
    reg [size-1: 0] Odd1;
    reg [size-1: 0] Odd2;
    reg [size-1: 0] Odd3;
    reg [size-1: 0] Odd4;
    reg [size-1: 0] Odd5;

    //feedback unit
    reg [size-1:0] y;
    reg [size-1:0] L;

    always@(*) begin
        //Muxes
        assign Even0 = S1[1] ? (S1[0] ? R4 : R3) : (S1[0] ? R2 : R1);
        assign Even1 = S3[1] ? (S3[0] ? D4a : D3a) : (S3[0] ? D2a : D1a);
        assign Even3 = S5[1] ? (S5[0] ? D4c : D3c) : (S5[0] ? D2c : D1c);
        
        assign Odd0 = S2[1] ? (S2[0] ? R4p : R3p) : (S2[0] ? R2p : x);
        assign Odd2 = S4[1] ? (S4[0] ? D4b : D3b) : (S4[0] ? D2b : D1b);
        assign Odd4 = S6[1] ? (S6[0] ? D4d : D3d) : (S6[0] ? D2d : D1d);

        if (S7) y <= Even5;
        else L <= Even5;
    end

    always@(posedge clk) begin
        if (EnR1) R1 <= x;
        if (EnR2) R2 <= y;
        if (EnR3) R3 <= y;
        if (EnR4) R4 <= y;

        if (EnR2p) R2p <= y;
        if (EnR3p) R3p <= y;
        if (EnR4p) R4p <= y;

        if (EnD1a) D1a <= Even0;
        if (EnD2a) D2a <= Even0;
        if (EnD3a) D3a <= Even0;
        if (EnD4a) D4a <= Even0;

        if (EnD1b) D1a <= Odd1;
        if (EnD2b) D2a <= Odd1;
        if (EnD3b) D3a <= Odd1;
        if (EnD4b) D4a <= Odd1;

        if (EnD1c) D1c <= Even2;
        if (EnD2c) D2c <= Even2;
        if (EnD3c) D3c <= Even2;
        if (EnD4c) D4c <= Even2;

        if (EnD1d) D1d <= Odd3;
        if (EnD2d) D2d <= Odd3;
        if (EnD3d) D3d <= Odd3;
        if (EnD4d) D4d <= Odd3;
        
        /*
        case (S1)
        2'b00:  Even0 <= R1;
        2'b01:  Even0 <= R2;
        2'b10:  Even0 <= R3;
        2'b11:  Even0 <= R4; 
        endcase

        case (S2)
        2'b00:  Odd0 <= x;
        2'b01:  Odd0 <= R2p;
        2'b10:  Odd0 <= R3p;
        2'b11:  Odd0 <= R4p; 
        endcase

        case (S3)
        2'b00:  Even1 <= D1a;
        2'b01:  Even1 <= D2a;
        2'b10:  Even1 <= D3a;
        2'b11:  Even1 <= D4a;         
        endcase

        case (S4)
        2'b00:  Odd2 <= D1b;
        2'b01:  Odd2 <= D2b;
        2'b10:  Odd2 <= D3b;
        2'b11:  Odd2 <= D4b;    
        endcase

        case (S5)
        2'b00:  Even3 <= D1c;
        2'b01:  Even3 <= D2c;
        2'b10:  Even3 <= D3c;
        2'b11:  Even3 <= D4c;   
        endcase

        case (S6)
        2'b00:  Odd4 <= D1d;
        2'b01:  Odd4 <= D2d;
        2'b10:  Odd4 <= D3d;
        2'b11:  Odd4 <= D4d;
        endcase

        case (S7)
        1'b0: L <= Even5;
        1'b1: y <= Even5;
        endcase*/
        
    end

    //Multiple and Accumulate units
    mac u0(.in0(Even0), .in1(Even1), .in3(Odd0), .d(Odd1), .cons(alpha));
    mac u1(.in0(Odd1), .in1(Odd2), .in3(Even1), .d(Even2), .cons(beta));
    mac u2(.in0(Even2), .in1(Even3), .in3(Odd2), .d(Odd3), .cons(gamma));
    mac u3(.in0(Odd3), .in1(Odd4), .in3(Even3), .d(Even4), .cons(alpha));
    

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, transform);
    end


endmodule