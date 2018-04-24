module highActivity(clk, pulse, secClk, secs, reset);
input clk, pulse, reset, secClk; //pulse is step signal from pulse generator
output reg [8:0] secs; //up to 8.5 mins
reg [7:0] stepCount; //up to 255 steps/sec
reg [8:0] secCount; //amount of seconds that steps has been >= 64 per minute
reg secFlag, oldSecFlag, oldPulse, pauseSec;

initial
begin
    secs = 0;
    stepCount = 0;
    secCount = 0;
   // lock = 0;
    secFlag = 0;
end

always @(posedge clk)
begin
    if(pulse == oldPulse)
        pauseSec <= 1;
    else
        pauseSec <= 0;
    oldPulse = pulse;    
end

always@(posedge pulse)begin         //when pulses stop, stepCount will get stuck in whatever it was before
    if(!reset) begin 
        if(oldSecFlag == secFlag) begin
            stepCount <= stepCount + 1;
        end
        else    begin
            stepCount <= 1;
        end
        
        oldSecFlag <= secFlag;    //to make sure to clr stepCount every new second
    end
    else    begin
        stepCount <= 0;
        oldSecFlag <= secFlag;
    end
end


always @(posedge secClk or posedge reset) begin
    secFlag = ~secFlag;
    if (reset)  begin
        secCount <= 0;
        secs <= 0; 
       // lock <= 1;
    end
    else    begin
        //lock <= 0;
        if(pauseSec)    begin
            secCount <= secCount;
            secs <= secs;
        end
        else    begin    
            if(stepCount < 64)  begin
                secCount <= 0;
                secs <= secs;
            end
            
            else    begin
                if(secs < 60)   begin      
                    secCount <= secCount + 1;
                    if(secCount == 60)
                        secs <= 60;
                    else
                        secs <= secs;
                end
                else    begin
                    secs <= secs +1;
                    secCount <= 0;
                end
            end
        end
    end
end
    
endmodule
    
