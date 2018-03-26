
module game_tb;

	// Inputs
	reg RST_N;
	reg CLK;
	reg HIT_I;
	reg STAY_I;
	reg [3:0] CARD_I;

	// Outputs
	wire WIN_O;
	wire TIE_O;
	wire LOSE_O;

	// Instantiate the Unit Under Test (UUT)
	game uut (
		.RST_N(RST_N), 
		.CLK(CLK), 
		.HIT_I(HIT_I), 
		.STAY_I(STAY_I), 
		.CARD_I(CARD_I), 
		.WIN_O(WIN_O), 
		.TIE_O(TIE_O), 
		.LOSE_O(LOSE_O)
	);


always
begin
        #25 CLK = !CLK;
end

initial 
begin
		  RST_N = 0;
		  CLK = 0;
		  HIT_I = 0;
		  STAY_I = 0;
		  CARD_I = 0;

        repeat (1)  @(negedge CLK);
			RST_N = 1'b1;
			
		  repeat (1)  @(negedge CLK);
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 1; 
		  
		  
    
        repeat (1)  @(negedge CLK);
		  
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 2;
		  
		  STAY_I = 1;
	

		  repeat (1)  @(negedge CLK);
		  
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 10;
		  
		  repeat (1)  @(negedge CLK);
		  
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 10;
		  
		  STAY_I = 1;  //resltado lose
		  
		  repeat (5)  @(negedge CLK);
		  
		  //-----------partida 2
		  
		  repeat (1)  @(negedge CLK);
		  RST_N = 0;
		  HIT_I = 0;
		  STAY_I = 0;
		  CARD_I = 0;

        repeat (1)  @(negedge CLK);
			RST_N = 1'b1;
			
		  repeat (1)  @(negedge CLK);
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 1; 
		  
		  
    
        repeat (1)  @(negedge CLK);
		  
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 2;
		  
		  STAY_I = 1;
	

		  repeat (1)  @(negedge CLK);
		  
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 2;
		  
		  repeat (1)  @(negedge CLK);
		  
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 1;
		  
		  STAY_I = 1;  //resltado tie
		  
		  repeat (5)  @(negedge CLK);
		  
		  //---------------------partida 3--------------------------
		  repeat (1)  @(negedge CLK);
		  RST_N = 0;
		  HIT_I = 0;
		  STAY_I = 0;
		  CARD_I = 0;

        repeat (1)  @(negedge CLK);
			RST_N = 1'b1;
			
		  repeat (1)  @(negedge CLK);
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 9; 
		  
		  
    
        repeat (1)  @(negedge CLK);
		  
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 2;
		  
		  STAY_I = 1;
	

		  repeat (1)  @(negedge CLK);
		  
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 2;
		  
		  repeat (1)  @(negedge CLK);
		  
		  HIT_I = 1;
		  STAY_I = 0;
		  CARD_I = 3;
		  
		  STAY_I = 1;  //resltado win
		  
		

		  
		repeat (500)  @(negedge CLK);
		$finish (2) ;

	end
      
endmodule

