//Implementation of a one-dimensional recursive 9/7 DWT architecture

module transform (
    input clk,
    input resetn,
    input [size-1:0] x,
    //output [size-1:0] L,
    output [size-1:0] H
    //Add register and delay unit enables to signal IO list
);

    //enable signals
    //reg EnR4;
    reg EnR3;
    reg EnR2;
    reg EnR1;
    reg EnD1a;
    reg EnD2a;
    reg EnD3a;
    //reg EnD4a;
    reg EnD1b;
    reg EnD2b;
    reg EnD3b;
    //reg EnD4b;
    reg EnD1c;
    reg EnD2c;
    reg EnD3c;
    //reg EnD4c;
    reg EnD1d;
    reg EnD2d;
    reg EnD3d;
    //reg EnD4d;
    reg EnR2p;
    reg EnR3p;
    //reg EnR4p;

    //Control switch signals
    reg [1:0] S1;
    reg [1:0] S2;
    reg [1:0] S3;
    reg [1:0] S4;
    reg [1:0] S5;
    reg [1:0] S6;
    reg S7;

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
    //reg [size-1:0] R4;

    //Odd registers
    reg [size-1:0] R2p;
    reg [size-1:0] R3p;
    //reg [size-1:0] R4p;

    //Delay units
    reg [size-1:0] D1a;
    reg [size-1:0] D2a;
    reg [size-1:0] D3a;
    //reg [size-1:0] D4a;

    reg [size-1:0] D1b;
    reg [size-1:0] D2b;
    reg [size-1:0] D3b;
    //reg [size-1:0] D4b;

    reg [size-1:0] D1c;
    reg [size-1:0] D2c;
    reg [size-1:0] D3c;
    //reg [size-1:0] D4c;

    reg [size-1:0] D1d;
    reg [size-1:0] D2d;
    reg [size-1:0] D3d;
    //reg [size-1:0] D4d;

    //shift registers
    reg [3:0] EnD1shift;
    reg [3:0] EnD2shift;
    reg [3:0] EnD3shift;
    reg [3:0] S3shift;

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

    //Just for Daub4
    assign EnD1a = EnD1shift[3];
    assign EnD2a = EnD2shift[3];
    assign EnD3a = EnD3shift[3];
    assign S3 = S3shift[3:2];

    always@(*) begin
        //Muxes
        assign Even0 = S1[1] ? (S1[0] ? /*R4*/1'b0 : R3) : (S1[0] ? R2 : R1);
        assign Even1 = S3[1] ? (S3[0] ? /*D4a*/1'b0 : D3a) : (S3[0] ? D2a : D1a);
        assign Even3 = S5[1] ? (S5[0] ? /*D4c*/1'b0 : D3c) : (S5[0] ? D2c : D1c);
        
        assign Odd0 = S2[1] ? (S2[0] ? /*R4p*/1'b0 : R3p) : (S2[0] ? R2p : x);
        assign Odd2 = S4[1] ? (S4[0] ? /*D4b*/1'b0 : D3b) : (S4[0] ? D2b : D1b);
        assign Odd4 = S6[1] ? (S6[0] ? /*D4d*/1'b0 : D3d) : (S6[0] ? D2d : D1d);

        if (S7) y <= Even5;
        else L <= Even5;
    end

    always@(posedge clk) begin
        if (EnR1) R1 <= x;
        if (EnR2) R2 <= y;
        if (EnR3) R3 <= y;
        //if (EnR4) R4 <= y;

        //if (EnR2p) R2p <= y;
        R2p <= y;
        if (EnR3p) R3p <= y;
        //if (EnR4p) R4p <= y;

        //if (EnD1a) D1a <= Even0;
        //if (EnD2a) D2a <= Even0;
        //if (EnD3a) D3a <= Even0;
        //if (EnD4a) D4a <= Even0;

        if (EnD1a) D1a <= Odd1;
        if (EnD2a) D2a <= Odd1;
        if (EnD3a) D3a <= Odd1;
        if (EnD4a) D4a <= Odd1;

        //if (EnD1b) D1a <= Odd1;
        //if (EnD2b) D2a <= Odd1;
        //if (EnD3b) D3a <= Odd1;
        //if (EnD4b) D4a <= Odd1;

        //if (EnD1c) D1c <= Even2;
        //if (EnD2c) D2c <= Even2;
        //if (EnD3c) D3c <= Even2;
        //if (EnD4c) D4c <= Even2;

        //if (EnD1d) D1d <= Odd3;
        //if (EnD2d) D2d <= Odd3;
        //if (EnD3d) D3d <= Odd3;
        //if (EnD4d) D4d <= Odd3;
        
    end

    //Multiple and Accumulate units
    //mac u0(.in0(Even0), .in1(Even1), .in3(Odd0), .d(Odd1), .cons(alpha));
    //mac u1(.in0(Odd1), .in1(Odd2), .in3(Even1), .d(Even2), .cons(beta));
    //mac u2(.in0(Even2), .in1(Even3), .in3(Odd2), .d(Odd3), .cons(gamma));
    //mac u3(.in0(Odd3), .in1(Odd4), .in3(Even3), .d(Even4), .cons(delta));

    //Multiply and accumulate units for Daub-4 DWT
    mac u0(.in0(Even0), .in1(0), .in3(Odd0), .d(Odd1), .cons(alpha));
    mac u1(.in0(Odd1), .in1(0), .in3(Even0), .d(Even1), .cons(beta));
    mac u2(.in0(Odd2), in1(0), in3(Even1), .d(Even2), .cons(gamma));
    mac u3(.in0(Even2), .in1(0), .in3(Odd3), .d(Odd4, cons(1)));

    //control unit
    reg [3:0] state;
    reg [2:0] cycle1;
    reg [1:0] cycle2;
    reg cycle2En;
    reg finalEn;
    reg SEn;
    reg DshiftEn;

    reg preEnD1a;
    reg preEnD2a;
    reg preEnD3a;

    reg [1:0] preS3;

    //enable signals, might need to extend the range for switch logic
    always@(*) begin
        EnR1 = 1'b0;
        EnR2 = 1'b0;
        EnR3 = 1'b0;
        EnR2p = 1'b0;
        EnR3p = 1'b0;
        S1 = 2'b0;
        S2 = 2'b0;
        //S3 = 2'b0;
        S4 = 2'b0;
        S5 = 2'b0;
        S6 = 2'b0;
        S7 = 1'b0;
        SEn = 1'b0;
        preEnD1a = 1'b0;
        preEnD2a = 1'b0;
        preEnD3a = 1'b0;
        preS3 = 2'b0;
        //EnD1a = 1'b0;

        if (cycle1[0]) begin //checking 2k cycle
            EnR1 = 1'b1;
            preEnD1a = 1'b1;
        end

        if (!cycle1[0]) begin//checking 2k+1 cycle
            S1 = 2'b01;
            S2 = 2'b01;
            preS3 = 2'b01;
        end

        if (cycle1[1] & cycle1[0]) begin //4k+4 cycle
            EnR2 = 1'b1; 
            EnR2p = 1'b1; 
            preEnD2a = 1'b1;
        end

        if ((cycle2[0] & !cycle2[1])) begin  //4k+6 cycle
            S1 = 2'b10;
            S2 = 2'b10;
            preS3 = 2'b10;
        end

        if ((!cycle1[2] & !cycle1[1] & !cycle1[0]) & (state[3] & (state[0]))) begin //8k+9 cycle
            EnR3 = 1'b1;
            EnR3p = 1'b1;
            preEnD3a = 1'b1;
        end

        if ((state[0] & state[1] & state[2] & state[3]) & (cycle1[2] & cycle1[1] & cycle1[0])) begin //8k+16 cycle
            S1 = 2'b11;
            S2 = 2'b11;
            preS3 = 2'b11;
        end

        

    end

    //counter
    always@(posedge clk) begin
        if (!resetn) begin
            state <= 0;
            cycle1 <= 0;
            cycle2 <= 0;
            cycle2En <= 0;
            finalEn <= 0;


        end
        else begin
            if (state == 4'b1111) begin
                state <= 4'b1111; //counts to 25
                finalEn <= 1;
            end
            else state <= state + 1;

            if (cycle1 == 3'b111) cycle1 <= 0;
            else cycle1 <= cycle1 + 1;

            if (state[1] & state[0]) cycle2En <= 1;

            if (cycle2En) cycle2 <= cycle2 + 1;

            S3shift <= {S3shift[1:0], preS3};

            EnD1shift <= {EnD1shift[3:0], preEnD1a};
            EnD2shift <= {EnD2shift[3:0], preEnD2a};
            EnD3shift <= {EnD3shift[3:0], preEnD3a};
        
        end
    end
    

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, transform);
    end


endmodule