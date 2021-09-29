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

module carry_lookahead_adder4 (
  input [3:0] A,
  input [3:0] B,
  input Cin,
  output [3:0] S,
  output G3, P3, Cout
);
  wire g0, g1, g2;
  wire p0, p1, p2;
  wire c1, c2, c3;

  carry_gen_prop cp0(.A(A[0]), .B(B[0]), .G(g0), .P(p0));
  carry_gen_prop cp1(.A(A[1]), .B(B[1]), .G(g1), .P(p1));
  carry_gen_prop cp2(.A(A[2]), .B(B[2]), .G(g2), .P(p2));
  carry_gen_prop cp3(.A(A[3]), .B(B[3]), .G(G3), .P(P3));

  lookahead_carry_unit lcu_1(
    .Cin(Cin),
    .G0(g0),
    .G1(g1),
    .G2(g2),
    .G3(G3),
    .P0(p0),
    .P1(p1),
    .P2(p2),
    .P3(P3),
    .C0(c1),
    .C1(c2),
    .C2(c3),
    .C3(Cout)
  );

  assign S[0] = p0 ^ Cin;
  assign S[1] = p1 ^ c1;
  assign S[2] = p2 ^ c2;
  assign S[3] = P3 ^ c3;

endmodule
