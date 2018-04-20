module pulseGen(CLK, START, MODE, PULSE);
input CLK, START;
input [1:0] MODE;
output PULSE;
reg [27:0] slowEdge;
reg [8:0] secCounter;
reg [1:0] enable;
reg done;
wire slowClk, secClk, CLK, START, LED1, LED2;

initial
begin
    secCounter = 0;
    done = 0;
end



assign PULSE = (enable[0] == 1) ? slowClk : 0;
    
complexDivider C1   (CLK, slowClk, slowEdge, enable[0]);
complexDivider C2   (CLK, secClk, 50000000, enable[1]);


always @(posedge CLK)
begin
    if(!START) begin
        enable <= 0;
        done <= 0;
    end
    else begin
        case(MODE)
            0:  begin                       //walk
                    slowEdge <= 1562500;
                    enable <= 2'b01;
                    done <= 0;
                end
            1:  begin                       //jog
                    slowEdge <= 781250;
                    enable <= 2'b01;
                    done <= 0;
                end 
            2:  begin                       //run
                    slowEdge <= 390625;
                    enable <= 2'b01;
                    done <= 0;
                end
            3:  begin                       //hybrid
                    if((secCounter < 144) && (done == 0)) 
                    begin
                        enable <= 2'b11;
                        case(secCounter)
                        0:  slowEdge <= 2500000;
                        1:  slowEdge <= 1515151;
                        2:  slowEdge <= 757575;
                        3:  slowEdge <= 1851851;
                        4:  slowEdge <= 714285;
                        5:  slowEdge <= 1666666;
                        6:  slowEdge <= 2631579;
                        7:  slowEdge <= 1666666;
                        8:  slowEdge <= 1515151;
                        9:  slowEdge <= 724638;
                        73: slowEdge <= 1470588;
                        78: slowEdge <= 403226;
                        default: slowEdge <= slowEdge;
                        endcase
                    end
                        
                    else begin
                        done <= 1;
                        enable <= 2'b10;
                        slowEdge <= 111111111;
                    end
    
                end
       endcase
            
    end   
end

always @(posedge secClk)
begin
    if(!done) 
        secCounter <= secCounter + 1; //as long as secClk is enabled, increment
    else 
        secCounter <= 0;
end

endmodule
