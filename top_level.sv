module top_level (
		input  logic CLK,
		input  logic RST,
		input  logic [3:0] BTN,
		output logic [3:0] LED,
		output logic [6:0] SEG_DISPLAY,
		output logic SOUND
	);

	logic [1:0] random_seq, mem_data;
	logic mem_write;
	logic [4:0] mem_addr;
	logic [9:0] frequency;

	Random_Sequence_Generator rng (
		.clk(CLK),
		.rst(RST),
		.random_seq(random_seq)
	);

	memory mem (
		.clk(CLK),
		.write_enable(mem_write),
		.addr(mem_addr),
		.write_data(random_seq),
		.read_data(mem_data)
	);

	fsm fsm_inst (
		.clk(CLK),
		.rst(RST),
		.btn(BTN),
		.random_seq(random_seq),
		.led(LED),
		.sound(SOUND),
		.frequency(frequency),
		.start_round(),
		.display_loss(),
		.mem_write(mem_write),
		.mem_addr(mem_addr),
		.mem_data(mem_data)
	);

	Tone_Generator tone_gen (
		.clk(CLK),
		.rst(RST),
		.frequency(frequency),
		.sound(SOUND)
	);

endmodule