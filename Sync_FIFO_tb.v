module Sync_FIFO_tb;

    parameter Depth = 8;
    parameter Width = 32;

    reg clk, rst;
    reg cs;
    reg read_en, write_en;

    reg [Width-1 : 0] data_in;
    wire [Width-1 : 0] data_out;
    wire full, empty;

    Sync_FIFO #(.Depth(Depth), 
      .Width(Width))
    uut (   
        .clk(clk), 
        .rst(rst),
        .cs(cs),
        .read_en(read_en),
        .write_en(write_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full), 
        .empty(empty)
    );

    always #5 clk = ~clk; 

    task write_data(input [Width-1 : 0]d_in);
        begin
            @(posedge clk)
            cs = 1'b1;
            write_en = 1'b1;
            data_in = d_in;
            @(posedge clk)
            $display($time, " write_data data_in = %0d", data_in);
            cs = 1'b1;
            write_en = 1'b0;
        end
    endtask

    task read_data();
        begin
            @(posedge clk)
            cs = 1'b1;
            read_en = 1'b1;
            @(posedge clk)
            $display($time, " read_data data_out = %0d", data_out);
            cs = 1'b1;
            read_en = 1'b0;
        end
    endtask

    integer i;
    initial begin
        clk = 1'b0;
        rst = 0; read_en = 0; write_en = 0;
		
        @(posedge clk) 
		rst = 1;
		$display($time, "\n SCENARIO 1");
		write_data(1);
		write_data(10);
		write_data(100);
		read_data();
		read_data();
		read_data();
		//read_data();
		
        
        $display($time, "\n SCENARIO 2");
		for (i=0; i<Depth; i=i+1) begin
		    write_data(2**i);
			read_data();        
		end

        $display($time, "\n SCENARIO 3");		
		for (i=0; i<Depth; i=i+1) begin
		    write_data(2**i);
		end
		
		for (i=0; i<Depth; i=i+1) begin
			read_data();
		end
        #100
        $finish;
    end

    initial begin
        $dumpfile("Sync_FIFO.vcd");
        $dumpvars(0);
    end

endmodule