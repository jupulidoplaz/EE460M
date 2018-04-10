`define endflash 10000000 //should be 10000000
module strobe(CLK, flash, LED);

input CLK, flash;
output reg LED; 
reg[23:0] counter;
reg flag, lock;


initial
begin
    LED = 0;
    counter = 0;
    flag = 0;
    lock = 0;
end
    


always@(flash)
begin
    if (!flash)
        flag = 1;
    else
        flag = 0;
end

always @(posedge CLK)
begin
    if (flag && !lock)
    begin
        counter = `endflash;
        lock = 1;
        LED = LED;
    end
    else if (flag && lock)
    begin 
        if (counter > 0)
        begin
            counter = counter - 1;
            LED = 1;
            lock = 1;
        end
        else
        begin
            counter = 0;
            LED = 0;
            lock = 1;
        end
    end
    else
    begin
        counter = 0; 
        LED = 0;
        lock = 0;
    end
end

endmodule
