module top(CLK, RST, Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw);

input CLK, RST;
output Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw;

wire SlowCLK;

trafficLight T1 (SlowCLK, RST, Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw);
complexDivider D1(CLK, SlowCLK);

endmodule
