module complexDivider(clk100Mhz, slowClk);
  input clk100Mhz; //fast clock
  output reg slowClk; //slow clock

  reg[27:0] counter;

  initial begin
    counter = 0;
    slowClk = 0;
  end

  always @ (posedge clk100Mhz)
  begin
    if(counter == 12500000) begin  //original clock period: 10ns, new clock period = 10ns*12500000 = .125 s
      counter <= 1;
      slowClk <= ~slowClk;
    end
    else begin
      counter <= counter + 1;
    end
  end

endmodule
