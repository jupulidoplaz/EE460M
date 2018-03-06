module park_meter(CLK, res10, res205, add50, add150, add200, add500, AN3, AN2, AN1, AN0, A, B, C, D, E, F, G);

input CLK, res10res205, add50, add150, add200, add500; 
reg [13:0] time_left, counter;
output AN0, AN1, AN2, AN3, A, B, C, D, E, F, G;


initial
begin
counter = 0;
time_left = 0;
end

always @(posedge CLK)	//assuming that clock runs at 2 Hz
begin
counter = counter + 1;
end


