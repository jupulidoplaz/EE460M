module highActivity(CLK, reset, secClk, secs);
input CLK, secClk, reset; //steps is step signal from pulse generator
output reg [13:0] secs;

reg [13:0] steps;
reg [5:0] secCount;
reg minFlag, stepReset;

//    assign secs = (enable)			// idk what this is
    
initial 
begin
    minFlag = 0;
    secCount = 0;
	stepReset = 0;
end
    
always @(posedge secClk, reset)
begin
	secCount = secCount + 1;
	if (reset)			// reset
	begin
		secs = 0;
		secCount = 0;
		minFlag = 0;
		stepReset = 0;
	end
	else if ((secCount == 60) && (steps >= 64))	// if 60 steps with high activity, add 60 to display
	begin
		secs = secs + 60;
		secCount = secCount;
	end
	else if (secCount > 60)				// display after 60 seconds
	begin
		if (steps >= 64)
		begin
			secs = secs + 1;
			secCount = 61;				// use 61 to avoid previous if statement
		end
		else
		begin
			secs = secs;
			secCount = 0;
		end
		minFlag = 1;
	end
	else if (steps >= 64)				// continue
	begin
		secs = secs;
		secCount = secCount;
	end	
	else						// too few steps before 60 seconds
	begin
		secs = secs;
		secCount = 0;
	end

	stepReset = 1;
	stepReset = 0;					// to trigger resetting of steps
	minFlag = 0;
end
    

always@(posedge steps, reset, posedge stepReset)
begin
	if (reset | stepReset) steps = 0;
	else steps = steps + 1;
end

endmodule
