
#include <avr/io.h>
#include <util/delay.h>

#define LED_PIN PD4     // Pin 7 on PORTD
#define BUTTON_PIN PD1  // Pin 3 on PORTD

int main(void) {
    // Set LED_PIN as output
    DDRD |= (1 << LED_PIN);

    // Set BUTTON_PIN as input WITH pull-up resistor
    DDRD &= ~(1 << BUTTON_PIN);
    PORTD |= (1 << BUTTON_PIN);

    while (1) {
       if(!(PIND & (1<< BUTTON_PIN))) {
        // Turn on LED
        PORTD |= (1 << LED_PIN);
        _delay_ms(500); // Keep LED on for 500 ms

        // Turn off LED
        PORTD &= ~(1 << LED_PIN);
        _delay_ms(500); // Keep LED off for 500 ms
       }
       else {
        // Ensure LED is off when button is not pressed
        PORTD &= ~(1 << LED_PIN);
       }

    }

    return 0; // This line will never be reached
}