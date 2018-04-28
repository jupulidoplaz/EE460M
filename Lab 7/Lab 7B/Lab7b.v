module Lab7b(CLK, R1, BTNL, BTNR, an, seg);
input CLK, BTNL, BTNR;
input wire [2:0] R1;
output [3:0] an;
output [6:0] seg;

reg RST, slowClk;
wire [31:0] R2, R3;
wire CS, WE, dBTNL, dBTNR;
wire [31:0] Mem_Bus;
wire [6:0] Address;
wire [15:0] display;

initial
begin
  RST = 0;
end

complexDivider C1(CLK, slowClk, 100000);
MIPS CPU(CLK, RST, CS, WE, Address, Mem_Bus, R1, R2, R3);
Memory MEM(CS, WE, CLK, Address, Mem_Bus);
sevenSeg SEG(CLK, display, an, seg);
debouncer BL(slowClk, BTNL, dBTNL);
debouncer BR(slowClk, BTNR, dBTNR);

assign display = ((R1 == 0) && dBTNL)? ((dBTNR)? (R3 >> 16) : R3[15:0]) : ((dBTNR)? (R2 >> 16) : R2[15:0]);

endmodule
