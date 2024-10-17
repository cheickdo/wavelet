module control(
    input clk,
    output reg EnR1,
    output reg EnR2,
    output reg EnR3,
    output reg EnR4,
    output reg EnR1p,
    output reg EnR2p,
    output reg EnR3p,
    output reg EnR4p,

    //Add other enables
);

    reg [1:0] reg;

    //enable signals
    always@(*) begin
        
    end


    parameter s0 = 0;
endmodule