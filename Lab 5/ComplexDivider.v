module complexDivider(clk100Mhz, slowClk, slowPeriod);

input clk100Mhz; //fast clock
input [31:0] slowPeriod; 
output reg slowClk; //slow clock

reg[27:0] counter;

initial begin
  counter = 0;
  slowClk = 0;
end

always @ (posedge clk100Mhz)
begin
  if(counter == slowPeriod) begin
    counter <= 1;
    slowClk <= ~slowClk;
  end
  else begin
    counter <= counter + 1;
  end
end

endmodule
