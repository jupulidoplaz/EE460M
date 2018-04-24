module tracker(clk, reset, pulse, display, SI, led, secClk);
input wire clk, reset, pulse;
output wire SI, secClk;
output reg [15:0] display;
reg [2:0] state, nextState;
reg stateCount, stateFlag;
wire [6:0] whole;
wire [2:0] frac;
wire [13:0] stepCount;
wire [3:0] secs1;
wire [8:0] secs2;
wire [15:0] outNum1, outNum2, tempBCD1, tempBCD2;
reg [15:0] num1, num2;
reg [3:0] tempNum1;
reg [7:0] tempNum2;

output reg [4:1] led;

assign outNum1 = num1;
assign outNum2 = num2;

complexDivider C3(clk, secClk, 50000000, 1); 
    
stepCount S1 (clk, pulse, stepCount, SI, reset);
    
distanceCount D1 (clk, pulse, whole, frac, reset);
    
step32 S2 (clk, pulse, secClk, secs1, reset); //pulse is the pulse signal
    
highActivity H1(clk, pulse, secClk, secs2, reset);

binary2BCD B1(outNum1, tempBCD1);
binary2BCD B2(outNum2, tempBCD2);
    
initial
begin
    state = 0;
    stateFlag = 0;
    led = 4'b00000;
end

always@(posedge clk)
begin
    case(state)
        0:  begin               //total step count
                led[4:1] <= 4'b0001;
                num1 = stepCount;
                display = tempBCD1;
                nextState <= 0;
            end 
        1:  begin               //distance covered
                led[4:1] <= 4'b0010;
                num1 <= frac;
                num2 <= whole;
                tempNum1 <= tempBCD1[3:0];
                tempNum2 <= tempBCD2[7:0];
                display = {tempNum2,4'b1111, tempNum1};
                nextState <= 2;
            end
        2:  begin               //seconds at which more than 32steps/sec occured
                led[4:1] <= 4'b0100;
                num1 = secs1;
                display = tempBCD1;
                nextState <= 3;
            end
        3:  begin    
                led[4:1] <= 4'b1000;
                num1 = secs2;
                display = tempBCD1;
                nextState <= 0;
            end
        default:    begin
                led <= led;
                num1 <= num1;
                num2 <= num2;
                display <= display;
                nextState <= nextState;
            end
    endcase
    //pastState <= state;
end
  
    
always @(posedge secClk)
begin
   // led[5] <= ~led[5];
    if (!stateFlag) begin
        state <= state;
        stateFlag <= 1;
    end
    else    begin
        state <= nextState;
        stateFlag <=0;
    end
end

    
endmodule
