module debouncer(CLK, BTN, dBTN);
input CLK, BTN;
output reg dBTN;

reg button_ff1, button_ff2;
reg [20:0] counter;

parameter threshold = 100000;

initial
begin
  counter = 0;
  button_ff1 = 0;
  button_ff2 = 0;
end

always @(posedge CLK)
begin
  button_ff1 <= BTN;
  button_ff2 <= button_ff1;
end

always @(posedge CLK)
begin
  if (button_ff2)
  begin
    if (~&counter) counter <= counter + 1;
  end
  else
  begin
    if (|counter) counter <= counter - 1;
  end
  if (counter > threshold) dBTN <= 1;
  else dBTN <= 0;
end

endmodule
