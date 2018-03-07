`define MAX 16'b1001100110011001
`define MIN 16'b0000000000000000
module park_meter(CLK, res10, res205, b50, b150, b200, b500, AN3, AN2, AN1, AN0, A, B, C, D, E, F, G);

input CLK, res10res205, b50, b150, b200, b500; 
output AN0, AN1, AN2, AN3, A, B, C, D, E, F, G;

reg [13:0] time_left, counter;
reg [15:0] BCD_num, toadd;

wire add50, add150, add200, add500, zero, overflow;
wire[15:0] dec_num, add_num;

SP_debouncer D0 (b50, add50, CLK);
SP_debouncer D1 (b150, add150, CLK);
SP_debouncer D2 (b200, add200, CLK);
SP_debouncer D3 (b500, add500, CLK);

BCD4_adder A0 (BCD_num, toadd, add_num, overflow)

BCD4_decrement Dec (BCD_num, dec_num, zero);

initial
begin
toadd = 0;
counter = 0;
time_left = 0;
end

assign press[3:0] = {add50, add150, add200, add500};

always @(posedge CLK)	//assuming that clock runs at 10Hz (or lower?)
begin
case(press)
	1: toadd = 16'b0000010100000000;
	2: toadd = 16'b0000001000000000;
	4: toadd = 16'b0000000101010000;
	8: toadd = 16'b0000000001010000;
	default: toadd = 0;
endcase
if(overflow == 1)
	BCD_num <= `MAX;
else
	BCD_num <= add_num;
counter <= counter + 1;
if (counter == 10)		//decrement every second
begin
	if(zero == 1)
		BCD_num <= `MIN;
	else
		BCD_num <= dec_num;
end
else
	BCD_num <= BCD_num;
end

end

