module SP_deboncer(button, pressed, CLK) //waits until button is released to return a 1 when button is pressed
input button, CLK;
output pressed;

reg Qa, Qb, Qc, pressed;

pressed = Qb & ~Qc;

always @(posedge CLK)
begin
Qa <= button;
Qb <= Qa;
Qc <= Qb;
end

emdmodule
