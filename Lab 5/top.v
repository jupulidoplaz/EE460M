module top(clk, ps2CLK, ps2DATA, an, seg, LED, hsync, vsync, R, G, B, Black, playLED);

input clk, ps2CLK, ps2DATA;
output hsync, vsync, R, G, B;
output LED;
output [3:0] an;
output [6:0] seg;

wire clk25MHz;
wire [3:0] R, G, B;
wire hsync, vsync;

wire flash, idle;
wire [7:0] num;

wire Snake;
output wire Black, playLED;


complexDivider C1 (clk, clk25MHz, 2);	//needs to be 2
complexDivider C2 (clk, clk50Hz, 1000000);	//needs to be 1,000,000

Master_Controller M1 (clk, clk50Hz, clk25MHz, num, Snake, Black, playLED);

VGAController V1 (clk25MHz, hsync, vsync, R, G, B, Snake, Black);

reader R1 (ps2CLK, ps2DATA, num, flash, idle);
sevenSeg S1 (clk, num, an, seg, idle);
strobe S2 (clk, flash, LED);

endmodule
	