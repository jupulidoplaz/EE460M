module step32(CLK, steps, secClk, secs, reset);
input CLK, secClk, steps, reset;
output [3:0] secs;
reg [20:0] totalSteps; 
reg [3:0] secCount, oldSecCount, secs;
reg resFlag;
reg [6:0] stepCount;
initial
begin
    stepCount = 0;
    secCount = 0;
    oldSecCount = 0;
    secs = 0;
    resFlag = 0;
end
    
always @(posedge secClk or posedge reset or negedge reset)
begin
    if(reset)
    begin
        secCount <= 0;
        resFlag <= 1;   //means reset is high
    end    
    else begin
        resFlag <= 0;   //means reset is low
        if (secCount <= 9)  begin
            secCount = secCount + 1;
            if(stepCount >= 32)
                secs = secs + 1;
            else secs = secs;
        end
        else begin
            secCount = 10;
            secs = secs;
        end
    end
end
    
always@(posedge steps)
begin
    if (secCount <= 9 && !resFlag) begin
        if(secCount != oldSecCount) 
            stepCount = 1;

        else
	begin
	    stepCount = stepCount + 1;
            oldSecCount <= secCount;
	end
    end
    else begin
        stepCount = stepCount;
        oldSecCount = oldSecCount;
    end
        
end
    
endmodule
