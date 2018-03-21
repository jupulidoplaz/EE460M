module Sort(CLK,Weight,Reset,Grp1,Grp2,Grp3,Grp4,Grp5,Grp6,currentGrp);
input CLK,Weight,Reset;
output Grp1,Grp2,Grp3,Grp4,Grp5,Grp6,currentGrp;

wire [11:0] Weight;
reg [7:0] Grp1,Grp2,Grp3,Grp4,Grp5,Grp6;
reg [2:0] currentGrp;
reg WtRdy;

initial
begin
	Grp1 = 0;
	Grp2 = 0;
	Grp3 = 0;
	Grp4 = 0;
	Grp5 = 0;
	Grp6 = 0;
	WtRdy = 1;
end

always @(negedge CLK,posedge Reset)
begin
	if (Reset == 1)
	begin
		Grp1 <= 0;
		Grp2 <= 0;
		Grp3 <= 0;
		Grp4 <= 0;
		Grp5 <= 0;
		Grp6 <= 0;
		WtRdy <= 1;
	end
	else
	begin
		if (Weight == 0) WtRdy = 1;
		else if (WtRdy == 1)
		begin
			WtRdy = 0;
			case(currentGrp)
			1:	Grp1 = Grp1 + 1;
			2:	Grp2 = Grp2 + 1;
			3:	Grp3 = Grp3 + 1;
			4:	Grp4 = Grp4 + 1;
			5: 	Grp5 = Grp5 + 1;
			6:	Grp6 = Grp6 + 1;
			default: WtRdy = 0;
			endcase
		end
	end
end

always @(*)
begin
	if ((Weight > 0) && (Weight < 251)) currentGrp = 1;
	else if ((Weight > 250) && (Weight < 501)) currentGrp =  2;
	else if ((Weight > 500) && (Weight < 751)) currentGrp = 3;
	else if ((Weight > 750) && (Weight < 1501)) currentGrp = 4;
	else if ((Weight > 1500) && (Weight < 2001)) currentGrp = 5;
	else if (Weight > 2000) currentGrp = 6;
	else currentGrp = 0;
end

endmodule
