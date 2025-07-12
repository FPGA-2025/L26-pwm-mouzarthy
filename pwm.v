module PWM (
    input wire clk,
    input wire rst_n,
    input wire [15:0] duty_cycle, // duty_cycle = period * duty_porcent, 0 <= duty_porcent <= 1
    input wire [15:0] period, // clk_freq / pwm_freq = period
    output reg pwm_out
);

reg [15:0] counter;

always @( posedge clk or negedge rst_n ) 
begin
    if( !rst_n ) 
    begin
        // Reset assíncrono
        counter <= 0;
        pwm_out <= 0;
    end 
    else 
    begin
        // Incrementa o contador
        if( counter <= period ) 
        begin
            counter <= counter + 1;
        end 
        else 
        begin
            // Reinicia o contador quando atinge o período
            counter <= 0;
        end

        // Gera a saída PWM
        if( counter < duty_cycle ) 
        begin
            pwm_out <= 1;
        end 
        else 
        begin
            pwm_out <= 0;
        end
    end
end

endmodule
