
module magnitude(
	input logic [31:0] fd [0:15],
	output logic [255:0] mag
);

logic [15:0] real_abs [0:15];
logic [15:0] imag_abs [0:15];
genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin : mag_gen
		assign real_abs[i] = (fd[i][31]) ? (~fd[i][31:16] + 1) : (fd[i][31:16]);
		assign imag_abs[i] = (fd[i][15]) ? (~fd[i][15:0]  + 1) : (fd[i][15:0] );
      assign mag[((15-i)*16 + 15):((15-i)*16)] = (real_abs[i] > imag_abs[i]) ? 
																	(real_abs[i] + (imag_abs[i] >> 1)) : 
																	(imag_abs[i] + (real_abs[i] >> 1)) ;
    end
endgenerate


endmodule
