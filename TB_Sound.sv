module TB_Sound;

    // Inputs
    logic clk;
    logic reset;
    logic [3:0] sound_select; // Example input to choose sound
    logic play;               // Signal to start playing sound

    // Outputs
    logic sound_output;       // Example output signal for sound

    // Instantiate the DUT (Device Under Test)
    sound_controller dut (
        .clk(clk),
        .reset(reset),
        .sound_select(sound_select),
        .play(play),
        .sound_output(sound_output)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Test tasks
    task play_sound(input logic [3:0] select, input logic play_signal);
        @(negedge clk);
        sound_select <= select;
        play <= play_signal;
        @(posedge clk);
        #1;
        $display("Time=%0t | Sound Select=%b | Play=%b | Sound Output=%b", 
                  $time, sound_select, play, sound_output);
    endtask

    task reset_test();
        @(negedge clk);
        reset <= 1'b1;
        @(posedge clk);
        #1;
        $display("Time=%0t | Reset activated | Sound Output=%b", $time, sound_output);
        reset <= 1'b0;
    endtask

    // Test sequence
    initial begin
        $display("Starting Sound Controller Tests...");

        // Initialize inputs
        reset = 1'b0;
        sound_select = 4'b0000;
        play = 1'b0;

        // Reset test
        reset_test();

        // Play sound 0
        play_sound(4'b0000, 1'b1);

        // Play sound 1
        play_sound(4'b0001, 1'b1);

        // Play sound 2
        play_sound(4'b0010, 1'b1);

        // Stop playing
        play_sound(4'b0010, 1'b0);

        // Play an undefined sound
        play_sound(4'b1111, 1'b1);

        $display("Sound Controller Tests Completed.");
        $stop;
    end

endmodule
