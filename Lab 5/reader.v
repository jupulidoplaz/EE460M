module reader(ps2CLK, ps2DATA, scanCode, idle, flash, register, LED2);
    
input ps2CLK, ps2DATA;
output reg idle, flash, LED2;
output reg[7:0] scanCode;
output[7:0] register;
reg[7:0] pastCode;
reg [21:0] shiftReg;	

    
    
initial 
begin
idle = 1;
flash = 0;
pastCode = 0;
LED2 = 0;
end

assign register = shiftReg[8:1];

always @(negedge ps2CLK)
begin
    shiftReg = {ps2DATA, shiftReg[21:1]};	//right shifts data every negative edge of ps2 clock
    if (shiftReg[8:1] == 8'hF0)
    begin
        scanCode = shiftReg[19:12];
        idle <= 0;
        flash <= 1;
        shiftReg[8:1] = 8'b00000000;
       // shiftReg = 0;
    end
    else
    begin
        flash <= 0;
        scanCode <= 0;
        idle <= 1;
        shiftReg <= shiftReg;
    end
end
	
	
endmodule
