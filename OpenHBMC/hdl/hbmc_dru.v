/* 
 * ----------------------------------------------------------------------------
 *  Project:  OpenHBMC
 *  Filename: hbmc_dru.v
 *  Purpose:  Data recovery unit.
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


module hbmc_dru
(
    input   wire            clk,
    input   wire            arstn,
    input   wire    [5:0]   rwds_oversampled,
    input   wire    [47:0]  data_oversampled,
    output  wire            recov_valid,
    output  wire    [15:0]  recov_data
);


    reg             prev_last_bit;
    reg     [5:0]   rwds_pair_xor;
    reg     [47:0]  data_pair;
    
    
    always @(posedge clk or negedge arstn) begin
        if (~arstn) begin
            prev_last_bit <= 1'b0;
            rwds_pair_xor <= {6{1'b0}};
            data_pair     <= {48{1'b0}};
        end else begin
            data_pair     <= data_oversampled;
            prev_last_bit <= rwds_oversampled[5];
            rwds_pair_xor <= {
                                 ^ rwds_oversampled[5:4],
                                 ^ rwds_oversampled[4:3],
                                 ^ rwds_oversampled[3:2],
                                 ^ rwds_oversampled[2:1],
                                 ^ rwds_oversampled[1:0],
                                   rwds_oversampled[0] ^ prev_last_bit
                             };
        end
    end
    
/*----------------------------------------------------------------------------------------------------------------------------*/
    
    genvar i;
    
    wire    [7:0]   data_l_mux_0;
    wire    [7:0]   data_l_mux_1;
    wire    [7:0]   data_l_mux_2;
    
    generate
        for (i = 0; i < 8; i = i + 1) begin : hram_data_l_mux
            assign data_l_mux_0[i] = data_pair[6 * i + 0];
            assign data_l_mux_1[i] = data_pair[6 * i + 1];
            assign data_l_mux_2[i] = data_pair[6 * i + 2];
        end
    endgenerate
    
    
    wire    [7:0]   data_h_mux_0;
    wire    [7:0]   data_h_mux_1;
    wire    [7:0]   data_h_mux_2;
    
    generate
        for (i = 0; i < 8; i = i + 1) begin : hram_data_h_mux
            assign data_h_mux_0[i] = data_pair[6 * i + 3];
            assign data_h_mux_1[i] = data_pair[6 * i + 4];
            assign data_h_mux_2[i] = data_pair[6 * i + 5];
        end
    endgenerate
    
/*----------------------------------------------------------------------------------------------------------------------------*/
    
    reg             carry;
    reg     [7:0]   data_h;
    reg     [7:0]   data_l;
    reg     [1:0]   data_strb;
    
    
    always @(posedge clk or negedge arstn) begin
        if (~arstn) begin
            carry     <= 1'b0;
            data_h    <= 8'h00;
            data_l    <= 8'h00;
            data_strb <= 2'b00;
        end else begin
            carry <= rwds_pair_xor[5];
            
            case (rwds_pair_xor[4:0])
                
                5'b00000: begin
                    data_h    <= data_h;
                    data_l    <= (carry)? data_l_mux_0 : data_l;
                    data_strb <= (carry)? 2'b01 : 2'b00;
                end
                
                5'b10000: begin
                    data_h    <= data_h_mux_2;
                    data_l    <= data_l;
                    data_strb <= 2'b10;
                end
                
                5'b01000: begin
                    data_h    <= data_h_mux_1;
                    data_l    <= (carry)? data_l_mux_0 : data_l;
                    data_strb <= (carry)? 2'b11 : 2'b10;
                end
                
                5'b00100: begin
                    data_h    <= data_h_mux_0;
                    data_l    <= (carry)? data_l_mux_0 : data_l;
                    data_strb <= (carry)? 2'b11 : 2'b10;
                end
                
                5'b10100: begin
                    data_h    <= data_h_mux_2;
                    data_l    <= data_h_mux_0;
                    data_strb <= 2'b11;
                end
                
                5'b10010: begin
                    data_h    <= data_h_mux_2;
                    data_l    <= data_l_mux_2;
                    data_strb <= 2'b11;
                end
                
                5'b00010: begin
                    data_h    <= data_h;
                    data_l    <= data_l_mux_2;
                    data_strb <= 2'b01;
                end
                
                5'b01010: begin
                    data_h    <= data_h_mux_1;
                    data_l    <= data_l_mux_2;
                    data_strb <= 2'b11;
                end
                
                5'b00001: begin
                    data_h    <= data_h;
                    data_l    <= data_l_mux_1;
                    data_strb <= 2'b01;
                end
                
                5'b10001: begin
                    data_h    <= data_h_mux_2;
                    data_l    <= data_l_mux_1;
                    data_strb <= 2'b11;
                end
                
                5'b01001: begin
                    data_h    <= data_h_mux_1;
                    data_l    <= data_l_mux_1;
                    data_strb <= 2'b11;
                end
                
                5'b00101: begin
                    data_h    <= data_h_mux_0;
                    data_l    <= data_l_mux_1;
                    data_strb <= 2'b11;
                end
                
                default: begin
                    data_h    <= data_h;
                    data_l    <= data_l;
                    data_strb <= 2'b00;
                end
                
            endcase
        end
    end
    
/*----------------------------------------------------------------------------------------------------------------------------*/
    
    localparam  [1:0]   ST_RST        = 2'b00,
                        ST_LOW_FIRST  = 2'b01,
                        ST_HIGH_FIRST = 2'b10,
                        ST_BOTH       = 2'b11;
    
    reg     [1:0]   state;
    reg     [7:0]   temp;
    reg     [15:0]  data;
    reg             valid;
    
    
    always @(posedge clk or negedge arstn) begin
        if (~arstn) begin
            temp  <=  {8{1'b0}};
            data  <= {16{1'b0}};
            valid <= 1'b0;
            state <= ST_RST;
        end else begin
            case (state)
                ST_RST: begin
                    case (data_strb)
                        2'b00: begin
                            valid <= 1'b0;
                            state <= state;
                        end
                        
                        2'b01: begin
                            temp  <= data_l;
                            state <= ST_LOW_FIRST;
                        end
                        
                        2'b10: begin
                            temp <= data_h;
                            state <= ST_HIGH_FIRST;
                        end
                        
                        2'b11: begin
                            data  <= {data_h, data_l};
                            valid <= 1'b1;
                            state <= ST_BOTH;
                        end
                    endcase
                end
                
                ST_LOW_FIRST: begin
                    case (data_strb)
                        2'b10,
                        2'b11: begin
                            valid <= 1'b1;
                            data  <= {data_h, temp};
                            temp <= data_l;
                        end
                        
                        default: begin
                            valid <= 1'b0;
                            state <= ST_RST;
                        end
                    endcase
                end
                
                ST_HIGH_FIRST: begin
                    case (data_strb)
                        2'b01,
                        2'b11: begin
                            valid <= 1'b1;
                            data  <= {data_l, temp};
                            temp <= data_h;
                        end
                        
                        default: begin
                            valid <= 1'b0;
                            state <= ST_RST;
                        end
                    endcase
                end
                
                ST_BOTH: begin
                    if (data_strb == 2'b11) begin
                        valid <= 1'b1;
                        data  <= {data_h, data_l};
                    end else begin
                        valid <= 1'b0;
                        state <= ST_RST;
                    end
                end
            endcase
        end
    end
    
    
    assign recov_valid = valid;
    assign recov_data  = {data[7:0], data[15:8]};


endmodule

/*----------------------------------------------------------------------------------------------------------------------------*/

`default_nettype wire
