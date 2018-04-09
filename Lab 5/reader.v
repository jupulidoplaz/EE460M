module reader(ps2CLK, ps2DATA, scanCode, flash, idle);
    
input ps2CLK, ps2DATA;
output wire flash;
output reg idle;
output reg[7:0] scanCode;
reg [21:0] shiftReg;	

assign flash = (shiftReg[8:1] == 8'hF0) ? 0 : 1;

initial 
begin
    idle = 1;
    shiftReg = 0;
    scanCode = 0;
end


always @(negedge ps2CLK)
begin
    shiftReg = {ps2DATA, shiftReg[21:1]};
end

always @(shiftReg)
begin
    if (shiftReg[8:1] == 8'hF0)
    begin
        scanCode = shiftReg[19:12];
        idle = 0;
    end
    else
    begin
        scanCode = scanCode;
        idle = 1;
    end
end

	
endmodule
