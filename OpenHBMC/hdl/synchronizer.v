/* 
 * ----------------------------------------------------------------------------
 *  Project:  OpenHBMC
 *  Filename: synchronizer.v
 *  Purpose:  Simple, single bit, clock domain crossing synchronizer.
 * ----------------------------------------------------------------------------
 *  Copyright © 2020, Vaagn Oganesyan <ovgn@protonmail.com>
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


module synchronizer #
(
    parameter   C_SYNC_STAGES = 3
)
(
    input   wire    clk,
    input   wire    d,
    output  wire    q
);
  
    (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "no" *) reg  [C_SYNC_STAGES - 1:0] sync_reg = {C_SYNC_STAGES{1'b0}};

    always @(posedge clk) begin
        sync_reg <= {sync_reg[C_SYNC_STAGES - 2:0], d};
    end    
    
    assign q = sync_reg[C_SYNC_STAGES - 1];
    
endmodule

/*----------------------------------------------------------------------------------------------------------------------------*/

`default_nettype wire
