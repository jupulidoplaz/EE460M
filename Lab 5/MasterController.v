module Master_Controller(clk100MHz, clk50Hz, clk25MHz, keycode, SnakeOut, Black, playLED);
input clk100MHz, clk50Hz, clk25MHz, keycode;
output SnakeOut, Black, playLED;

parameter [7:0] S_Key = 8'h1B;
parameter [7:0] P_Key = 8'h4D;
parameter [7:0] R_Key = 8'h2D;
parameter [7:0] ESC_Key = 8'h76;
parameter [7:0] UP_Key = 8'h75;
parameter [7:0] DOWN_Key = 8'h72;
parameter [7:0] LEFT_Key = 8'h6B;
parameter [7:0] RIGHT_Key = 8'h74;

parameter [1:0] Paused = 0;
parameter [1:0] Play = 1;
parameter [1:0] GameOver = 2;
parameter [1:0] BlackOut = 3;

parameter [1:0] North = 0;
parameter [1:0] East = 1;
parameter [1:0] South = 2;
parameter [1:0] West = 3;

reg [1:0] State;			// 0 is paused, 1 is playing, 2 is game over, 3 is blacked out
reg [1:0] snakeDir;
reg snakeDead;				// necessary to allow for change to GameOver from other always block
reg [10:0] headX, headY;		// always top left corner of head
reg [10:0] hcount, vcount;
reg Snake;
wire SnakeOut;
wire [7:0] keycode;
wire Black;
reg revive;
wire playLED;

initial
begin
	headX = 310;
	headY = 230;
	State = BlackOut;
	Snake = 0;
	snakeDir = East;
	hcount = 0;
	vcount = 0;
	snakeDead = 0;
	revive = 0;
end

always @(posedge clk100MHz)
begin
	if (State == Paused)								// Paused
	begin
		if (keycode == R_Key) State = Play;
		else if (keycode == S_Key) State = Play;
		else if (keycode == ESC_Key) State = BlackOut;
	end
	else if ((State == BlackOut) && (keycode == S_Key)) State = Play;		// BlackOut
	else if (State == GameOver)							// GameOver
	begin
		if (keycode == S_Key) State = Play;
		else if (keycode == ESC_Key) State = BlackOut;
	end
	else if (State == Play)								// Play
	begin
		if (snakeDead == 1) State = GameOver;
		else if (keycode == P_Key) State = Paused;
		else if (keycode == ESC_Key) State = BlackOut;
	end
end
	
always @(posedge clk25MHz)											// *** NEED TO ADD DISPLAY ***
begin												// *** NEED TO KEEP TRACK OF SNAKE BODY PARTS FOR SMOOTH MOVEMENT ***
    if ((snakeDir == North) && ((headX <= hcount) && ((headX + 9) >= hcount)) && ((headY <= vcount) && ((headY + 39) >= vcount)))
	    Snake <= 1;
    else if ((snakeDir == East) && ((headX >= hcount) && (headX <= (hcount + 39))) && ((headY <= vcount) && ((headY + 9) >= vcount)))
	   	Snake <= 1;
	else if ((snakeDir == South) && ((headX >= hcount) && (headX <= (hcount + 9))) && ((headY >= vcount) && (headY <= (vcount + 39))))
		Snake <= 1;
	else if ((snakeDir == West) && ((headX <= hcount) && ((headX + 39) >= hcount)) && ((headY >= vcount) && (headY <= (vcount + 9))))
		Snake <= 1;
	else
	    Snake <= 0;

    if (hcount < 799)
    begin
        hcount <= hcount + 1;
        vcount <= vcount;
    end
    else if (hcount >= 799)
    begin
        if (vcount >= 524)
        begin
            hcount <= 0;
            vcount <= 0;
        end
        else
        begin
            hcount <= 0;
            vcount <= vcount + 1;
        end
    end
    
end

always @(posedge clk50Hz)								// for controlling snake movement
begin
    if ((State == BlackOut) || (State == GameOver)) revive = 1;
	if (State == Play)
	begin
	    if (revive == 1)
	    begin
	       headX = 320;
           headY = 240;
           snakeDir = East;
           revive = 0;
        end
	    snakeDead = 0;
		if (snakeDir == North)					// North
		begin
			if (keycode == RIGHT_Key)
			begin
				if (headX == 630) snakeDead = 1;
				snakeDir = East;
				headX = headX + 10;
			end
			else if (keycode == LEFT_Key)
			begin
				if (headX == 0) snakeDead = 1;
				snakeDir = West;
				headY = headY + 10;
			end
			else if (headY == 30) snakeDead = 1;
			if (snakeDead == 0) headY = headY - 1;
		end
		else if (snakeDir == East)				// East
		begin
			if (keycode == UP_Key)
			begin
				if (headY == 0) snakeDead = 1;
				snakeDir = North;
				headX = headX - 10;
			end
			else if (keycode == DOWN_Key)
			begin
				if (headY == 470) snakeDead = 1;
				snakeDir = South;
				headY = headY + 10;
			end
			else if (headX == 640) snakeDead = 1;
			if (snakeDead == 0) headX = headX + 1;
		end
		else if (snakeDir == South)				// South
		begin
			if (keycode == RIGHT_Key)
			begin
				if (headX == 640) snakeDead = 1;
				snakeDir = East;
				headY = headY - 10;
			end
			else if (keycode == LEFT_Key)
			begin
				if (headX == 10) snakeDead = 1;
				snakeDir = West;
				headX = headX - 10;
			end
			else if (headY == 510) snakeDead = 1;
			if (snakeDead == 0) headY = headY + 1;
		end
		else if (snakeDir == West)				// West
		begin
			if (keycode == UP_Key)
			begin
				if (headY == 10) snakeDead = 1;
				snakeDir = North;
				headY = headY - 10;
			end
			else if (keycode == DOWN_Key)
			begin
				if (headY == 480) snakeDead = 1;
				snakeDir = South;
				headX = headX + 10;
			end
			else if (headX == 0) snakeDead = 1;
			if (snakeDead == 0) headX = headX - 1;
		end
	end
end

assign SnakeOut = Snake;
assign Black = (State == BlackOut) ? 1 : 0;
assign playLED = (State == Play) ? 1 : 0;
endmodule
