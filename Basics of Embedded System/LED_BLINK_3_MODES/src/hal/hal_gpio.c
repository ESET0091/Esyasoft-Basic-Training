

#include "hal_gpio.h"
#include "..\config\pin_config.h"
#include <util/delay.h>

static uint8_t state = 0; // 0: slow blink, 1: fast blink, 2: ON, 3: OFF/reset
static uint8_t last_button = 0;

void hal_gpio_init() {
    *led_ddr = 0xff;
    *button_ddr = 0x00;
}

int hal_gpio_button_read() {
    return (*button_port & (1 << button_pin)) ? 1 : 0;
}

void hal_gpio_set_led(uint8_t on) {
    if (on)
        *led_port |= (1 << led_pin);
    else
        *led_port &= ~(1 << led_pin);
}



void hal_gpio_handle_button() {
    static uint8_t last_button = 0;
    uint8_t button = hal_gpio_button_read();

    // Detect rising edge (button press)
    if (button && !last_button) {
        _delay_ms(50); // Debounce delay
        if (hal_gpio_button_read()) { // Confirm still pressed
            state = (state + 1) % 4;
        }
    }
    last_button = button;

    switch (state) {
        case 0: // OFF/reset
            hal_gpio_set_led(0);
            _delay_ms(50);
            break;
        case 1: // Slow blink
            hal_gpio_set_led(1);
            _delay_ms(500);
            hal_gpio_set_led(0);
            _delay_ms(500);
            break;
        case 2: // Fast blink
            hal_gpio_set_led(1);
            _delay_ms(100);
            hal_gpio_set_led(0);
            _delay_ms(100);
            break;
        case 3: // ON
            hal_gpio_set_led(1);
            _delay_ms(50);
            break;
       
    }
}