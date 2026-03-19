module Sync_FIFO 
    #(parameter Depth = 8, 
      parameter Width = 32)

    (input clk, rst,
    input cs,
    input read_en, write_en,

    input [Width-1 : 0] data_in,
    output reg [Width-1 : 0] data_out,
    output full, empty
    );

    localparam Depth_log = $clog2(Depth); //gives no of bits to represent depth

    reg [Depth_log:0] read_ptr, write_ptr;
    reg [Width - 1 : 0] fifo [0 : Depth-1];

    assign empty = (read_ptr == write_ptr) ? 1'b1 : 1'b0;
    assign full = (read_ptr == {~write_ptr[Depth_log], write_ptr[Depth_log-1:0]}) ? 1'b1 : 1'b0;

    always @(posedge clk or  negedge rst)  begin
     
        if (rst == 1'b0) 
            read_ptr <= 0;

        else if (read_en && cs && !empty) begin
            data_out <= fifo[read_ptr[Depth_log-1 : 0]];
            read_ptr <= read_ptr + 1'b1;

        end
    end

    always @(posedge clk or negedge rst)  begin
     
        if (rst == 1'b0) 
            write_ptr <= 0;

        else if (write_en && cs && !full) begin
            fifo[write_ptr[Depth_log-1 : 0]] <= data_in;
            write_ptr <= write_ptr + 1'b1;

        end
    end

endmodule