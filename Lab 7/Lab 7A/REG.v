module REG(CLK, RegW, DR, SR1, SR2, Reg_In, ReadReg1, ReadReg2, reg1LED);
  input CLK;
  input RegW;
  input [4:0] DR;
  input [4:0] SR1;
  input [4:0] SR2;
  input [31:0] Reg_In;
	output wire [7:0] reg1LED;
  output reg [31:0] ReadReg1;
  output reg [31:0] ReadReg2;

  reg [31:0] REG [0:31];
  integer i;

  initial begin
    ReadReg1 = 0;
    ReadReg2 = 0;
  end

	assign reg1LED = REG[1][7:0];
	
  always @(posedge CLK)
  begin

    if(RegW == 1'b1)
      REG[DR] <= Reg_In[31:0];

    ReadReg1 <= REG[SR1];
    ReadReg2 <= REG[SR2];
  end
endmodule
