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

module lookahead_carry_unit(
  input Cin,
  input G0, G1, G2, G3,
  input P0, P1, P2, P3,
  output C0, C1, C2, C3
);
  assign C0 = G0 | P0 & Cin;
  assign C1 = G1 | P1 & G0 | P1 & P0 & Cin;
  assign C2 = G2 | P2 & G1 | P2 & P1 & G0 | P2 & P1 & P0 & Cin;
  assign C3 = G3 | P3 & G2 | P3 & P2 & G1 | P3 & P2 & P1 & G0 | P3 & P2 & P1 & P0 & Cin;

endmodule
