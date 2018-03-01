module trafficLight(CLK, RST, Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw);
input CLK, RST;
output Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw;

reg Counter, FinishTime, State, NextState, Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw;

initial
begin
Counter = 0;
State = 0;
end

always @(RST)
if (RST == 1)
Counter = 0;
State = 6;
else
State = 0;
end


always @(posedge CLK)
begin
Counter = Counter + 1;
if(State == 5)
Rw = ~Rw;
if (Counter == FinishTime)
	State = NextState;
	Counter = 0;
end



always @(State)
begin
	case (State)
	0:	
		begin
			NextState = 1;
			FinishTime = 6;
			Ra = 0;
			{Ga, Rb, Rw} = 3'b111;
		end

	1:
		begin
			NextState = 2;
			FinishTime = 4;
			Ga = 0;
		end

	2:
		begin
			NextState = 3;
			FinishTime = 6;
			{Ya, Rb} = 2'b00;
			{Ra, Gb} = 2'b11;
		end

	3:
		begin
			NextState = 4;
			FinishTime = 2;
			Gb = 0;
			Yb = 1;
		end

	4:
		begin
			NextState = 5;
			FinishTime = 4;
			{Yb, Rw} = 2'b00;
			{Rb, Gw} = 2'b11;
		end

	5:
		begin
			NextState = 0;
			FinishTime = 4;
			Gw = 0;
			Rw = 1;
		end

	6:
		begin
			NextState = 6;
			FinishTime = 2;
			{Ya, Ga, Yb, Ga, Gw} = 5'b00000;
			{Ra, Rb, Rw} = ~{Ra, Rb, Rw};
		end
	endcase
end
