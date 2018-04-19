module distanceCount(CLK, steps, distWhole, distFrac);
input CLK, steps;       //step signal from pulse gen
input [20:0] totalSteps;
output [20:0] distance;
output [3:0] distFrac;
output [6:0] distWhole; //up to 127 miles (7 bits)

always @(posedge CLK)   
begin
    if(increment)
    begin
        if(distFrac == 0)
        begin
            distFrac = 5;
            distWhole = distWhole;
        end
        else
        begin
            distFrac = 0;
            distWhole = distWhole + 1;
        end            
    end
    
end

    always@(posedge steps)
begin
    counter = counter + 1;
    if(counter == 1024)
    begin
        increment <= 1;
        counter <= 0;
    end
    else
    begin
        increment <= 0;
        counter <= counter;
    end    
end
endmodule
    
