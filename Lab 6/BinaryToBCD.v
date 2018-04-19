module BinaryToBCD(binary, thousands, hundreds, tens, ones);
input wire [13:0] binary;
output reg [3:0] thousands, hundreds, tens, ones;

always @(binary)
begin
	ones = binary % 10;
	tens = (binary / 10) % 10;
	hundreds = (binary / 100) % 10;
	thousands = (binary / 1000) % 10;
end

endmodule
