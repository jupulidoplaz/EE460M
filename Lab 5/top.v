module top(CLK, SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, hsync, vsync, R, G, B);

input CLK, SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7;
output hsync, vsync, R, G, B;

wire CLK25MHz;
wire [3:0] R, G, B;
wire hsync, vsync;

complexDivider C1 (CLK, CLK25MHz, 2);	//needs to be 2

VGA V1 (CLK25MHz, hsync, vsync, R, G, B, SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7);

endmodule
