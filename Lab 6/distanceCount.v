module distanceCount (clk, pulse, whole, frac, reset);
input clk, pulse, reset;
output reg [6:0] whole;
output reg [2:0] frac;
reg [10:0] pulseCount;
reg increment, done;

initial
begin
    whole = 0;
    frac = 0;
    pulseCount = 0;
    increment = 0;
    done = 0;
   // lock = 0;
end

always @(posedge clk or posedge reset or negedge reset)
begin
    if (reset) begin
        whole <= 0;
        frac <= 0;
      //  lock <= 1;
    end
    else if (increment && !done) begin  //done makes sure it only increments once
      //  lock <= 0;                      //lock makes sure that it starts back up again when reset is deasserted
        done <= 1;
        if(!frac)   begin
            frac <= 5;
            whole <= whole;
        end       
        else begin
            frac <= 0;
            whole <= whole + 1;
        end 
    end
    else if(!increment) begin
     //   lock <= 0;
        done <= 0;
        frac <= frac;
        whole <= whole;
    end   
    else    begin
      //  lock <= 0;
        done <= done;
        frac <= frac;
        whole <= whole;
    end
end

always @(posedge pulse)
begin
    if (reset)   begin
        pulseCount <= 0;
        increment <= 0;
    end
    else begin
        pulseCount = pulseCount + 1;
        if(pulseCount == 1024)  begin
            pulseCount <= 0;
            increment <= 1;
        end
        else    begin
            pulseCount <= pulseCount;
            increment <= 0;
        end
    end
end

endmodule
