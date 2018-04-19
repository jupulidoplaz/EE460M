module Fitbit(clk, reset, pulse, display, saturate);			
input clk, reset, pulse;
output reg [13:0] display;							// display is in binary
output saturate;

parameter STEPS 0;
parameter DISTANCE 1;
parameter STEPS32 2;
parameter ACTIVITY 3;

reg lastPulse;
reg [1:0] mode;
reg [13:0] steps, distance, steps32, activity;

wire [13:0] displaySteps;

initial
begin
	lastPulse = 0;
end

always @(posedge clk, posedge reset)
begin

	if ((pulse != lastPulse) && (pulse == 1)) steps = steps + 1;			// checks for posegde of pulse (way to implement always @(posedge pulse) ?)
	else steps = steps;
	lastPulse = pulse;

	if (reset)								// reset
	begin
		steps = 0;
		distance = 0;
		steps32 = 0;
		activity = 0;
		saturate = 0;
	end
	else if (mode == STEPS)							// display steps
	begin
		steps = steps;
		distance = distance;
		steps32 = steps32;
		activity = activity;

		if (steps >= 10000) saturate = 1;
		else saturate = 0;
		display = displaySteps;
	end
	else if (mode == DISTANCE)
	begin									// for .5 increments, do distance = distance - (distance % 500)
		
	end
end

assign displaySteps = (steps > 9999) ? 9999 : steps;					// need to keep track of steps while only displaying 9999

endmodule
