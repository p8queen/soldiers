//+------------------------------------------------------------------+
//|                                                     soldiers.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                          https://www.awtt.com.ar |
//+------------------------------------------------------------------+


#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property version   "1.00"
#property strict
//#include "soldiers.mqh"

string currency = "USDJPY";
double topPrice = 120;
double downPrice = 108;
double dblPrice;
int magicNumber = 1510;
double stopLoss = 400*Point;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   dblPrice = topPrice;
   while(dblPrice>=downPrice){
      setOrder(dblPrice);
      dblPrice -= 0.4;
      
      }

  return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){

   
      
}  

void setOrder(double price){
   int op;
   
   //OrderSend(currency,op,0.01,price,10,stopLoss,0,,magicNumber);
   if(price>Bid){
      //buystop and selllimit
      OrderSend(currency,OP_BUYSTOP,0.01,price,10,price-stopLoss,0,NULL,magicNumber);
      OrderSend(currency,OP_SELLLIMIT,0.01,price,10,price+stopLoss,0,NULL,magicNumber);
   }else{
      //sellstop and buylimit
      OrderSend(currency,OP_SELLSTOP,0.01,price,10,price+stopLoss,0,NULL,magicNumber);
      OrderSend(currency,OP_BUYLIMIT,0.01,price,10,price-stopLoss,0,NULL,magicNumber);
      }
   } 