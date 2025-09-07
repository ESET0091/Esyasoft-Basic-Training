#include <avr/io.h>
#include <util/delay.h>

#define LED_PIN PD4 // port D4 set to Led Pin
#define PUSH_BUTTON PD5  // port D5 set to Push Button

int main(void){
    DDRD |= (1 << LED_PIN);  //assigning DDRD as o/p register
    DDRD &= ~(1 << PUSH_BUTTON); //assigning DDRD as i/p register
    PORTD |= (1 << PUSH_BUTTON); 


    while(1){
     
      if(!(PIND & (1 << PUSH_BUTTON))){
          //LED ON 
          PORTD |= (1<< LED_PIN);
          //Delay 500ms
          _delay_ms(250);

          //LED OFF
          PORTD &= ~(1<< LED_PIN);
          _delay_ms(250);
      }
      
      else{
          PORTD &= ~(1<< LED_PIN); //LED OFF
      }
      
    }
    return 0;
}