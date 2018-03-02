module trafficLight(CLK, RST, Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw);
input RST, CLK;
output Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw;

reg Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw, Before;
reg [3:0] State, NextState, FinishTime, Counter;

initial
begin
{Ga, Ya, Ra, Gb, Yb, Rb, Gw, Rw} = 8'b00000000;
Counter = 0;
NextState = 0;
FinishTime = 1;
Before = 0;			//flag for RST: if Before = 0, RST has not been previously 1
end 				//				if Before = 1, RST has been previously 1


always @(posedge CLK)		//changes Counter, State, and Before
begin
	if ((RST == 1) & (Before == 0))
	begin
		Counter = 0;
		State <= 13;
		Before <= 1;
	end
	else
	begin
		if ((RST == 0) & (Before == 1))
		begin
			Counter = 0;
			State <= 0;
			Before <= 0;
		end
		else
		begin
			Counter = Counter + 1;
			if (Counter == FinishTime)
				begin
					Counter = 0;
					State <= NextState;
					Before <= Before;
				end
			else
				begin
					State <= State;
					Counter <= Counter;
					Before = Before;
				end
		end
	end


end



always @(State)			//changed NextState, FinishTime and all lights
begin
	case (State)
	0:	
		begin
			NextState <= 1;
			FinishTime <= 12;
			{Ga, Rb, Rw} <= 3'b111;
			{Ya, Ra, Yb, Gb, Gw} <= 5'b00000;
		end

	1:
		begin
			NextState <= 2;
			FinishTime <= 8;
            {Ya, Rb, Rw} <= 3'b111;
            {Ga, Ra, Yb, Gb, Gw} <= 5'b00000;
		end

	2:
		begin
			NextState <= 3;
			FinishTime <= 12;
            {Ra, Gb, Rw} <= 3'b111;
            {Ga, Ya, Yb, Rb, Gw} <= 5'b00000;
		end

	3:
		begin
			NextState <= 4;
			FinishTime <= 4;
            {Ra, Yb, Rw} <= 3'b111;
            {Ga, Ya, Rb, Gb, Gw} <= 5'b00000;
		end

	4:
		begin
			NextState <= 5;
			FinishTime <= 8;
            {Ra, Rb, Gw} <= 3'b111;
            {Ga, Ya, Yb, Gb, Rw} <= 5'b00000;
		end


	5:
		begin
			NextState <= 6;
			FinishTime <= 1;
            {Ra, Rb, Rw} <= 3'b111;
            {Ga, Ya, Yb, Gb, Gw} <= 5'b00000;
		end
	
	6: 
		begin
			NextState <= 7;
			FinishTime <= 1;
			{Ra, Rb} <= 2'b11;
            {Ya, Yb, Ga, Gb, Gw, Rw} = 6'b000000;
		end

	7:
		begin
			NextState <= 8;
			FinishTime <= 1;
            {Ra, Rb, Rw} <= 3'b111;
            {Ga, Ya, Yb, Gb, Gw} <= 5'b00000;
		end

	8:
		begin
			NextState <= 9;
			FinishTime <= 1;
			{Ra, Rb} <= 2'b11;
            {Ya, Yb, Ga, Gb, Gw, Rw} = 6'b000000;
		end
	9:
        begin
            NextState <= 10;
            FinishTime <= 1;
            {Ra, Rb, Rw} <= 3'b111;
            {Ga, Ya, Yb, Gb, Gw} <= 5'b00000;
        end
    
    10: 
        begin
            NextState <= 11;
            FinishTime <= 1;
            {Ra, Rb} <= 2'b11;
            {Ya, Yb, Ga, Gb, Gw, Rw} = 6'b000000;
        end
    
    11:
        begin
            NextState <= 12;
            FinishTime <= 1;
            {Ra, Rb, Rw} <= 3'b111;
            {Ga, Ya, Yb, Gb, Gw} <= 5'b00000;
        end
    
    12:
        begin
            NextState <= 0;
            FinishTime <= 1;
            {Ra, Rb} <= 2'b11;
            {Ya, Yb, Ga, Gb, Gw, Rw} = 6'b000000;
        end
        
	13:
		begin
			NextState <= 14;
			FinishTime <= 2;
			{Ra, Ya, Ga, Rb, Yb, Gb, Rw, Gw} <= 8'b00000000;
		end

	14:
		begin
			NextState <= 13;
			FinishTime <= 2;
			{Ra, Rb, Rw} <= 3'b111;
			{Ya, Ga, Yb, Gb, Gw} <= 5'b00000;
		end
	default: 
		begin
		    NextState<=0;
		    FinishTime <= 0;
			{Ra, Ya, Ga, Rb, Yb, Gb, Rw, Gw} <= 8'b00000000;
		end
	endcase
end

endmodule
