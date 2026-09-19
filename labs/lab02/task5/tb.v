module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  alu dut (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  // Waveform dump
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, dut);
    end
  end

  initial begin
    // ADD tests
    t_op = 0;
    t_a = 4'd2;  t_b = 4'd3;  #1;
    if (t_result !== 4'd5)
      $display("FAIL ADD: a=%0d b=%0d result=%0d expected=5",
               t_a, t_b, t_result);

    t_a = 4'd7;  t_b = 4'd4;  #1;
    if (t_result !== 4'd11)
      $display("FAIL ADD: a=%0d b=%0d result=%0d expected=11",
               t_a, t_b, t_result);

    // Sensitivity-list test:
    // Change only op while a and b stay the same.
    t_a = 4'd7;
    t_b = 4'd3;
    t_op = 0;
    #1;

    t_op = 1;
    #1;

    if (t_result !== 4'd4)
      $display("FAIL SENSITIVITY: a=%0d b=%0d op=%b result=%0d expected=4",
               t_a, t_b, t_op, t_result);

    // SUB tests
    t_a = 4'd10;
    t_b = 4'd3;
    t_op = 1;
    #1;

    if (t_result !== 4'd7)
      $display("FAIL SUB: a=%0d b=%0d result=%0d expected=7",
               t_a, t_b, t_result);

    t_a = 4'd5;
    t_b = 4'd8;
    #1;

    // 4-bit result: 5 - 8 = -3 = 13
    if (t_result !== 4'd13)
      $display("FAIL SUB: a=%0d b=%0d result=%0d expected=13",
               t_a, t_b, t_result);

    $display("ALU test completed.");
    $finish;
  end

  initial
    $monitor($time,
             " a=%0d b=%0d op=%b | result=%0d",
             t_a, t_b, t_op, t_result);

endmodule