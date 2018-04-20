module tracker(CLK, START, RESET, STEP, display, SI);
input CLK, START, RESET, STEP;
output wire SI
output reg [6:0] display;
reg [2:0] state, nextState;
wire secClk
reg stateCount, stateFlag, clrCounter;
reg [6:0] counter;
reg [20:0] totalSteps;
reg [13:0] stepDisplay; //set to cover up to 16,303 steps (14 bits)
    
complexDivider C3 (CLK, secClk, 50000000, 1);
stepCount S1 (CLK, totalSteps, stepCount);

//assign SI = (stepDisplay == 9999) ? 1 : 0;
assign stepDisplay = (totalSteps >= 9999) ? 9999 : totalSteps;

module stepCount (CLK, totalSteps, stepCount);
    
initial
begin
    state = 0;
    stateFlag = 0;
    //clrCounter = 0;
    counter = 0;
    totalSteps = 0;
end

always@(posedge secCLK)
begin
    if (!stateFlag) begin
        state <= state;
        stateFlag <= 1;
    end
    else    begin
        state <= nextState;
        stateFlag <=0;
    end

    case(state)
        0:  begin               //total step count
                nextState <= 1;
            end 
        1:  begin               //distance covered
                nextState <= 2;
            end
        2:  begin               //seconds at which more than 32steps/sec occured
                nextState <= 3;
            end
        3:  begin               
                nextState <= 0;
            end
        default:    begin
                nextState <= nextState;
            end
    endcase
    pastState <= state;
end
  
always @(posedge STEP)
begin
//    if(totalSteps <= 9998)
//        totalSteps = totalSteps + 1;
//       // SI = 0;
//    else
//        totalSteps = 9999;
//       // SI = 1;
//    if (clrCounter) counter = 0;    //clears the counter if we go into a new display
//    else counter = counter + 1;
    totalSteps = totalSteps + 1;    //need to check the bits of totalSteps
end
    
endmodule
