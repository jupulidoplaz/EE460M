`define endflash 100 //should be 10000000
module strobe(CLK, flash, LED);

input CLK, flash;
output reg LED; 
reg[23:0] counter;


initial
begin
    LED = 0;
    counter = 0;
end
    


always@(negedge flash)
begin
    if (counter < `endflash)
    begin
        counter = counter + 1;
        LED = 1;
    end
    else
    begin
        counter = 0;
        LED = 0;
    end
end
    
endmodule
