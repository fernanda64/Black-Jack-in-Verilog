module game(

	input RST_N,
	input CLK,
	input HIT_I,
	input STAY_I,
	input[3:0] CARD_I,
	
	output WIN_O,
	output TIE_O,
	output LOSE_O
	
    );
	 
//Flip-flops

reg WIN_FF, TIE_FF,LOSE_FF, WIN_S,TIE_S, LOSE_S;

localparam state_width_p = 2;

reg [state_width_p-1:0] state_ff;    // FSM state register
reg [state_width_p-1:0] next_state_s;

reg [4:0] result_s_player;
reg [4:0] result_ff_player;
reg [4:0] result_s_dealer;
reg [4:0] result_ff_dealer;

//-------States----------------------	 
localparam  state_init = 0;
localparam  state_player = 1;
localparam  state_player_dealer = 2;
localparam  state_result = 3;
//---------------------------------

assign WIN_O = WIN_FF;
assign TIE_O =	TIE_FF;
assign LOSE_O = LOSE_FF;


always @(*)
begin

	next_state_s = state_ff;
	result_s_player = result_ff_player;
	result_s_dealer = result_ff_dealer;
	WIN_S = WIN_FF;
	TIE_S = TIE_FF;
	LOSE_S = LOSE_FF;

	case(state_ff)
		state_init:
			begin
				next_state_s = state_player;
			end
		state_player:
			begin
				if(HIT_I == 1)
					begin
						if(CARD_I > 9)
							result_s_player = result_ff_player +10;
						else 
							result_s_player = result_ff_player +CARD_I;
					end
				if(STAY_I == 1)
					begin
						next_state_s = state_player_dealer;
					end
			end
		state_player_dealer:
			begin
				if(HIT_I == 1)
					begin
						if(CARD_I > 9)
							result_s_dealer = result_ff_dealer +10;
						else 
							result_s_dealer = result_ff_dealer +CARD_I;
					end
				if(STAY_I == 1)
					begin
						next_state_s = state_result;
					end
			end
		state_result:
			begin
				if((result_ff_dealer > 21) && (result_ff_player > 21))
					TIE_S = 1;
				else if(result_ff_player > 21)
					LOSE_S = 1;
				else if(result_ff_dealer > 21)
					WIN_S = 1;
				else if (result_ff_dealer > result_ff_player)
					LOSE_S = 1;
				else if (result_ff_dealer < result_ff_player)
					WIN_S = 1;
				else if (result_ff_dealer == result_ff_player)
					TIE_S = 1;
			end
	endcase
end
	 
always @(posedge CLK, negedge RST_N)
begin
        if (!RST_N)
			  begin
						 WIN_FF <= 0;
						 TIE_FF <= 0;
						 LOSE_FF <= 0;
						 result_ff_player <= 0;
						 result_ff_dealer <= 0;
						 state_ff <= state_init;
			  end
        else
			  begin
						 WIN_FF <= WIN_S;
						 TIE_FF <= TIE_S;
						 LOSE_FF <= LOSE_S;				 
						 state_ff <= next_state_s;
						result_ff_player <= result_s_player;
						 result_ff_dealer <= result_s_dealer;
				end
end

endmodule
