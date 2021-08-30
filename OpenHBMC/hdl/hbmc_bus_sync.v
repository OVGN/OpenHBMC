/* 
 * ----------------------------------------------------------------------------
 *  Project:  OpenHBMC
 *  Filename: hbmc_bus_sync.v
 *  Purpose:  Bus synchronizer with fast handshake logic.
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


module hbmc_bus_sync #
(
    parameter integer C_SYNC_STAGES = 3,
    parameter integer C_DATA_WIDTH  = 8
)
(
    input   wire                            src_clk,
    input   wire                            src_rstn,
    input   wire    [C_DATA_WIDTH - 1 : 0]  src_data,
    input   wire                            src_req,
    output  wire                            src_ack,

    input   wire                            dst_clk,
    input   wire                            dst_rstn,
    output  reg     [C_DATA_WIDTH - 1 : 0]  dst_data,
    output  reg                             dst_req,
    input   wire                            dst_ack
);

/*----------------------------------------------------------------------------------------------------------------------------*/
    
    wire    src_req_sync;
    
    
    hbmc_bit_sync #
    (
        .C_SYNC_STAGES  ( C_SYNC_STAGES ),
        .C_RESET_STATE  ( 1'b0          )
    )
    hbmc_bit_sync_inst_0
    (
        .arstn  ( dst_rstn      ),
        .clk    ( dst_clk       ),
        .d      ( src_req       ),
        .q      ( src_req_sync  )
    );

/*----------------------------------------------------------------------------------------------------------------------------*/

    reg     src_ack_async;
    
    
    hbmc_bit_sync #
    (
        .C_SYNC_STAGES  ( C_SYNC_STAGES ),
        .C_RESET_STATE  ( 1'b0          )
    )
    hbmc_bit_sync_inst_1
    (
        .arstn  ( src_rstn      ),
        .clk    ( src_clk       ),
        .d      ( src_ack_async ),
        .q      ( src_ack       )
    );

/*----------------------------------------------------------------------------------------------------------------------------*/

    localparam  [1:0]   ST_RST       = 2'd0,
                        ST_SRC_REQ   = 2'd1,
                        ST_DST_ACK   = 2'd2,
                        ST_HANDSHAKE = 2'd3;
    
    reg         [1:0]   state;


    always @(posedge dst_clk or negedge dst_rstn) begin
        if (~dst_rstn) begin
            src_ack_async <= 1'b0;
            dst_req       <= 1'b0;
            dst_data      <= {C_DATA_WIDTH{1'b0}};
            state         <= ST_RST;
        end else begin
            case (state)
                ST_RST: begin
                    src_ack_async <= 1'b0;
                    dst_req       <= 1'b0;
                    dst_data      <= {C_DATA_WIDTH{1'b0}};
                    state         <= ST_SRC_REQ;
                end
                
                ST_SRC_REQ: begin
                    if (src_req_sync & ~dst_ack) begin
                        dst_req  <= 1'b1;
                        dst_data <= src_data;
                        state    <= ST_DST_ACK;
                    end
                end
                
                ST_DST_ACK: begin
                    if (dst_ack) begin
                        src_ack_async <= 1'b1;
                        dst_req       <= 1'b0;
                        state         <= ST_HANDSHAKE;
                    end
                end
                
                ST_HANDSHAKE: begin
                    if (~src_req_sync) begin
                        src_ack_async <= 1'b0;
                        state         <= ST_SRC_REQ;
                    end
                end
            endcase
        end
    end
    
endmodule

/*----------------------------------------------------------------------------------------------------------------------------*/

`default_nettype wire
