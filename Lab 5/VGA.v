module VGA(clk25MHz, hsync, vsync, R, G, B, SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7);
input clk25MHz, SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7;
output hsync, vsync, R, G, B;

reg [10:0] hcount, vcount;				// increment variables for horizontal and vertical directions
wire [3:0] R,G,B;
reg [3:0] Rtemp, Gtemp, Btemp;
wire hsync, vsync;

initial
begin
	hcount = 798;
	vcount = 492;
	Rtemp = 0;
	Gtemp = 0;
	Btemp = 0;
end

always @(posedge clk25MHz)
begin
	if (hcount < 799) hcount <= hcount + 1;
	else
	begin
		if (vcount < 524) 
		begin
			hcount <= 0;
			vcount <= vcount + 1;
		end
		else
		begin
			hcount <= 0;
			vcount <= 0;
		end
	end
end

always @(SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7)
begin
	if (SW1 == 1) 				// SW1	Blue		horizontal in visible range
	begin
		Rtemp <= 0;
		Gtemp <= 0;
		Btemp <= 4'b1111;	// 255
	end
	else if (SW2 == 1) 			// SW2	Brown
	begin
		Rtemp <= 4'b1010;	// 168
		Gtemp <= 4'b0010;	// 42
		Btemp <= 4'b0010;	// 42
	end
	else if (SW3 == 1) 			// SW3	Cyan
	begin
		Rtemp <= 0;
		Gtemp <= 4'b1000;	// 139
		Btemp <= 4'b1000;	// 139
	end
	else if (SW4 == 1) 			// SW4	Red
	begin			
		Rtemp <= 4'b1111;	// 255
		Gtemp <= 0;
		Btemp <= 0;
	end
	else if (SW5 == 1) 			// SW5	Magenta
	begin
		Rtemp <= 4'b1000;	// 139
		Gtemp <= 0;
		Btemp <= 4'b1000;	// 139
	end
	else if (SW6 == 1) 			// SW6	Yellow
	begin
		Rtemp <= 4'b1111;	// 255
		Gtemp <= 4'b1111;	// 255
		Btemp <= 0;
	end
	else if (SW7 == 1) 			// SW7	White
	begin
		Rtemp <= 4'b1111;	// 255
		Gtemp <= 4'b1111;	// 255
		Btemp <= 4'b1111;	// 255
	end
	else 					// SW1 or None	Black
	begin
		Rtemp <= 0;
		Gtemp <= 0;
		Btemp <= 0;
	end
end

assign vsync = ((vcount == 493) || (vcount == 494)) ? 0 : 1;
assign hsync = ((hcount <= 755) && (hcount >= 659)) ? 0 : 1;
assign R = ((hcount <= 639) && (vcount <= 479)) ? Rtemp : 0;
assign G = ((hcount <= 639) && (vcount <= 479)) ? Gtemp : 0;
assign B = ((hcount <= 639) && (vcount <= 479)) ? Btemp : 0;

endmodule
