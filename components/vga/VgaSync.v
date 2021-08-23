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

`timescale 1ns / 1ps

/*
* VGA synchronization signals for a 640x480 resolution screen.
*
* For a 640x480 resolution the VGA synchronization signal needs to go further
* and have a horizontal and vertical blank interval of several pixels. That is
* why the pixel count is extended to 800x525. This module provides a signal
* to indicate if the video should be on or if a blank interval is required.
*
* @param clk25MHz 25MHz clock.
* @param reset Reset the module and start from 0,0 pixels.
* @param hsync Horizontal synchronization signal.
* @param vsync Vertical synchronization signal.
* @param video_on Indicates if the current pixels are inside the
*        640x480 resolution.
* @param px Current pixel x coordinate.
* @param py Current pixel y coordinate.
*/
module VgaSync640x480(
  input clk25MHz,
  input reset,
  output reg hsync,
  output reg vsync,
  output wire video_on,
  output reg [9:0] px,
  output reg [9:0] py
);
  initial begin
    px = 0;
    py = 0;
  end

  reg v_count_en;
  wire h_count_en;

  // There is no reason to disable the horizontal count. It's defined for
  // a precise description of the hardware.
  assign h_count_en = 1;

  reg is_end_row;
  reg is_end_screen;

  wire h_count_reset;
  wire v_count_reset;
  assign h_count_reset = is_end_row | reset;
  assign v_count_reset = is_end_screen | reset;

  // Pixels counter.
  always @(posedge clk25MHz) begin
    if (h_count_reset) begin
      px <= 0;
    end
    else if (h_count_en) begin
      px <= px + 1'b1;
    end

    if (v_count_reset) begin
      py <= 0;
    end
    else if (v_count_en) begin
      py <= py + 1'b1;
    end
  end

  // video_on signals.
  reg h_video_on;
  reg v_video_on;

  assign video_on = h_video_on & v_video_on;

  always @(px) begin
    // Enable the vertical counter if the end of the row is reached.
    if (px == 800) begin
      is_end_row = 1;
      v_count_en = 1;
    end
    else begin
      is_end_row = 0;
      v_count_en = 0;
    end

    // Horizontal video_on.
    if (px < 639) begin
      h_video_on = 1;
    end
    else begin
      h_video_on = 0;
    end

    // hsync signal. Turn it off in the horizontal blank interval.
    if (px < 655 | px >= 751) begin
      hsync = 1;
    end
    else begin
      hsync = 0;
    end
  end

  always @(py) begin
    // Check if the end of the screen has been reached. This should reset
    // the vertical counter.
    if (py == 525) begin
      is_end_screen = 1;
    end
    else begin
      is_end_screen = 0;
    end

    // Vertical video_on.
    if (py < 479) begin
      v_video_on = 1;
    end
    else begin
      v_video_on = 0;
    end

    // vsync signal. Turn it off in the vertical blank interval.
    if (py < 489 | py >= 491) begin
      vsync = 1;
    end
    else begin
      vsync = 0;
    end
  end

endmodule
