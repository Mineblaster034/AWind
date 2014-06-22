/*
  AWind.h - Arduino window library support for Color TFT LCD Boards
  Copyright (C)2014 Andrei Degtiarev. All right reserved
  

  You can always find the latest version of the library at 
  https://github.com/AndreiDegtiarev/AWind


  This library is free software; you can redistribute it and/or
  modify it under the terms of the CC BY-NC-SA 3.0 license.
  Please see the included documents for further information.

  Commercial use of this library requires you to buy a license that
  will allow commercial use. This includes using the library,
  modified or not, as a tool to sell products.

  The license applies to all part of the library including the 
  examples and tools supplied with the library.
*/
#include "UTFT.h"
#include "Window.h"

bool Window::IsOfType(const __FlashStringHelper * type)
{
	const char PROGMEM *t1 = (const char PROGMEM *)_type;
	const char PROGMEM *t2 = (const char PROGMEM *)type;
	unsigned int length1=strlen_P(t1);
	if(length1==strlen_P(t2))
	{
		unsigned int i=0;
		for(;i<length1;i++)
		{
			if(pgm_read_byte(t1++)!=pgm_read_byte(t2++))
				return false;

		}
		return i==length1;
	}
	return false;
}
