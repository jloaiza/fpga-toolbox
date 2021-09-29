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

module carry_lookahead_adder16 (
  input [15:0] A,
  input [15:0] B,
  input Cin,
  output [15:0] S,
  output Cout
);

  wire c4, c8, c12;
  wire g3, g7, g11, g15;
  wire p3, p7, p11, p15;

  carry_lookahead_adder4 cla4_a(
    .A(A[3:0]),
    .B(B[3:0]),
    .Cin(Cin),
    .S(S[3:0]),
    .G3(g3),
    .P3(p3)
  );

  carry_lookahead_adder4 cla4_b(
    .A(A[7:4]),
    .B(B[7:4]),
    .Cin(c4),
    .S(S[7:4]),
    .G3(g7),
    .P3(p7)
  );

  carry_lookahead_adder4 cla4_c(
    .A(A[11:8]),
    .B(B[11:8]),
    .Cin(c8),
    .S(S[11:8]),
    .G3(g11),
    .P3(p11)
  );

  carry_lookahead_adder4 cla4_d(
    .A(A[15:12]),
    .B(B[15:12]),
    .Cin(c12),
    .S(S[15:12]),
    .G3(g15),
    .P3(p15)
  );

  lookahead_carry_unit lcu_1(
    .Cin(Cin),
    .G0(g3),
    .G1(g7),
    .G2(g11),
    .G3(g15),
    .P0(p3),
    .P1(p7),
    .P2(p11),
    .P3(p15),
    .C0(c4),
    .C1(c8),
    .C2(c12),
    .C3(Cout)
  );

endmodule
