module pulseGen(clk, start, mode, pulse, reset);   
input clk, start, reset;
input [1:0] mode;
output pulse;
reg [27:0] slowEdge;
reg [8:0] secCounter;
reg [1:0] enable;
reg done;
wire slowClk, secClk, clk, start;

initial
begin
    secCounter = 0;
    done = 0;
  //  lock = 0;
end



assign pulse = (enable[0] == 1) ? slowClk : 0;
    
complexDivider C1   (clk, slowClk, slowEdge, enable[0]);
complexDivider C2   (clk, secClk, 50000000, enable[1]);


always @(posedge clk)
begin
    if(!start || reset) begin
        enable <= 0;
        done <= 0;
    end
    else begin
        case(mode)
            0:  begin                       //walk
                    slowEdge <= 1520000;
                    enable <= 2'b01;
                    done <= 0;
                end
            1:  begin                       //jog
                    slowEdge <= 775193;
                    enable <= 2'b01;
                    done <= 0;
                end 
            2:  begin                       //run
                    slowEdge <= 389205;
                    enable <= 2'b01;
                    done <= 0;
                end
            3:  begin                       //hybrid
                    if((secCounter < 144) && (done == 0)) 
                    begin
                        enable <= 2'b11;
                        case(secCounter)
                        0:  slowEdge = 2439024;
                        1:  slowEdge = 1492537;
                        2:  slowEdge = 751879;
                        3:  slowEdge = 1818181;
                        4:  slowEdge = 709219;
                        5:  slowEdge = 1639344;
                        6:  slowEdge = 2564102;
                        7:  slowEdge = 1639344;
                        8:  slowEdge = 1492537;
                        9:  slowEdge = 719424;
                        73: slowEdge = 1449275;
                        78: slowEdge = 401606;
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

always @(posedge secClk or posedge reset)
begin
    if (reset)
        secCounter = 0;
    else begin
        if(!done) 
            secCounter <= secCounter + 1; //as long as secClk is enabled, increment
        else 
            secCounter <= 0;
    end
end

endmodule
