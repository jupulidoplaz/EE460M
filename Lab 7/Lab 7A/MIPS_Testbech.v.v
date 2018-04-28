// You can use this skeleton testbench code, the textbook testbench code, or your own
	module MIPS_Testbench ();
  reg CLK, RST, init, WE_TB, CS_TB, HALT;
  wire CS, WE;
	wire [7:0] led;
	
  wire [31:0] Mem_Bus;
  wire [6:0] Address;
	wire WE_Mux, CS_Mux;
	parameter N = 10;
	reg[31:0] expected[N:1];
	
	//reg [7:0] led;
	
	
	integer i;
	
	MIPS CPU(CLK, RST, HALT, CS, WE, Address, Mem_Bus, led);
  Memory MEM(CS, WE, CLK, Address, Mem_Bus);

	assign WE_Mux = (init)? WE_TB : WE;
	assign CS_Mux = (init)? CS_TB : CS;
	
  initial
  begin
		expected[1] = 32'h00000006; // $1 content=6 decimal
		expected[2] = 32'h00000012; // $2 content=18 decimal
		expected[3] = 32'h00000018; // $3 content=24 decimal
		expected[4] = 32'h0000000C; // $4 content=12 decimal
		expected[5] = 32'h00000002; // $5 content=2
		expected[6] = 32'h00000016; // $6 content=22 decimal
		expected[7] = 32'h00000001; // $7 content=1
		expected[8] = 32'h00000120; // $8 content=288 decimal
		expected[9] = 32'h00000003; // $9 content=3
		expected[10] = 32'h00412022; // $10 content=5th instr
    CLK = 0;
  end


  always
  begin
    #5 CLK = !CLK;
//		#10 CLK = !CLK;
  end

  always
  begin
    RST <= 1'b1; //reset the processor

    //Notice that the memory is initialize in the in the memory module not here

    @(posedge CLK);
    // driving reset low here puts processor in normal operating mode
    RST = 1'b0;
		
		for(i = 1; i <= N; i = i+1)
		begin
			@(posedge WE);	//something about to be stored
			@(negedge CLK);
			if (Mem_Bus != expected[i])
				$display("Output mismatch: got %d, expected %d", Mem_Bus, expected[i]);
			else
				$display("Output: %d at Address: %d", Mem_Bus, Address);
		end

    /* add your testing code here */
    // you can add in a 'Halt' signal here as well to test Halt operation
    // you will be verifying your program operation using the
    // waveform viewer and/or self-checking operations

    $display("TEST COMPLETE");
    $stop;
  end

endmodule

