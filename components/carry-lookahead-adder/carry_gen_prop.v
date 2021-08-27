/*
* MIT License
*
* Copyright (c) 2021 Joseph Loaiza
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

`timescale 1ps / 1ps

`include "assert.v"

/*
* Generate and propagate signals for a carry lookahead adder.
*
* Note that `P = A XOR B` instead of the usual `P = A OR B`. This can be used
* later to calculate the sum value as `SUMi = Ci XOR Ai XOR Bi` where Ci is the
* carry and, Ai and Bi are the operands. Demonstration is available at
* https://youtu.be/EmJA-eEy-b0?t=1188.
*
* @param A one of the operands of the addition.
* @param B one of the operands of the addition.
* @param G generate signal. G = A AND B.
* @param P propagate signal. P = A XOR B.
*/
module carry_gen_prop (
  input A, B,
  output G, P
);
  assign G = A & B;
  assign P = A ^ B;
endmodule

module carry_gen_prop_testbench ();

  reg a, b;
  wire g, p;

  carry_gen_prop DUT(.A(a), .B(b), .G(g), .P(p));

  initial begin
    a = 0;
    b = 0;
    #10;
    `assert(g, 1'b0)
    `assert(p, 1'b0)

    a = 0;
    b = 1;
    #10;
    `assert(g, 1'b0)
    `assert(p, 1'b1)

    a = 1;
    b = 1;
    #10;
    `assert(g, 1'b1)
    `assert(p, 1'b0)

    #100;
  end

endmodule
