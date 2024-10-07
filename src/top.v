module top(
    input clk,
    output [size-1:0] f
);

    //parameter size = 32;
    //assign f =  log(16);

    reg [size-1:0] Rl;
    reg [size-1:0] R1;
    reg [size-1:0] R2;
    reg [size-1:0] R3;

    reg [size-1:0] Rlp;
    reg [size-1:0] R1p;
    reg [size-1:0] R2p;
    reg [size-1:0] R3p
    
    ;


    // Dump waves
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, top);
    end


endmodule