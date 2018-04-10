'define S_Key 8'h1B						
'define P_Key 8'h4D
'define R_Key 8'h2D
'define ESC_Key 8'h76
'define UP_Key 8'h75
'define DOWN_Key 8'h72
'define LEFT_Key 8'h6B
'define RIGHT_Key 8'h74

'define Paused 0
'define Play 1
'define GameOver 2
'define BlackOut 3

'define North 0
'define East 1
'define South 2
'define West 3

module Master_Controller(clk100MHz, clk50Hz, newKeyStrobe, keycode);
input clk100MHz, clk50Hz, newKeyStrobe, keycode;

reg [1:0] Counter;
reg [1:0] State;			// 0 is paused, 1 is playing, 2 is game over, 3 is blacked out
reg [1:0] snakeDir;
reg snakeDead;				// necessary to allow for change to GameOver from other always block
reg [10:0] headX, headY;		// always top left corner of head

initial
begin
	DispCounter = 3;			// allows increment at start
	headX = 310;
	headY = 230;
end

always @(posedge clk100Mhz)
begin
	Counter = Counter + 1;
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
		else if (keycode == S_Key)
		begin
			headX = 310;
			headY = 230;
		end
		else if (keycode == P_Key) State = Paused;
		else if (keycode == ESC_Key) State = BlackOut;
	end

	if (DispCounter == 0)												// *** NEED TO ADD DISPLAY ***
	begin														// *** NEED TO KEEP TRACK OF SNAKE BODY PARTS FOR SMOOTH MOVEMENT ***
		
	end
end

always @(posedge clk50Hz)								// for controlling snake movement
begin
	if (State === Play)
	begin
		if (snakeDir == North)					// North
		begin
			if (keycode == RIGHT_Key)
			begin
				snakeDir = East;
				if (headX == 629) snakeDead = 1;
			end
			else if (keycode == LEFT_Key)
			begin
				snakeDir = West;
				if (headX == 0) snakeDead = 1;
			end
			else if (headY == 0) snakeDead = 1;
			if (snakeDead == 0) headY = headY - 1;
		end
		else if (snakeDir == East)				// East
		begin
			if (keycode == UP_Key)
			begin
				snakeDir = North;
				if (headY == 0) snakeDead = 1;
			end
			else if (keycode == DOWN_Key)
			begin
				snakeDir = South;
				if (headY == 469) snakeDead = 1;
			end
			else if (headX == 629) snakeDead = 1;
			if (snakeDead = 0) headX = headX + 1;
		end
		else if (snakeDir == South)				// South
		begin
			if (keycode == RIGHT_Key)
			begin
				snakeDir = East;
				if (headX == 629) snakeDead = 1;
			end
			else if (keycode == LEFT_Key)
			begin
				snakeDir = West;
				if (headX == 0) snakeDead = 1;
			end
			else if (headY == 469) snakeDead = 1;
			if (snakeDead == 0) headY = headY + 1;
		end
		else if (snakeDir == West)				// West
		begin
			if (keycode == UP_Key)
			begin
				snakeDir = North;
				if (headY == 0) snakeDead = 1;
			end
			else if (keycode == DOWN_Key)
			begin
				snakeDir = South;
				if (headY == 469) snakeDead = 1;
			end
			else if (headX == 0) snakeDead = 1;
			if (snakeDead = 0) headX = headX - 1;
		end
	end
end
endmodule
