module TestBench;

parameter N = 8;
reg [11:0] Weight;
wire [7:0] Grp1,Grp2,Grp3,Grp4,Grp5,Grp6;
wire [2:0] currentGrp;
reg Reset,CLK;

reg [11:0] Weight_array [1:N];
reg [7:0] Grp1_array [1:N];
reg [7:0] Grp2_array [1:N];
reg [7:0] Grp3_array [1:N];
reg [7:0] Grp4_array [1:N];
reg [7:0] Grp5_array [1:N];
reg [7:0] Grp6_array [1:N];
reg [2:0] currentGrp_array [1:N];
reg Reset_array [1:N];

initial
begin
	Weight_array[1] = 12'b000000000000;
	Weight_array[2] = 12'b000100001110;
	Weight_array[3] = 12'b000000000000;
	Weight_array[4] = 12'b000100101100;
	Weight_array[5] = 12'b000000000000;
	Weight_array[6] = 12'b000111110101;
	Weight_array[7] = 12'b001111110101;
	Grp1_array[1] = 8'b00000000;
	Grp1_array[2] = 8'b00000000;
	Grp1_array[3] = 8'b00000000;
	Grp1_array[4] = 8'b00000000;
	Grp1_array[5] = 8'b00000000;
	Grp1_array[6] = 8'b00000000;
	Grp1_array[7] = 8'b00000000;
	Grp2_array[1] = 8'b00000000;
	Grp2_array[2] = 8'b00000001;
	Grp2_array[3] = 8'b00000001;
	Grp2_array[4] = 8'b00000010;
	Grp2_array[5] = 8'b00000010;
	Grp2_array[6] = 8'b00000010;
	Grp2_array[7] = 8'b00000010;
	Grp3_array[1] = 8'b00000000;
	Grp3_array[2] = 8'b00000000;
	Grp3_array[3] = 8'b00000000;
	Grp3_array[4] = 8'b00000000;
	Grp3_array[5] = 8'b00000000;
	Grp3_array[6] = 8'b00000001;
	Grp3_array[7] = 8'b00000001;
	Grp4_array[1] = 8'b00000000;
	Grp4_array[2] = 8'b00000000;
	Grp4_array[3] = 8'b00000000;
	Grp4_array[4] = 8'b00000000;
	Grp4_array[5] = 8'b00000000;
	Grp4_array[6] = 8'b00000000;
	Grp4_array[7] = 8'b00000000;
	Grp5_array[1] = 8'b00000000;
	Grp5_array[2] = 8'b00000000;
	Grp5_array[3] = 8'b00000000;
	Grp5_array[4] = 8'b00000000;
	Grp5_array[5] = 8'b00000000;
	Grp5_array[6] = 8'b00000000;
	Grp5_array[7] = 8'b00000000;
	Grp6_array[1] = 8'b00000000;
	Grp6_array[2] = 8'b00000000;
	Grp6_array[3] = 8'b00000000;
	Grp6_array[4] = 8'b00000000;
	Grp6_array[5] = 8'b00000000;
	Grp6_array[6] = 8'b00000000;
	Grp6_array[7] = 8'b00000000;
	currentGrp_array[1] = 3'b000;
	currentGrp_array[2] = 3'b010;
	currentGrp_array[3] = 3'b000;
	currentGrp_array[4] = 3'b010;
	currentGrp_array[5] = 3'b000;
	currentGrp_array[6] = 3'b011;
	currentGrp_array[7] = 3'b100;
	Reset_array[1] = 1;
	Reset_array[2] = 0;
	Reset_array[3] = 0;
	Reset_array[4] = 0;
	Reset_array[5] = 0;
	Reset_array[6] = 0;
	Reset_array[7] = 0;

	CLK = 0;
	forever
	begin
		#10 CLK = !CLK;
	end
end

integer i;

always
begin
	for (i = 1; i < N; i = i + 1)
	begin
		$display(i);
		Weight <= Weight_array[i];
		Reset <= Reset_array[i];
		@(posedge CLK)
		#1;
		if (!(Grp1 == Grp1_array[i] && Grp2 == Grp2_array[i] && Grp3 == Grp3_array[i] && Grp4 == Grp4_array[i] && Grp5 == Grp5_array[i] && Grp6 == Grp6_array[i] && currentGrp == currentGrp_array[i]))
		begin
			$write("ERROR: ");
			$display("Wrong Answer ");
		end
		else 
		begin
			$display("Correct!");
		end
	end
	$display("Test Finished");
end

Sort S1(CLK,Weight,Reset,Grp1,Grp2,Grp3,Grp4,Grp5,Grp6,currentGrp);

endmodule
