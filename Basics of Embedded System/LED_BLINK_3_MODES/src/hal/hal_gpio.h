#ifndef HAL_GPIO
#include <avr/io.h>
#include <util/delay.h>


void hal_gpio_init();
int hal_gpio_button_read();
void hal_gpio_digital_write();

#endif