module top(CLK, START, RESET, MODE, SI, an, seg, led);
input wire CLK, START, RESET;
input wire [1:0] MODE;
output wire SI;
output wire [3:0] an;
output wire [6:0] seg;
output wire [5:1] led;
wire PULSE;
wire [15:0] display;

pulseGen P1 (CLK, START, MODE, PULSE, RESET);

tracker T1 (CLK, RESET, PULSE, display, SI, led[4:1], led[5]);

sevenSeg S3 (CLK, display, an, seg);

endmodule
