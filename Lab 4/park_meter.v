`define MAX 16'b1001100110011001	//BCD # 9999
`define MIN 16'b0000000000000000	//BCD # 0
`define counter 10

module park_meter(clk10Hz, res10, res205, b50, b150, b200, b500, BCD_num);

input clk10Hz, res10, res205, b50, b150, b200, b500; 
output reg[15:0] BCD_num;

reg [13:0] counter;
reg [15:0] to_add;

wire add50, add150, add200, add500, zero, overflow;
wire[3:0] press;
wire[15:0] dec_num, add_num;

SP_debouncer D0 (b50, add50, clk10Hz);
SP_debouncer D1 (b150, add150, clk10Hz);
SP_debouncer D2 (b200, add200, clk10Hz);
SP_debouncer D3 (b500, add500, clk10Hz);

BCD4_adder 		A0 		(BCD_num, to_add, add_num, overflow);
BCD4_decrement	Dec0	(BCD_num, dec_num, zero);

initial
begin
to_add = `MIN;
counter = 0;
BCD_num = `MIN;
end

assign press[3:0] = {add50, add150, add200, add500};

always @(posedge clk10Hz)	//assuming that clock runs at 10Hz (or lower?)
begin
	counter = counter + 1;
	if (counter == `counter)
		counter <= 0;
	if(res10 == 1)
	 begin
		BCD_num = 16'b0000000000010000;
		to_add = to_add;
	end
	else if(res205 == 1)
    begin
		BCD_num = 16'b0000001000000101;
		to_add = to_add;
	end
	else
		begin
			case(press)
				1: to_add = 16'b0000010100000000;   //500
				2: to_add = 16'b0000001000000000;   //200
				4: to_add = 16'b0000000101010000;   //150
				8: to_add = 16'b0000000001010000;   //50
				default: to_add = `MIN;             //0
			endcase
			if(overflow == 1)
				BCD_num = `MAX;
			else
				BCD_num = add_num;
			if (counter == `counter)		//decrement every second
			begin
				if(zero == 1)
					BCD_num = `MIN;
				else
					BCD_num = dec_num;
			end
			else
				BCD_num = BCD_num;
		end
end

endmodule

