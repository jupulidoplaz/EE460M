module VGAController(clk25MHz, hsync, vsync, R, G, B, Snake, Black);
input clk25MHz, Snake, Black;
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

always @(Snake, Black)
begin
    if (Black == 1)
    begin
        Rtemp <= 0;
        Gtemp <= 0;
        Btemp <= 0;
    end
    else
    begin
    	if (Snake == 1) 				// Blue		snake showing
    	begin
    		Rtemp <= 0;
    		Gtemp <= 0;
    		Btemp <= 4'b1111;	// 255
    	end
    	else 					// White
    	begin
    		Rtemp <= 4'b1111;	// 255
    		Gtemp <= 4'b1111;	// 255
    		Btemp <= 4'b1111;	// 255
    	end
    end
end

assign vsync = ((vcount == 493) || (vcount == 494)) ? 0 : 1;
assign hsync = ((hcount <= 755) && (hcount >= 659)) ? 0 : 1;
assign R = ((hcount <= 639) && (vcount <= 479)) ? Rtemp : 0;
assign G = ((hcount <= 639) && (vcount <= 479)) ? Gtemp : 0;
assign B = ((hcount <= 639) && (vcount <= 479)) ? Btemp : 0;

endmodule

