module keyboard(CLK, ps2CLK, ps2DATA, an, seg, LED, LED2, register);
    
input ps2CLK, ps2DATA, CLK;
output LED, LED2;
output [3:0] an;
output [6:0] seg;
output [7:0] register;

wire [7:0] num;
wire idle, flash;

reader R1 (ps2CLK, ps2DATA, num, idle, flash, register, LED2);
sevenSeg S1 (CLK, num, an, seg, idle);
strobe S2 (CLK, flash, LED);

endmodule
