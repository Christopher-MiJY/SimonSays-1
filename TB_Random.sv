module TB_Random;

    // Testbench Signals
    logic clk;                // Clock signal
    logic rst;                // Reset signal
    logic [1:0] random_seq;   // Output random sequence

    // Instantiate the Random Sequence Generator module
    Random_Sequence_Generator uut (
        .clk        (clk),
        .rst        (rst),
        .random_seq (random_seq)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period = 10 time units
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst = 1;
        #10; // Hold reset for 10 time units
        
        rst = 0; // Release reset
        #100; // Allow the generator to run for a while

        // Simulate a second reset
        rst = 1;
        #10;
        rst = 0;
        #100;

        // Finish simulation
        $stop;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time: %0t | Reset: %b | Random Sequence: %b",
                 $time, rst, random_seq);
    end

endmodule
