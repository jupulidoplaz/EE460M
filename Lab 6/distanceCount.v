module distanceCount(CLK, totalSteps, distWhole, distFrac);
input CLK;
input [20:0] totalSteps;
output [20:0] distance;
output [3:0] distFrac;
output [6:0] distWhole; //up to 127 miles (7 bits)

always @(posedge CLK)    
begin
    distWhole = totalSteps / 2048;
    if((totalSteps % 2048) < 1024)
        distFrac = 0;
    else
        distFrac = 5;
end
    
    
endmodule
