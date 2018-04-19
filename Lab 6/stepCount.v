module stepCount(CLK, totalSteps, stepCount, SI);
input CLK;
input [20:0] totalSteps;
output reg [13:0] stepCount;
output reg SI;

always @(posedge CLK)
begin
if (totalSteps <= 9998)
    stepCounter = totalSteps;
    SI = 0;
else
    stepCounter = 9999;
    SI = 1;
end

endmodule
