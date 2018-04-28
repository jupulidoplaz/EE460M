module Complete_MIPS(CLK, RST, HALT, /*A_Out, D_Out,*/ led);
  // Will need to be modified to add functionality
  input CLK, RST, HALT;
//  output [6:0] A_Out;
//  output [31:0] D_Out;  
  output wire [7:0] led;

  wire CS, WE, clk8Hz;
  wire [6:0] ADDR;
  wire [31:0] Mem_Bus;
 // assign A_Out = ADDR;
 // assign D_Out = Mem_Bus;    
	
	///assign led = HALT ? SOMETHING  : 0;
  complexDivider C1 (CLK, clk8Hz, 6250000);
	//MIPS CPU(clk8Hz, RST, HALT, CS, WE, ADDR, Mem_Bus, led);
  MIPS CPU(clk8Hz, RST, HALT, CS, WE, ADDR, Mem_Bus, led);
  Memory MEM(CS, WE, CLK, ADDR, Mem_Bus);

endmodule
