module butterfly_unit #(WIDTH=32) (
    input logic signed [WIDTH-1:0] A,
    input logic signed [WIDTH-1:0] B,
    input logic signed [WIDTH-1:0] W,
    
    output logic signed [WIDTH-1:0] out0,
    output logic signed [WIDTH-1:0] out1
);

    logic signed [(WIDTH/2)-1:0] A_real;
	 logic signed [(WIDTH/2)-1:0] A_imag;
    logic signed [(WIDTH/2)-1:0] B_real;
	 logic signed [(WIDTH/2)-1:0] B_imag;
    logic signed [(WIDTH/2)-1:0] W_real;
	 logic signed [(WIDTH/2)-1:0] W_imag;
    
    always_comb begin
        A_real = A[WIDTH-1:WIDTH/2];
        A_imag = A[(WIDTH/2)-1:0];
        
        B_real = B[WIDTH-1:WIDTH/2];
        B_imag = B[(WIDTH/2)-1:0];
        
        W_real = W[WIDTH-1:WIDTH/2];
        W_imag = W[(WIDTH/2)-1:0];
    end
    
    logic signed [WIDTH-1:0] Wreal_Breal;
	 logic signed [WIDTH-1:0] Wimag_Bimag;
    logic signed [WIDTH-1:0] Wimag_Breal;
	 logic signed [WIDTH-1:0] Wreal_Bimag;
	 
    always_comb begin
        Wreal_Breal = W_real * B_real;
        Wimag_Bimag = W_imag * B_imag;
        Wimag_Breal = W_imag * B_real;
        Wreal_Bimag = W_real * B_imag;
    end

	 // TRUNCATION
	 
	 logic signed [(WIDTH/2)-1:0] Wreal_Breal_trunc; 
	 logic signed [(WIDTH/2)-1:0] Wimag_Bimag_trunc;
	 logic signed [(WIDTH/2)-1:0] Wimag_Breal_trunc; 
	 logic signed [(WIDTH/2)-1:0] Wreal_Bimag_trunc;
	 
	 always_comb begin
        Wreal_Breal_trunc = Wreal_Breal[WIDTH-2:(WIDTH/2)-1];
        Wimag_Bimag_trunc = Wimag_Bimag[WIDTH-2:(WIDTH/2)-1];
        Wimag_Breal_trunc = Wimag_Breal[WIDTH-2:(WIDTH/2)-1];
        Wreal_Bimag_trunc = Wreal_Bimag[WIDTH-2:(WIDTH/2)-1];
    end
	 
	 // ADDITION
	 
	 logic signed [(WIDTH/2)-1:0] WB_real;
	 logic signed [(WIDTH/2)-1:0] WB_imag;
	 
	 always_comb begin
        WB_real = Wreal_Breal_trunc - Wimag_Bimag_trunc;
        WB_imag = Wimag_Breal_trunc + Wreal_Bimag_trunc;
    end
	 
	 logic signed [(WIDTH/2)-1:0] out0_real;
	 logic signed [(WIDTH/2)-1:0] out0_imag;
	 logic signed [(WIDTH/2)-1:0] out1_real;
	 logic signed [(WIDTH/2)-1:0] out1_imag;
	
	 always_comb begin
        out0_real = A_real+WB_real;
		  out0_imag = A_imag+WB_imag;
		  out1_real = A_real-WB_real;
		  out1_imag = A_imag-WB_imag;
    end
	 
	 always_comb begin
	     out0 = {out0_real, out0_imag};
		  out1 = {out1_real, out1_imag};
	 end
	 
endmodule
