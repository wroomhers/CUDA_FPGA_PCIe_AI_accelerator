`timescale 1ns / 1ps

module build_version_led #(
    parameter [3:0] VERSION = 4'h1
)(
    output wire [3:0] version_led_n
);

    // Karttaki user LED'ler active-low ise:
    // VERSION biti 1 olduğunda LED yansın diye tersliyoruz.
    assign version_led_n = ~VERSION;

endmodule