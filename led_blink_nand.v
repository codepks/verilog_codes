//LED blink code

//making a module for the entire code

module led_blink(switch1,switch2,enable_pin,led_out);

input i_clock:
input switch1;
input switch2;
input enable_pin;
output led_out;

//making clocks(counter process) for overflow checks
reg [31:0]  clock_1hz   =   0;
reg [31:0]  clock_10hz  =   0;
reg [31:0]  clock_50hz  =   0;
reg [31:0]  clock_100hz =   0;

//making constants for limit of the clocks
//suppose the clock freq is 25 Mhz then 1 hz would get over by
// 25/1=25 counters
parameter clock_1hz_lim     =   25000000;
parameter clock_10hz_lim    =   2500000;
parameter clock_50hz_lim    =   500000;
parameter clock_100hz_lim   =   250000;

//making toggle pins to switch on the LEDs
reg toggle_1hz_led      =   1'b0;
reg toggle_10hz_led     =   1'b0;
reg toggle_50hz_led     =   1'b0;
reg toggle_100hz_led    =   1'b0;


//Creating LEDs based on time the toggles are made
//reg led_1hz_select      =   1'b0;
//reg led_10hz_select     =   1'b0;
//reg led_50hz_select     =   1'b0;
//reg led_100hz_select    =   1'b0;
wire led_select =   1'b0;

//Run the following clocks(counter processes) no matter which clock is chosed
begin

always @(posedge i_clock)
begin
    if (clock_1hz == clock_1hz_lim -1) //if the counters is full
        begin
        toggle_1hz_led <= !toggle_1hz_led;
        clock_1hz   <=  0;
        end
    else
        clock_1hz = clock_1hz + 1;  //else increment the clock
end

always @(posedge i_clock)
begin
    if (clock_10hz = clock_10hz_lim -1) //if the counters is full
        begin
        toggle_10hz_led <= !toggle_10hz_led;
        clock_10hz   <=  0;
        end
    else
        clock_10hz = clock_10hz + 1;  //else increment the clock
end


always @(posedge i_clock)
begin
    if (clock_50hz = clock_50hz_lim -1) //if the counters is full
        begin
        toggle_50hz_led <= !toggle_50hz_led;
        clock_50hz   <=  0;
        end
    else
        clock_50hz = clock_50hz + 1;  //else increment the clock
end


always @(posedge i_clock)
begin
    if (clock_100hz = clock_100hz_lim -1) //if the counters is full
        begin
        toggle_100hz_led <= !toggle_100hz_led;
        clock_100hz   <=  0;
        end
    else
        clock_100hz = clock_100hz + 1;  //else increment the clock
end

//another check which would check the choice of swiches and give value to led output 
//here we will use switch case
//making a multiplexer
always @(*)//constantly check for these inputs as they are part of sensitivity list now
begin
    case ({switch1,switch2}) //{} is a concatenation operator
        2'b00  :   led_select    =   toggle_1hz_led;
        2'b01  :   led_select    =   toggle_10hz_led;
        2'b10  :   led_select    =   toggle_50hz_led;
        2'b11  :   led_select    =   toggle_100hz_led;
    endcase          
end
    assign led_out  =   led_select  &   enable_pin;


end
endmodule
