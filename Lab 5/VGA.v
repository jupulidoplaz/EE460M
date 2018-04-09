module VGA(clk25MHz, hsync, vsync, R, G, B, SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7);
input clk25MHz, SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7;
output hsync, vsync, R, G, B;

reg [10:0] hcount, vcount;				// increment variables for horizontal and vertical directions
reg [3:0] R,G,B;
reg hsync, vsync;

initial
begin
	hcount = 0;
	vcount = 0;
end

always @(posedge clk25MHz)
begin
	if (vcount <= 479)							// vertical in visible range
	begin
		if (hcount >= 640)						// horizontal not in visible range
		begin
			if ((hcount <= 755) && (hcount >= 659)) 	// hsync = 0
			begin
				R <= 0;
				G <= 0;
				B <= 0;
				hcount <= hcount + 1;
				hsync <= 0;
				vsync <= 1;
				vcount <= vcount;
			end
			else if (hcount >= 799) 			// hcount reset
			begin
				R <= 0;
				G <= 0;
				B <= 0;
				hcount <= 0;
				hsync <= 1;
				vsync <= 1;
				vcount <= vcount + 1;
			end
			else						// hsync = 1
			begin
				R <= 0;
				G <= 0;
				B <= 0;
				hcount <= hcount + 1;
				hsync <= 1;
				vsync <= 1;
				vcount <= vcount;
			end
		end
		else if (SW1 == 1) 			// SW1	Blue		horizontal in visible range
		begin
			R <= 0;
			G <= 0;
			B <= 4'b1111;	// 255
			hcount <= hcount + 1;
			hsync <= 1;
			vsync <= 1;
			vcount <= vcount;
		end
		else if (SW2 == 1) 			// SW2	Brown
		begin
			R <= 4'b1010;	// 168
			G <= 4'b0010;	// 42
			B <= 4'b0010;	// 42
			hcount <= hcount + 1;
			hsync <= 1;
			vsync <= 1;
			vcount <= vcount;
		end
		else if (SW3 == 1) 			// SW3	Cyan
		begin
			R <= 0;
			G <= 4'b1000;	// 139
			B <= 4'b1000;	// 139
			hcount <= hcount + 1;
			hsync <= 1;
			vsync <= 1;
			vcount <= vcount;
		end
		else if (SW4 == 1) 			// SW4	Red
		begin			
			R <= 4'b1111;	// 255
			G <= 0;
			B <= 0;
			hcount <= hcount + 1;
			hsync <= 1;
			vsync <= 1;
			vcount <= vcount;
		end
		else if (SW5 == 1) 			// SW5	Magenta
		begin
			R <= 4'b1000;	// 139
			G <= 0;
			B <= 4'b1000;	// 139
			hcount <= hcount + 1;
			hsync <= 1;
			vsync <= 1;
			vcount <= vcount;
		end
		else if (SW6 == 1) 			// SW6	Yellow
		begin
			R <= 4'b1111;	// 255
			G <= 4'b1111;	// 255
			B <= 0;
			hcount <= hcount + 1;
			hsync <= 1;
			vsync <= 1;
			vcount <= vcount;
		end
		else if (SW7 == 1) 			// SW7	White
		begin
			R <= 4'b1111;	// 255
			G <= 4'b1111;	// 255
			B <= 4'b1111;	// 255
			hcount <= hcount + 1;
			hsync <= 1;
			vsync <= 1;
			vcount <= vcount;
		end
		else 					// SW1 or None	Black
		begin
			R <= 0;
			G <= 0;
			B <= 0;
			hcount <= hcount + 1;
			hsync <= 1;
			vsync <= 1;
			vcount <= vcount;
		end
	end
	else if ((vcount == 493) || (vcount == 494))				// vsync = 0
	begin
		if ((hcount >= 659) || (hcount <= 755))
		begin
			R <= 0;
			G <= 0;
			B <= 0;
			vsync <= 0;					// I need to include hsync to reduce latches, right? Does that mean hsync can be high even when in lower part of screen?
			vcount <= vcount;
			hsync <= 0;
			hcount <= hcount + 1;
		end
		else if (hcount >= 799)
		begin
			R <= 0;
			G <= 0;
			B <= 0;
			vsync <= 0;					
			vcount <= vcount + 1;
			hsync <= 1;
			hcount <= 0;
		end
		else
		begin
			R <= 0;
			G <= 0;
			B <= 0;
			vsync <= 0;					
			vcount <= vcount;
			hsync <= 1;
			hcount <= hcount + 1;
		end
	end
	else if (vcount >= 524)
	begin
		if ((hcount >= 659) || (hcount <= 755))
		begin
			R <= 0;
			G <= 0;
			B <= 0;
			vsync <= 1;					
			vcount <= vcount;
			hsync <= 0;
			hcount <= hcount + 1;
		end
		else if (hcount >= 799)
		begin
			R <= 0;
			G <= 0;
			B <= 0;
			vsync <= 1;					
			vcount <= 0;
			hsync <= 1;
			hcount <= 0;
		end
		else
		begin
			R <= 0;
			G <= 0;
			B <= 0;
			vsync <= 1;					
			vcount <= vcount;
			hsync <= 1;
			hcount <= hcount + 1;
		end
	end
	else
	begin
		if ((hcount >= 659) || (hcount <= 755))
		begin
			R <= 0;
			G <= 0;
			B <= 0;
			vsync <= 1;					
			vcount <= vcount;
			hsync <= 0;
			hcount <= hcount + 1;
		end
		else if (hcount >= 799)
		begin
			R <= 0;
			G <= 0;
			B <= 0;
			vsync <= 1;					
			vcount <= vcount + 1;
			hsync <= 1;
			hcount <= 0;
		end
		else
		begin
			R <= 0;
			G <= 0;
			B <= 0;
			vsync <= 1;					
			vcount <= vcount;
			hsync <= 1;
			hcount <= hcount + 1;
		end
	end
end

endmodule
