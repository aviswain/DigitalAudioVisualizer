module graphics(
	input vga_clk,
	input [9:0] hc,
	input [9:0] vc,
	input [255:0] sound_signal,
	input [3:0] switches,
	input [15:0] current_sound, //new
	output logic [9:0] pixel_address,
	output logic [2:0] red,
	output logic [2:0] green,
	output logic [1:0] blue
);

logic [4:0] xpos; 
logic [4:0] ypos; 
logic [7:0] color;  

assign xpos = hc/40; // 16 bins 
assign ypos = vc/15; // 32 height


logic [7:0] scaled_sound_signal [0:15];

logic [7:0] assign_color; 

localparam BLK = 8'h00;
localparam WHT = 8'hff;
localparam RED = 8'he0;
localparam BLU = 8'h03;
localparam THRESHOLD = 16'h0900;

assign assign_color = (current_sound > THRESHOLD) ? RED : WHT; 


genvar bin_num;
generate 
	for (bin_num = 0; bin_num < 16; bin_num = bin_num + 1) begin : gen_sound_thresholds
		assign scaled_sound_signal[bin_num] = sound_signal[(bin_num * 16) + 15:(bin_num * 16)] >> switches;
	end
endgenerate

always_comb begin
	
	if (xpos < 1)   begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 2) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 3) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 4) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 5) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 6) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 7) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 8) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 9) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 10) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 11) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 12) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 13) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 14) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 15) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else if (xpos < 16) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = assign_color;
		end else begin
			color = BLK;
		end
	end else begin
		color = assign_color;
	end

	
end

always @(posedge vga_clk) begin
	if (hc == 0 && vc == 0) begin
		
	end
end

assign pixel_address = (hc<640 && vc <480) ? (ypos*16+xpos):10'b0;

assign red = color[7:5];
assign green = color[4:2];
assign blue = color[1:0];

endmodule

/*
module graphics(
	input vga_clk,
	input [9:0] hc,
	input [9:0] vc,
	input [255:0] sound_signal, // CHANGE
	output logic [9:0] pixel_address,
	output logic [2:0] red,
	output logic [2:0] green,
	output logic [1:0] blue
);

logic [4:0] xpos; 
logic [4:0] ypos; 
logic [7:0] color;  

assign xpos = hc/40; // 16 bins 
assign ypos = vc/15; // 32 height


logic [7:0] scaled_sound_signal [0:15];

localparam BLK = 8'h00;
localparam WHT = 8'hff;
localparam RED = 8'he0;
localparam BLU = 8'h03;

genvar bin_num;
generate 
	for (bin_num = 0; bin_num < 16; bin_num = bin_num + 1) begin : gen_sound_thresholds
		assign scaled_sound_signal[bin_num] = sound_signal[(bin_num * 16) + 15:(bin_num * 16)] >> 8; // CHANGE
	end
endgenerate

always_comb begin
	
	if (xpos < 1)   begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 2) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 3) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 4) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 5) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 6) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 7) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 8) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 9) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 10) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 11) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 12) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 13) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 14) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 15) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else if (xpos < 16) begin
		if (scaled_sound_signal[xpos] < ypos) begin
			color = WHT;
		end else begin
			color = BLK;
		end
	end else begin
		color = 8'h00;
	end

	
end

assign pixel_address = (hc<640 && vc <480) ? (ypos*16+xpos):10'b0;

assign red = color[7:5];
assign green = color[4:2];
assign blue = color[1:0];

endmodule 
*/