module keyboard(CLK, ps2CLK, ps2DATA, an, seg, LED);
    
input ps2CLK, ps2DATA, CLK;
//output wire flash;
output LED;
output [3:0] an;
output [6:0] seg;

wire flash, idle;
wire [7:0] num;

reader R1 (ps2CLK, ps2DATA, num, flash, idle);
sevenSeg S1 (CLK, num, an, seg, idle);
strobe S2 (CLK, flash, LED);

endmodule
