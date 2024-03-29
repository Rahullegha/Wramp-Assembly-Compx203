/**
 * Writes a character to a serial port.
 * Note: this function blocks.
 *
 * Parameters:
 *  c		The character to send
 *
 **/
void putc(char c);

/**
 * Writes a character to a serial port.
 * Note: this function blocks.
 *
 * Returns:
 *  		The character read from the serial port
 *
 **/
int getc();

/**
 * Writes a string to a serial port.
 * Note: this function blocks.
 *
 * Parameters:
 *  s		A pointer to the string to send
 *
 **/
void putstr(const char *s);

/**
 * Reads the value on the switches.
 *
 * Returns:
 *  		The current value of the switches.
 **/
int readswitches();

/**
 * Writes a number to the seven-segment displays, in decimal.
 *
 * Parameters:
 *  n		The number to write to the displays. Must be in range 0 <= n < 10000
 **/
void writessd(int n);

/**
 * Delays execution for a short while.
 **/
void delay();
