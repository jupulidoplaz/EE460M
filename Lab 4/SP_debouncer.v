module SP_debouncer(button, pressed, CLK); //waits until button is released to return a 1 when button is pressed
input button, CLK;
output pressed;

reg Qa, Qb, Qc;

assign pressed = Qb & ~Qc;

always @(posedge CLK)
begin
Qa <= button;
Qb <= Qa;
Qc <= Qb;
end

endmodule
