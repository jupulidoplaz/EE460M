module Fitbit(clk, reset, pulse, display, mode, saturate);			
input clk, reset, pulse;
output reg [13:0] display;							// display is in binary
output reg [1:0] mode;
output saturate;

parameter STEPS 0;
parameter DISTANCE 1;
parameter STEPS32 2;
parameter ACTIVITY 3;

parameter timeForOneSecond 0;					// *****NEED TO CHANGE*** make this the amount of clock cycles it takes for one second to pass

reg lastPulse;
reg [13:0] steps, distance, steps32, activity, tempSteps;
reg [15:0] timeCount;
wire [13:0] displaySteps;

initial
begin
	steps = 0;
	lastPulse = 0;
	timeCount = 0;
end

always @(posedge clk, posedge reset)
begin

	if (reset)								// reset
	begin
		distance <= 0;
		activity <= 0;
		saturate <= 0;
	end
	else if (mode == STEPS)				//steps
	begin
		steps <= steps;
		distance <= distance;
		steps32 <= steps32;
		activity <= activity;

		if (steps >= 10000) saturate = 1;
		else saturate <= 0;
		display <= displaySteps;
	end
	else if (mode == DISTANCE)			// distance
	begin
		display <= (steps / 1024) * 5;				// distance is one decimal place to the right, display controller should interpret that
	end
	else if (mode == STEPS32)			// steps32
	begin
		display <= steps32;
	end
	else						// activity
	begin
		
	end
end

always @(posedge pulse, reset)			// step tracker
begin
	if (reset) steps = 0;
	else steps = steps + 1;
end

always @(posedge clk, reset)			// steps32 tracker
begin
	timeCount = timeCount + 1;
	if (reset)
	begin
		timeCount = 0;
	end
	if (timeCount == timeForOneSecond)
	begin
		if (steps > 32) steps32 = steps32 + 1;
		tempSteps = steps;
	end
	if (timeCount == (timeForOneSecond * 2))
	begin
		if ((steps - tempSteps) > 32) steps32 = steps32 + 1;
		tempSteps = steps;
	end
	if (timeCount == (timeForOneSecond * 3))
	begin
		if ((steps - tempSteps) > 32) steps32 = steps32 + 1;
		tempSteps = steps;
	end
	if (timeCount == (timeForOneSecond * 4))
	begin
		if ((steps - tempSteps) > 32) steps32 = steps32 + 1;
		tempSteps = steps;
	end
	if (timeCount == (timeForOneSecond * 5))
	begin
		if ((steps - tempSteps) > 32) steps32 = steps32 + 1;
		tempSteps = steps;
	end
	if (timeCount == (timeForOneSecond * 6))
	begin
		if ((steps - tempSteps) > 32) steps32 = steps32 + 1;
		tempSteps = steps;
	end
	if (timeCount == (timeForOneSecond * 7))
	begin
		if ((steps - tempSteps) > 32) steps32 = steps32 + 1;
		tempSteps = steps;
	end
	if (timeCount == (timeForOneSecond * 8))
	begin
		if ((steps - tempSteps) > 32) steps32 = steps32 + 1;
		tempSteps = steps;
	end
	if (timeCount == (timeForOneSecond * 9))
	begin
		if ((steps - tempSteps) > 32) steps32 = steps32 + 1;
		tempSteps = steps;
	end
end

assign displaySteps = (steps > 9999) ? 9999 : steps;					// need to keep track of steps while only displaying 9999

endmodule
