module tb;

  reg [1:0] t_A;
  reg [1:0] t_B;

  wire t_GT;
  wire t_LT;
  wire t_EQ;

  integer a;
  integer b;

  // Instantiate DUT
  comp2 dut (
    .A(t_A),
    .B(t_B),
    .GT(t_GT),
    .LT(t_LT),
    .EQ(t_EQ)
  );

  // Waveform dump
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, dut);
    end
  end

  // Self-checking test
  initial begin
    for (a = 0; a < 4; a = a + 1) begin
      for (b = 0; b < 4; b = b + 1) begin

        t_A = a;
        t_B = b;

        #1;

        if (t_GT !== (a > b))
          $display("FAIL: A=%0d B=%0d GT=%b expected=%b",
                   a, b, t_GT, (a > b));

        if (t_LT !== (a < b))
          $display("FAIL: A=%0d B=%0d LT=%b expected=%b",
                   a, b, t_LT, (a < b));

        if (t_EQ !== (a == b))
          $display("FAIL: A=%0d B=%0d EQ=%b expected=%b",
                   a, b, t_EQ, (a == b));

        // Exactly one output must be asserted
        if ((t_GT + t_LT + t_EQ) != 1)
          $display("FAIL: A=%0d B=%0d outputs GT=%b LT=%b EQ=%b",
                   a, b, t_GT, t_LT, t_EQ);

      end
    end

    $display("Self-checking test completed.");
    $finish;
  end

endmodule