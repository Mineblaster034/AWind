/*
This file is part of AWind library

Copyright (c) 2014-2018 Andrei Degtiarev

Licensed under the Apache License, Version 2.0 (the "License"); you
may not use this file except in compliance with the License.  You may
obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied.  See the License for the specific language governing
permissions and limitations under the License.
*/
#include "DC_UTFT.h"
#include "TouchUTFT.h"

#include "Log.h"
#include "Environment.h"
#include "WindowsManager.h"
#include "Dialog1.h"
#include "Dialog2.h"
#include "Dialogs.h"

// Setup TFT display + touch (see UTFT and UTouch library documentation)
#ifdef _VARIANT_ARDUINO_DUE_X_   //DUE +tft shield
UTFT    myGLCD(CTE32,25,26,27,28);
URTouch  myTouch(6,5,32,3,2);
#else
UTFT    myGLCD(ITDB32S,39,41,43,45);
URTouch  myTouch( 49, 51, 53, 50, 52);
#endif

DC_UTFT dc(&myGLCD);
TouchUTFT touch(&myTouch);

//manager which is responsible for window updating process
WindowsManager<Dialogs> windowsManager(&dc,&touch);


void setup()
{
	//setup log (out is wrap about Serial class)
	out.begin(9600);
	out<<F("Setup")<<endln;

	//initialize display
	myGLCD.InitLCD();
	myGLCD.clrScr();
	//initialize touch
	myTouch.InitTouch();
	myTouch.setPrecision(PREC_MEDIUM);
	//my speciality I have connected LED-A display pin to the pin 47 on Arduino board. Comment next two lines if the example from UTFT library runs without any problems 
	//pinMode(47,OUTPUT);
	//digitalWrite(47,HIGH);

	DC_UTFT::RegisterDefaultFonts();
	//Initialize appearance. Create your own DefaultDecorators class if you would like different application look
	DefaultDecorators::InitAll();
	//initialize window manager
	windowsManager.Initialize();

	//create and register dialogs
	windowsManager.MainWnd()->Initialize(); 
	Dialog1 *dlg1=new Dialog1(F("Number 1"),20,40,255,150);
	Dialog2 *dlg2=new Dialog2(F("Number 2"),30,50,210,115);
	windowsManager.MainWnd()->RegisterDialog(F("Dialog1"),dlg1);
	windowsManager.MainWnd()->RegisterDialog(F("Dialog2"),dlg2);

	delay(1000); 
	out<<F("End setup")<<endln;

}

void loop()
{
	//give window manager an opportunity to update display
	windowsManager.loop();
}