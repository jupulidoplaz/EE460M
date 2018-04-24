module step32(CLK, pulse, secClk, secs, reset); //pulse is the pulse signal
input CLK, secClk, pulse, reset; 
output reg [3:0] secs;
reg [3:0] secCount;
reg secFlag, oldSecFlag;
reg [7:0] stepCount;
initial
begin
   // lock = 0;
    secFlag = 0;
    oldSecFlag = 0;
    secs = 0;
    secCount = 0;
end
    
always@(posedge pulse) 
begin
 //   if (!lock)  begin
    if (!reset) begin
        if(oldSecFlag == secFlag)  
            stepCount <= stepCount + 1;
        else
            stepCount <= 1;
       // oldSecFlag <= secFlag;
    end
    else    
        stepCount <= 0;
    oldSecFlag <= secFlag;
end
    
always @(posedge secClk or posedge reset)
begin
    secFlag <= ~secFlag;
    if (reset)  begin
       // lock <= 1;
      //  secFlag <= secFlag;
        secCount <= 0;
        secs <= 0;
    end
    else    begin
       // lock <= 0;
      //  secFlag <= ~secFlag;
        secCount = secCount + 1;
        if (secCount <= 9)  begin    
            if(stepCount >= 32)
                secs <= secs + 1;
            else
                secs <= secs;
        end
        else    begin
            secs <= secs;
            secCount <= 10;
        end         
    end
end

endmodule
