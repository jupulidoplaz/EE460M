`define endflash 10000000 //should be 10000000
module strobe(CLK, flash, LED);

input CLK, flash;
output reg LED; 
reg[23:0] counter;
reg lock, state;

initial
begin
    LED = 0;
    counter = 0;
    lock = 0;
    state = 0;
end
    


always@(posedge CLK)
begin
    if(flash && lock)
    begin
        state = 1;
        lock = 1;
    end
    
    else if(flash && !lock)
    begin
        state = 1;
        lock = 1;
    end
    
    else if(!flash && lock)
    begin
        state = 1;
        lock = 1;
    end
    
    else
    begin
        state = 0;
        lock = 0;
    end
        
    case(state)
    0:  begin
            LED <=0;
            counter <=0;
            //state <= 0;
        end
    1:  begin
            if(counter >= `endflash)
            begin
                LED <= 0;
                counter <= 0;
                lock <= 0;
                //state <= 0;
            end
            else
            begin
                LED <= 1;
                counter <= counter +1;
                //state <= 1;
            end
        
        end
    endcase
    
end
    
endmodule
