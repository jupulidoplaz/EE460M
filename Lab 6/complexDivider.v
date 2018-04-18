module complexDivider(clk100Mhz, slowClk, slowEdge, enable);
  input clk100Mhz, enable; //fast clock
  output reg slowClk; //slow clock
  input [27:0] slowEdge; //2*slowEdge times slower thn 10 MHz
  reg[27:0] counter;

  initial begin
    counter = 0;
    slowClk = 0;
  end

  always @ (posedge clk100Mhz)
  begin
    if(enable)  begin
        if(counter >= slowEdge) begin
          counter <= 1;
          slowClk <= ~slowClk;
        end
        else begin
          counter <= counter + 1;
        end
    end
    else begin
        counter <= 0;
        slowClk <= 0;
    end
    
  end

endmodule
