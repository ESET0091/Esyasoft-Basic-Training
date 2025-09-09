// #include <Arduino.h>
// #include <avr/io.h>
// #include <util/delay.h>

// #define DATA_PIND7 PD7
// #define DATA_PIND6 PB0
// #define DATA_PIND5 PB1
// #define DATA_PIND4 PB2
// #define ENABLE PB3
// #define DATA_RS PB4


// void lcd_pulse(){
//     PORTB |= (1<<ENABLE); // Enable high
//     _delay_ms(100); // wait for 1 microsecond
//     PORTB &= ~(1<<ENABLE); // Enable low
//     _delay_ms(200); // wait for 100 microseconds
// }

// void lcd_command(unsigned char cmd) {
//     PORTB &= ~(1<<DATA_RS) // RS = 0 for command

//    // Send higher nibble
//     if(cmd & 0x10) PORTB |= (1<<DATA_PIND4); 
//     else PORTB &= ~(1<<DATA_PIND4);

//     if(cmd & 0x20) PORTB |= (1<<DATA_PIND5); 
//     else PORTB &= ~(1<<DATA_PIND5);

//     if(cmd & 0x40) PORTB |= (1<<DATA_PIND6); // set PB0 high
//     else PORTB &= ~(1<<DATA_PIND6); // set PB0 low

//     if(cmd & 0x80) PORTD |= (1<<DATA_PIND7);  // set PD7 high
//     else PORTD &= ~(1<<DATA_PIND7);  // set PD7 low

//     lcd_pulse();

//     // Send lower nibble
//     if(cmd & 0x01) PORTB |= (1<<DATA_PIND4);  
//     else PORTB &= ~(1<<DATA_PIND4); 

//     if(cmd & 0x02) PORTB |= (1<<DATA_PIND5); 
//     else PORTB &= ~(1<<DATA_PIND5); 

//     if(cmd & 0x04) PORTB |= (1<<DATA_PIND6); // set PB0 high
//     else PORTB &= ~(1<<DATA_PIND6); // set PB0 low

//     if(cmd & 0x08) PORTD |= (1<<DATA_PIND7);  // set PD7 high
//     else PORTD &= ~(1<<DATA_PIND7);  // set PD7 low

//     lcd_pulse();

// }

// void lcd_data(unsigned char data) {

// }

// void lcd_init() {
//     _delay_ms(200); // Wait for LCD to power up

//     // Initialize LCD in 4-bit mode
//     lcd_command(0x02); // Set to 4-bit mode -  00000010
//     lcd_command(0x28); // 2 line, 5x7 matrix -  00101000  
//     lcd_command(0x0C); // Display on, cursor off - 00001100
//     lcd_command(0x06); // Increment cursor - 00000110
//     lcd_command(0x01); // Clear display - 00000001
//     _delay_ms(200);

// }

// void lcd_print(char *str) {

// }

// int main(void) {
//     DDRB |= 0xFF; // Set PORTD as output for data pins
//     DDRD = (1 << DATA_PIND7); // Set PD7 as output for data pin

//     lcd_init();
// }








#include <avr/io.h>
#include <util/delay.h>

// LCD pin connections
#define RS PB4   // Arduino pin 12
#define EN PB3   // Arduino pin 11
#define D4 PB2   // Arduino pin 10
#define D5 PB1   // Arduino pin 9
#define D6 PB0   // Arduino pin 8
#define D7 PD7   // Arduino pin 7

void lcd_cmd(unsigned char cmd);
void lcd_data(unsigned char data);
void lcd_init();
void lcd_string(const char *str);
void lcd_pulse();

int main(void) {
    DDRB = 0xFF;    // Port B as output (RS, EN, D4-D6)
    DDRD |= (1<<PD7); // PD7 as output for D7

    lcd_init();

    lcd_cmd(0x80);              // First line, first position
    lcd_string("Hello, World!");

    lcd_cmd(0xC0);              // Second line
    lcd_string("LCD Working :)");

    while (1) {
        // Loop forever
    }
}

void lcd_pulse() {
    PORTB |= (1<<EN);
    _delay_us(1);
    PORTB &= ~(1<<EN);
    _delay_ms(2);
}

void lcd_cmd(unsigned char cmd) {
    PORTB &= ~(1<<RS); // RS=0 for command

    // Send high nibble
    if (cmd & 0x10) PORTB |= (1<<D4); else PORTB &= ~(1<<D4);
    if (cmd & 0x20) PORTB |= (1<<D5); else PORTB &= ~(1<<D5);
    if (cmd & 0x40) PORTB |= (1<<D6); else PORTB &= ~(1<<D6);
    if (cmd & 0x80) PORTD |= (1<<D7); else PORTD &= ~(1<<D7);
    lcd_pulse();

    // Send low nibble
    if (cmd & 0x01) PORTB |= (1<<D4); else PORTB &= ~(1<<D4);
    if (cmd & 0x02) PORTB |= (1<<D5); else PORTB &= ~(1<<D5);
    if (cmd & 0x04) PORTB |= (1<<D6); else PORTB &= ~(1<<D6);
    if (cmd & 0x08) PORTD |= (1<<D7); else PORTD &= ~(1<<D7);
    lcd_pulse();
}

void lcd_data(unsigned char data) {
    PORTB |= (1<<RS); // RS=1 for data

    // Send high nibble
    if (data & 0x10) PORTB |= (1<<D4); else PORTB &= ~(1<<D4);
    if (data & 0x20) PORTB |= (1<<D5); else PORTB &= ~(1<<D5);
    if (data & 0x40) PORTB |= (1<<D6); else PORTB &= ~(1<<D6);
    if (data & 0x80) PORTD |= (1<<D7); else PORTD &= ~(1<<D7);
    lcd_pulse();

    // Send low nibble
    if (data & 0x01) PORTB |= (1<<D4); else PORTB &= ~(1<<D4);
    if (data & 0x02) PORTB |= (1<<D5); else PORTB &= ~(1<<D5);
    if (data & 0x04) PORTB |= (1<<D6); else PORTB &= ~(1<<D6);
    if (data & 0x08) PORTD |= (1<<D7); else PORTD &= ~(1<<D7);
    lcd_pulse();
}

void lcd_init() {
    _delay_ms(20);       // Wait for LCD power on
    lcd_cmd(0x02);       // 4-bit mode
    lcd_cmd(0x28);       // 2 line, 5x7 matrix
    lcd_cmd(0x0C);       // Display on, cursor off
    lcd_cmd(0x06);       // Increment cursor
    lcd_cmd(0x01);       // Clear screen
    _delay_ms(2);
}

void lcd_string(const char *str) {
    while (*str) {
        lcd_data(*str++);
    }
}