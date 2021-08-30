/* 
 * ----------------------------------------------------------------------------
 *  Project:  OpenHBMC
 *  Filename: hbmc_id_fifo.v
 *  Purpose:  FIFO that stores AXI4 transaction ID data.
 * ----------------------------------------------------------------------------
 *  Copyright © 2020-2021, Vaagn Oganesyan <ovgn@protonmail.com>
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 * ----------------------------------------------------------------------------
 */

 
`default_nettype none
`timescale 1ps / 1ps


module hbmc_id_fifo #
(
    parameter integer AXI_ID_WIDTH = 8
)
(
    input   wire                            fifo_clk,
    input   wire                            fifo_rstn,
    
    input   wire    [AXI_ID_WIDTH - 1:0]    fifo_wr_din,
    input   wire                            fifo_wr_ena,
    output  wire                            fifo_wr_full,
    
    output  wire    [AXI_ID_WIDTH - 1:0]    fifo_rd_dout,
    input   wire                            fifo_rd_ena,
    output  wire                            fifo_rd_empty
);
    
/*----------------------------------------------------------------------------------------------------------------------------*/
    
    generate
        /* 
         * Check input AXI ID width parameter matches
         * generated FIFO primitive data width size.
         */
        if (AXI_ID_WIDTH > 8) begin
            INVALID_PARAMETER invalid_parameter_msg();
        end
    endgenerate
    
/*----------------------------------------------------------------------------------------------------------------------------*/
    
    fifo_8b_32w
    fifo_8b_32w_inst
    (
        .clk    ( fifo_clk      ),  // input wire clk
        .srst   ( ~fifo_rstn    ),  // input wire srst
        
        .wr_en  ( fifo_wr_ena   ),  // input wire wr_en
        .full   ( fifo_wr_full  ),  // output wire full
        .din    ( fifo_wr_din   ),  // input wire [7 : 0] din
        
        .rd_en  ( fifo_rd_ena   ),  // input wire rd_en
        .empty  ( fifo_rd_empty ),  // output wire empty
        .dout   ( fifo_rd_dout  )   // output wire [7 : 0] dout
    );

endmodule

/*----------------------------------------------------------------------------------------------------------------------------*/

`default_nettype wire
