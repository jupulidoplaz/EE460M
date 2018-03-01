module trafficLight(CLK, RST, Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw);
input CLK, RST;
output Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw;

reg Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw;
reg [3:0] State, NextState;
reg [2:0] FinishTime, Counter;

initial
begin
{Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw} = 8'b00000000;
//Counter = 0;
NextState = 0;
end

always @(RST)
begin
	if (RST == 1)
	begin
		Counter <= 0;
		State <= 9;
	end
	else
	begin
		if (RST == 0)
		State = 0;
	end
end


always @(posedge CLK)
begin
	Counter = Counter + 1;
	if (Counter == FinishTime)
		State = NextState;
end



always @(State)
begin
	Counter = 0;
	case (State)
	0:	
		begin
			NextState <= 1;
			FinishTime <= 6;
			Ra <= 0;
			{Ga, Rb, Rw} <= 3'b111;
		end

	1:
		begin
			NextState <= 2;
			FinishTime <= 4;
			Ga <= 0;
			Ya <= 1;
		end

	2:
		begin
			NextState <= 3;
			FinishTime <= 6;
			{Ya, Rb} <= 2'b00;
			{Ra, Gb} <= 2'b11;
		end

	3:
		begin
			NextState <= 4;
			FinishTime <= 2;
			Gb <= 0;
			Yb <= 1;
		end

	4:
		begin
			NextState <= 5;
			FinishTime <= 4;
			{Yb, Rw} <= 2'b00;
			{Rb, Gw} <= 2'b11;
		end

/*	5:
		begin
			NextState <= 0;
			FinishTime <= 4;
			Gw <= 0;
			Rw <= 1;
		end

	6:
		begin
			NextState <= 6;
			FinishTime <= 2;
			{Ya, Ga, Yb, Ga, Gw} <= 5'b00000;
			{Ra, Rb, Rw} <= ~{Ra, Rb, Rw};
		end */

	5:
		begin
			NextState <= 6;
			FinishTime <= 1;
			Gw <= 0;
			Rw <= 1;
		end
	
	6: 
		begin
			NextState <= 7;
			FinishTime <= 1;
			Rw <= 0;
		end

	7:
		begin
			NextState <= 8;
			FinishTime <= 1;
			Rw <= 1;
		end

	8:
		begin
			NextState <= 0;
			FinishTime <= 1;
			Rw <= 0;
		end

	9:
		begin
			NextState <= 10;
			FinishTime <= 2;
			{Ya, Ga, Yb, Ga, Gw} <= 5'b00000;
			{Ra, Rb, Rw} <= 3'b000;
		end

	10:
		begin
			NextState <= 11;
			FinishTime <=2;
			{Ra, Rb, Rw} <= ~{Ra, Rb, Rw};
		end

	11:
		begin
			NextState <= 10;
			FinishTime <=2;
			{Ra, Rb, Rw} <= ~{Ra, Rb, Rw};
		end

	endcase
end

endmodule
