`define Xdig0 X[3:0]
`define Xdig1 X[7:4]
`define Xdig2 X[11:8]
`define Xdig3 X[15:12]
`define Zdig0 Z[3:0]
`define Zdig1 Z[7:4]
`define Zdig2 Z[11:8]
`define Zdig3 Z[15:12]

module BCD4_decrement(X, Z, Bo); //decrements BCD number X by 1 and outputs Z.
input [15:0] X;
output [15:0] Z;
output Bo;			//comes out as 1 if overflowed 

wire[3:0] D1, D2, D3;
wire B0, B1, B2;

assign `Zdig0 = (`Xdig0 < 1) ? 4'b1001 : (`Xdig0 - 1); 
assign B0 = (`Xdig0 < 1) ? 1'b1 : 1'b0;

assign D1 = `Xdig1 - B0;
assign `Zdig1 = (D1 == 4'b1111) ? 4'b1001 : (D1);
assign B1 = (D1 == 4'b1111) ? 1'b1 : 1'b0;

assign D2 = `Xdig2 - B1;
assign `Zdig2 = (D2 == 4'b1111) ? 4'b1001 : (D2);
assign B2 = (D2 == 4'b1111) ? 1'b1 : 1'b0;

assign D3 = `Xdig3 - B2;
assign `Zdig3 = (D3 == 4'b1111) ? 4'b1001 : (D3);
assign Bo = (D3 == 4'b1111) ? 1'b1 : 1'b0;
endmodule
