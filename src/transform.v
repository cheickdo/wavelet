//Implementation of a one-dimensional recursive DAUB-4 DWT architecture

module transform (
    input clk,
    input resetn,
    input [size-1:0] x,
    output reg [size-1:0] L,
    output reg [size-1:0] H
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

    parameter alpha = 32'b11111111111111100100010010011000;
    parameter beta = 32'b00000000000000000110111011011010;
    parameter gamma = 32'b11111111111111111110111011011010;
    parameter lambda = 32'b00000000000000010000000000000000;
    //parameter delta = 5*(2**16);
    //parameter zeta = 6*(2**16);
    parameter omega = 32'b00000000000000011110111010001110;
    parameter nabla = 32'b00000000000000001000010010000100;

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
    reg [5:0] S3shift;

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
    //reg [size-1:0] L;

    //Just for Daub4
    assign EnD1a = EnD1shift[2];
    assign EnD2a = EnD2shift[3];
    assign EnD3a = EnD3shift[3];
    assign S3 = S3shift[5:4];

    always@(*) begin

        //DAUB-4 DWT Muxes
        //Latch?
        case(S1)
        2'b11:Even0 = R3;
        2'b10: Even0 = R2;
        2'b01: Even0 = R1;
        2'b00: Even0 = 32'bx;
        endcase

        case(S2)
        2'b11:Odd0 = R3p;
        2'b10: Odd0 = R2p;
        2'b01: Odd0 = x;
        2'b00: Odd0 = 32'bx;
        endcase

        case(S3)
        2'b11:Odd3 = D3a;
        2'b10: Odd3 = D2a;
        2'b01: Odd3 = D1a;
        2'b00: Odd3 = 32'bx;
        endcase     

        //if (S4) y<= Even5;
        //else L<= Even5;
        y <= Even5; //verify timing
        L <= Even5; 

    end

    always@(posedge clk) begin
        Even1 <= Even0;
        Even3 <= Even2;
        Odd2 <= Odd1;

        if (EnR1) R1 <= x;
        if (EnR2) R2 <= y;
        if (EnR3) R3 <= y;
        //if (EnR4) R4 <= y;

        //if (EnR2p) R2p <= y;
        R2p <= y;
        if (EnR3p) R3p <= y;
        //if (EnR4p) R4p <= y;


        if (EnD1a) D1a <= Odd2;
        if (EnD2a) D2a <= Odd2;
        if (EnD3a) D3a <= Odd2;

    end

    //Multiply and accumulate units for Daub-4 DWT
    z_mac u0(.clk(clk), .in0(Even0), .in1(0), .in3(Odd0), .d(Odd1), .cons(alpha));
    z_mac u1(.clk(clk),.in0(Odd1), .in1(0), .in3(Even1), .d(Even2), .cons(beta));
    mac u2(.clk(clk),.in0(Odd3), .in1(0), .in3(Even3), .d(Even4), .cons(gamma));
    mac u3(.clk(clk),.in0(Even4), .in1(0), .in3(Odd3), .d(Odd4), .cons(lambda));

    z_fixed_mult m1(.clk(clk), .in0(Even4), .in1(omega), .product(Even5));
    z_fixed_mult m2(.clk(clk),.in0(Odd4), .in1(nabla), .product(H));

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
        //EnR2p = 1'b0;
        EnR3p = 1'b0;
        S1 = 2'b0;
        S2 = 2'b0;
        //S3 = 2'b0;
        SEn = 1'b0;
        preEnD1a = 1'b0;
        preEnD2a = 1'b0;
        preEnD3a = 1'b0;
        //preS3 = 2'b0;
        //EnD1a = 1'b0;

        if (!cycle1[0]) begin //checking 2k cycle
            EnR1 = 1'b1;
            preEnD1a = 1'b1;
        end

        if (cycle1[0]) begin//checking 2k+1 cycle
            S1 = 2'b01;
            S2 = 2'b01;
            preS3 = 2'b01;
        end

        if ((!cycle1[1] & cycle1[0]) & ((state[2]) | state[3])) begin //4k+4 cycle -> must be delayed until at least 4 in state is reached
            EnR2 = 1'b1; 
            preEnD2a = 1'b1;
        end

        if ((cycle2[0] & !cycle2[1])) begin  //4k+6 cycle
            S1 = 2'b10;
            S2 = 2'b10;
            preS3 = 2'b10;
        end

        if (((cycle1[2] & !cycle1[1] & !cycle1[0])) & (state[3] & state[2])) begin //8k+9 cycle
            EnR3 = 1'b1;
        end

        if (((!cycle1[2] & !cycle1[1] & !cycle1[0])) & (state[3] & state[2])) begin //8k+9 cycle
            EnR3p = 1'b1;
            preEnD3a = 1'b1; //this also needs to be queued up
        end

        if ((state[0] & state[1] & state[2] & state[3]) & (!cycle1[2] & cycle1[1] & !cycle1[0])) begin //8k+16 cycle
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

            if ((state[2] & state[1]) | state[3]) cycle2En <= 1;
            else cycle2En <= 0;

            if (cycle2En) cycle2 <= cycle2 + 1;
            else cycle2 <= 0;

            S3shift <= {S3shift[3:0], preS3};

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