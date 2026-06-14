`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2026 06:47:40 PM
// Design Name: 
// Module Name: LRU_cache
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module LRU_cache #(
    parameter WIDTH = 8,
    parameter DEPTH = 4
)(
    input  wire                 clk,
    input  wire                 rst,
    input  wire                 req_valid,
    input  wire [WIDTH-1:0]     req_addr,

    output reg                  hit,
    output reg [WIDTH-1:0]      evicted_addr,
    output reg                  evict_valid
);

    

    reg [7:0]mem[0:3];
    reg valid[0:3];
    reg [7:0]temp;
    reg [1:0]full;
    integer found,i,j;


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            full <= 0;
            hit <= 0;
            evict_valid <= 0;
            evicted_addr <= 0;
           for( i=0;i<DEPTH;i=i+1) begin
                mem[i]   <= 0;
                valid[i] <= 1'b0;
              end
        end 
            // TODO: Main LRU behavior
         else begin
            if(req_valid) begin
                found=0;
                hit<= 0;
                evict_valid <= 0;
                evicted_addr <= 0;
                for(i=2'd0;i<=2'b11;i=i+1)begin
                      if(mem[i]==req_addr && valid[i]==1) begin
                            hit<=1'b1;
                            found=1;
                            for(j=i;j<2'b11;j=j+1)begin
                              mem[j]<=mem[j+1];
                              end
                             mem[2'b11]<=req_addr;
                             break;
                            end
                end
                  if(!found)begin    
                             hit<=1'b0;
                             if(full==2'b11 && valid[full]==1)begin
                             evict_valid<=1;
                             evicted_addr<=mem[0];
                             for(i=2'b0;i<2'b11;i=i+1)begin
                             mem[i]<=mem[i+1];
                             end
                             mem[2'b11]<=req_addr;

                             end
                             else begin
                              mem[full]<=req_addr;
                              valid[full]<=1;
                              if(full != 2'b11) full <= full + 1;
                              evict_valid<=0;
                             end
                       end       
                  end
          end
    end


endmodule
