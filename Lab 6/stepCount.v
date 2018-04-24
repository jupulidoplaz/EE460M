module stepCount(clk, pulse, stepCount, SI, reset);
input clk, reset, pulse;
reg [13:0] totalSteps;
output reg [13:0] stepCount;
output wire SI;
reg lock;

initial
begin
    lock = 0;
end

assign SI = (totalSteps <= 9998) ? 0 : 1;    

    
always @(posedge clk)
begin
    stepCount <= totalSteps;
end
    
always @(posedge pulse or posedge reset)
begin
    if (reset)
        totalSteps <= 0;
    else begin
        if (totalSteps == 9999)
            totalSteps <= 9999;
        else
            totalSteps <= totalSteps + 1;    //need to check the bits of totalSteps
    end
end


endmodule
