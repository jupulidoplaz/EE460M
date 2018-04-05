`define digit0 num[3:0]
`define digit1 num[7:4]
`define digitTime 200000 //should b 200000 for board testing

module sevenSeg(CLK, num, an, seg, idle);
input [7:0]num;
input CLK, idle;
output reg [3:0] an;
output reg[6:0] seg;

reg [1:0]state, nextState;
reg [17:0]counter;
reg [3:0] display;

initial
begin
state = 0;
counter = 0;
{an, seg} = 11'b11111111111;
end

always @(posedge CLK)
begin
    if (idle)
    begin
        state <= 3;
        counter <= 0;
    end
    else
    begin
        if (counter == `digitTime)
        begin
            counter <= 0;
            state <= nextState;
        end
        else
        begin
            counter <= counter + 1;
            state <= state;
        end
    end
end

always @(state)
begin
    case(state)
        0:	begin
                an <= 4'b1110;
                nextState <= 1;
                display <= `digit0;
            end
        1:	begin
                an <= 4'b1101;
                nextState <= 0;
                display <= `digit1;
            end
        default:    begin
                        an <= 4'b1111;
                        nextState <= nextState;
                        display <= display;
                    end
    endcase
    case(display)
        0:	seg <= 7'b1000000;
        1:	seg <= 7'b1111001;
        2:	seg <= 7'b0100100;
        3:	seg <= 7'b0110000;
        4:	seg <= 7'b0011001;
        5:	seg <= 7'b0010010;
        6:	seg <= 7'b0000010;
        7:	seg <= 7'b0111000;
        8:	seg <= 7'b0000000;
        9:	seg <= 7'b0010000;
        10: seg <= 7'b0001000;
        11: seg <= 7'b0000000;
        12: seg <= 7'b1000110;
        13: seg <= 7'b1000000;
        14: seg <= 7'b0000110;
        default: seg <= 7'b1010101;
    endcase
end

endmodule
