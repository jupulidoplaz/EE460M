module trafficLight(CLK, RST, Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw);
input RST, CLK;
output Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw;

reg Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw, Before;
reg [3:0] State, NextState;
reg [2:0] FinishTime, Counter;

initial
begin
{Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw} = 8'b00000000;
Counter = 0;
NextState = 0;
FinishTime = 1;
Before = 0;
end

always @(posedge RST or negedge RST or posedge CLK)
begin
	Counter = Counter + 1;
	if (Counter == FinishTime)
		State <= NextState;
	if ((RST == 1) & (Before == 0))
	begin
		State <= 9;
		Before <= 1;
	end
	else
	begin
		if ((RST == 0) & (Before == 1))
		begin
			State <= 0;
			Before <= 0;
		end
		else
		Before <= Before;
	end
end



always @(State)
begin
	Counter = 0;
	case (State)
	0:	
		begin
			NextState <= 1;
			FinishTime <= 6;
			{Ga, Rb, Rw} <= 3'b111;
			{Ya, Ra, Yb, Gb, Gw} <= 5'b00000;
		end

	1:
		begin
			NextState <= 2;
			FinishTime <= 4;
			Ga = 0;
			Ya = 1;
			{Ra, Rb, Rw, Yb, Gb, Gw} <= {Ra, Rb, Rw, Yb, Gb, Gw};
		end

	2:
		begin
			NextState <= 3;
			FinishTime <= 6;
			{Ya, Rb} <= 2'b00;
			{Ra, Gb} <= 2'b11;
			{Rw, Yb, Ga, Gw} <= {Rw, Yb, Ga, Gw};
		end

	3:
		begin
			NextState <= 4;
			FinishTime <= 2;
			Gb <= 0;
			Yb <= 1;
			{Ra, Rb, Rw, Ya, Ga, Gw} <= {Ra, Rb, Rw, Ya, Ga, Gw}; 
		end

	4:
		begin
			NextState <= 5;
			FinishTime <= 4;
			{Yb, Rw} <= 2'b00;
			{Rb, Gw} <= 2'b11;
			{Ra, Ya, Ga, Gb} <= {Ra, Ya, Ga, Gb};
		end


	5:
		begin
			NextState <= 6;
			FinishTime <= 1;
			Gw <= 0;
			Rw <= 1;
			{Ra, Rb, Ya, Yb, Ga, Gb} = {Ra, Rb, Ya, Yb, Ga, Gb};
		end
	
	6: 
		begin
			NextState <= 7;
			FinishTime <= 1;
			Rw <= 0;
			{Ra, Rb, Ya, Yb, Ga, Gb, Gw} = {Ra, Rb, Ya, Yb, Ga, Gb, Gw};
		end

	7:
		begin
			NextState <= 8;
			FinishTime <= 1;
			Rw <= 1;
			{Ra, Rb, Ya, Yb, Ga, Gb, Gw} = {Ra, Rb, Ya, Yb, Ga, Gb, Gw};
		end

	8:
		begin
			NextState <= 0;
			FinishTime <= 1;
			Rw <= 0;
			{Ra, Rb, Ya, Yb, Ga, Gb, Gw} = {Ra, Rb, Ya, Yb, Ga, Gb, Gw};
		end

	9:
		begin
			NextState <= 10;
			FinishTime <= 2;
			{Ra, Ya, Ga, Rb, Yb, Gb, Rw, Gw} <= 8'b00000;
		end

	10:
		begin
			NextState <= 11;
			FinishTime <=2;
			{Ra, Rb, Rw} <= ~{Ra, Rb, Rw};
			{Ya, Yb, Ga, Gb, Gw} = {Ya, Yb, Ga, Gb, Gw};
		end

	11:
		begin
			NextState <= 10;
			FinishTime <=2;
			{Ra, Rb, Rw} <= ~{Ra, Rb, Rw};
			{Ya, Yb, Ga, Gb, Gw} = {Ya, Yb, Ga, Gb, Gw};
		end
	default: {Ra, Rb, Rw} <= 3'b111;
	endcase
end

endmodule
