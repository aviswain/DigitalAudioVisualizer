module fft #(WIDTH=32)(
	input logic [WIDTH-1:0] td [0:15],
	input logic clk,
	input logic rst_btn,
	input logic start_stop_btn,
	output logic [WIDTH-1:0] fd [0:15],
	output logic done
);

	// STATE VARIABLES

	localparam RESET = 3'b000;
	localparam STAGE1 = 3'b001;
	localparam STAGE2 = 3'b010;
	localparam STAGE3 = 3'b011;
	localparam STAGE4 = 3'b100;
	localparam DONE = 3'b101;
	
	// TWIDDLE FACTORS (FOR 32 BIT LENGTH)
	localparam W_0_16 = {16'd32767, 16'd0}; 
	localparam W_1_16 = {16'd30273, -16'd12539};
	localparam W_2_16 = {16'd23170, -16'd32170};
	localparam W_3_16 = {16'd12539, -16'd30273};
	localparam W_4_16 = {16'd0, -16'd32768};
	localparam W_5_16 = {-16'd12539, -16'd30273};
	localparam W_6_16 = {-16'd23170, -16'd23170};
	localparam W_7_16 = {-16'd30273, -16'd12539}; 
	
	logic [2:0] current_state, next_state;
	
	// BUTTONS
	
	logic [1:0] rst_sr;
	//logic [1:0] start_stop_sr;
	
	logic reset;
	logic start_stop;
	
	assign reset = (rst_sr == 2'b10);
	//assign start_stop = (start_stop_sr == 2'b10);
	assign start_stop  = start_stop_btn;
	
	// INTERMEDIATE SIGNALS 
	logic [WIDTH-1:0] interm [0:15];
	
	logic [WIDTH-1:0] A1;
	logic [WIDTH-1:0] B1;
	logic [WIDTH-1:0] W1;
	
	logic [WIDTH-1:0] A2;
	logic [WIDTH-1:0] B2;
	logic [WIDTH-1:0] W2;
	
	logic [WIDTH-1:0] A3;
	logic [WIDTH-1:0] B3;
	logic [WIDTH-1:0] W3;
	
	logic [WIDTH-1:0] A4;
	logic [WIDTH-1:0] B4;
	logic [WIDTH-1:0] W4;
	
	logic [WIDTH-1:0] A5;
	logic [WIDTH-1:0] B5;
	logic [WIDTH-1:0] W5;
	
	logic [WIDTH-1:0] A6;
	logic [WIDTH-1:0] B6;
	logic [WIDTH-1:0] W6;
	
	logic [WIDTH-1:0] A7;
	logic [WIDTH-1:0] B7;
	logic [WIDTH-1:0] W7;
	
	logic [WIDTH-1:0] A8;
	logic [WIDTH-1:0] B8;
	logic [WIDTH-1:0] W8;
	
	
	// BUTTERFLY UNITS
	butterfly_unit #(.WIDTH(32)) butterfly1(
    .A(A1),
    .B(B1),
    .W(W1),
    
    .out0(interm[0]),
    .out1(interm[1])
	);
	
	butterfly_unit #(.WIDTH(32)) butterfly2(
    .A(A2),
    .B(B2),
    .W(W2),
    
    .out0(interm[2]),
    .out1(interm[3])
	);
	
	butterfly_unit #(.WIDTH(32)) butterfly3(
    .A(A3),
    .B(B3),
    .W(W3),
    
    .out0(interm[4]),
    .out1(interm[5])
	);
	
	butterfly_unit #(.WIDTH(32)) butterfly4(
    .A(A4),
    .B(B4),
    .W(W4),
    
    .out0(interm[6]),
    .out1(interm[7])
	);
	
	butterfly_unit #(.WIDTH(32)) butterfly5(
    .A(A5),
    .B(B5),
    .W(W5),
    
    .out0(interm[8]),
    .out1(interm[9])
	);
	
	butterfly_unit #(.WIDTH(32)) butterfly6(
    .A(A6),
    .B(B6),
    .W(W6),
    
    .out0(interm[10]),
    .out1(interm[11])
	);
	
	butterfly_unit #(.WIDTH(32)) butterfly7(
    .A(A7),
    .B(B7),
    .W(W7),
    
    .out0(interm[12]),
    .out1(interm[13])
	);
	
	butterfly_unit #(.WIDTH(32)) butterfly8(
    .A(A8),
    .B(B8),
    .W(W8),
    
    .out0(interm[14]),
    .out1(interm[15])
	);
	
	
	
	// STATE MACHINE (Combinational Logic)
	always_comb begin
		case (current_state)
			RESET: begin
				if(start_stop) begin
					next_state = STAGE1;
				end else begin
					next_state = current_state;
				end
			end
			STAGE1: begin
				next_state = STAGE2;
			end
			STAGE2: begin
				next_state = STAGE3;
			end
			STAGE3: begin
				next_state = STAGE4;
			end
			STAGE4: begin
				next_state = DONE;
			end
			DONE: begin
				if(reset) begin
					next_state = RESET;
				end else if(start_stop) begin 
					next_state = STAGE1;
				end else begin 
					next_state = current_state;
				end
			end
			default: begin
				next_state = RESET;
			end 
		endcase
	end
	
	// STATE MACHINE (Sequential Logic)
	always @(posedge clk) begin
		current_state <= next_state;
		case(current_state)
			RESET: begin
				for (integer i = 0; i < 16; i++) begin
					fd[i] <= 0;
				end
				
				done <= 0;
			end
			STAGE1: begin
				
				A1 <= td[0];
            B1 <= td[1];
            W1 <= W_0_16;

            A2 <= td[2];
            B2 <= td[3];
            W2 <= W_0_16;
				
				A3 <= td[4];
            B3 <= td[5];
            W3 <= W_0_16;
				
				A4 <= td[6];
            B4 <= td[7];
            W4 <= W_0_16;
				
				A5 <= td[8];
            B5 <= td[9];
            W5 <= W_0_16;
				
				A6 <= td[10];
            B6 <= td[11];
            W6 <= W_0_16;
				
				A7 <= td[12];
            B7 <= td[13];
            W7 <= W_0_16;
				
				A8 <= td[14];
            B8 <= td[15];
            W8 <= W_0_16;
				
				done <= 0;
				
			end
			STAGE2: begin
			
				A1 <= interm[0];
            B1 <= interm[2];
            W1 <= W_0_16;

            A2 <= interm[1];
            B2 <= interm[3];
            W2 <= W_4_16;
				
				A3 <= interm[4];
            B3 <= interm[6];
            W3 <= W_0_16;
				
				A4 <= interm[5];
            B4 <= interm[7];
            W4 <= W_4_16;
				
				A5 <= interm[8];
            B5 <= interm[10];
            W5 <= W_0_16;
				
				A6 <= interm[9];
            B6 <= interm[11];
            W6 <= W_4_16;
				
				A7 <= interm[12];
            B7 <= interm[14];
            W7 <= W_0_16;
				
				A8 <= interm[13];
            B8 <= interm[15];
            W8 <= W_4_16;
				
				done <= 0;
				
			end
			STAGE3: begin
			
				A1 <= interm[0];
            B1 <= interm[4];
            W1 <= W_0_16;

            A2 <= interm[2];
            B2 <= interm[6];
            W2 <= W_2_16;
				
				A3 <= interm[1];
            B3 <= interm[5];
            W3 <= W_4_16;
				
				A4 <= interm[3];
            B4 <= interm[7];
            W4 <= W_6_16;
				
				A5 <= interm[8];
            B5 <= interm[12];
            W5 <= W_0_16;
				
				A6 <= interm[10];
            B6 <= interm[14];
            W6 <= W_2_16;
				
				A7 <= interm[9];
            B7 <= interm[13];
            W7 <= W_4_16;
				
				A8 <= interm[11];
            B8 <= interm[15];
            W8 <= W_6_16;
				
				done <= 0;
				
			end
			STAGE4: begin
				
				A1 <= interm[0];
            B1 <= interm[8];
            W1 <= W_0_16;

            A2 <= interm[2];
            B2 <= interm[10];
            W2 <= W_1_16;
				
				A3 <= interm[4];
            B3 <= interm[12];
            W3 <= W_2_16;
				
				A4 <= interm[6];
            B4 <= interm[14];
            W4 <= W_3_16;
				
				A5 <= interm[1];
            B5 <= interm[9];
            W5 <= W_4_16;
				
				A6 <= interm[3];
            B6 <= interm[11];
            W6 <= W_5_16;
				
				A7 <= interm[5];
            B7 <= interm[13];
            W7 <= W_6_16;
				
				A8 <= interm[7];
            B8 <= interm[15];
            W8 <= W_7_16;
				
				done <= 0;
				
			end
			DONE: begin
				fd[0] <= interm[0]; 
				fd[1] <= interm[2];
				fd[2] <= interm[4];
				fd[3] <= interm[6];
				fd[4] <= interm[8]; 
				fd[5] <= interm[10];
				fd[6] <= interm[12];
				fd[7] <= interm[14];
				fd[8] <= interm[1]; 
				fd[9] <= interm[3];
				fd[10] <= interm[5];
				fd[11] <= interm[7];
				fd[12] <= interm[9]; 
				fd[13] <= interm[11];
				fd[14] <= interm[13];
				fd[15] <= interm[15];
				
				done <= 1;
			end
		endcase
	end
	
	always @(posedge clk) begin
		//start_stop_sr <= {start_stop_sr[0], start_stop_btn};
		rst_sr <= {rst_sr[0], rst_btn};
	end
	
	
endmodule
