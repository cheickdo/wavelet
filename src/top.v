module top(
    input clk,
    output [size-1:0] f
);

    parameter size = 32;
    assign f =  log(16);

    // Dump waves
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, top);
    end


endmodule