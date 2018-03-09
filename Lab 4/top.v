module top(CLK, A, B, C, D, E, F, G, AN0, AN1, AN2, AN3, res10, res205, b50, b150, b200, b500);

input b50, b150, b200, b500, res10, res205, CLK;
output A, B, C, D, E, F, G, AN0, AN1, AN2, AN3;

wire clk100kHz, clk10Hz;
wire [15:0] BCD_num;

complexDivider C1 (CLK, clk10Hz, 5000000); //needs to be 5000000
complexDivider C2 (CLK, clk1kHz, 50000);	//needs to be 50000

park_meter P1 (clk10Hz, res10, res205, b50, b150, b200, b500, BCD_num);

BCD_sevenseg S1 (BCD_num, AN3, AN2, AN1, AN0, A, B, C, D, E, F, G, clk1kHz);

endmodule
