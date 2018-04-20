module distanceCount(CLK, steps, distWhole, distFrac);
input CLK, steps;       //step signal from pulse gen
output reg [3:0] distFrac;
output reg [6:0] distWhole; //up to 127 miles (7 bits)

reg increment;
reg [13:0] counter;
reg [20:0] totalSteps, distance;			// not sure what these are for

initial
begin
	increment = 0;
end

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
