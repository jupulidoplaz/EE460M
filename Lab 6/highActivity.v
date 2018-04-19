module highActivity(CLK, steps, secClk, secs);
input CLK, steps, secClk; //steps is step signal from pulse generator
output [13:0] secs;
reg [5:0] secCount;
reg minFlag;

    assign secs = (enable)
    
initial 
begin
    minFlag = 0;
    secCount = 0;
end
    
always @(secClk)
begin
    secCount = secCount + 1;
    if (secCount == 60)
    begin
        secCount = 0;
        minFlag = 1;
    end
    else
    begin
        secCount = secCount;
        minFlag = 0;
    end
end
    

always@(posedge steps)
begin
    
end
endmodule
