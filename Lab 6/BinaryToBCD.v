module BinaryToBCD(binary, thousands, hundreds, tens, ones);
input wire [13:0] binary;
output reg [3:0] thousands, hundreds, tens, ones;

reg [3:0] i;

initial
begin
	i = 14;
	hundreds = 4'b0000;
	tens = 4'b0000;
	ones = 4'b0000;
end

always @(binary)
begin
	thousands = 4'b0000;
	hundreds = 4'b0000;
	tens = 4'b0000;
	ones = 4'b0000;
	for (i = 14; i >= 0; i = i-1)
	begin
		if (thousands >= 5) thousands = thousands + 3;
		if (hundreds >= 5) hundreds = hundreds + 3;
		if (tens >= 5) tens = tens + 3;
		if (ones >= 5) ones = ones + 3;
		thousands = thousands << 1;
		thousands[0] = hundreds[3];
		hundreds = hundreds << 1;
		hundreds[0] = tens[3];
		tens = tens << 1;
		tens[0] = ones[3];
		ones = ones << 1;
		ones[0] = binary[i];
	end
end

endmodule
