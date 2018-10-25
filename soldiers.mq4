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

//currency = "USDJPY";
string currency = Symbol();
double topPrice,downPrice,dblPrice;
int magicNumber = 1810;
double stopLoss = 500*Point;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   dblPrice = Ask;
   OrderSend(currency,OP_BUY,0.01,Ask,10,dblPrice-stopLoss,0,NULL,magicNumber);
   OrderSend(currency,OP_SELL,0.01,Bid,10,dblPrice+stopLoss,0,NULL,magicNumber);
   
   topPrice = dblPrice + 4*stopLoss;
   downPrice = dblPrice + stopLoss;
   setInitialOrdes(topPrice,downPrice);
   
   topPrice = dblPrice - stopLoss;
   downPrice = dblPrice - 4*stopLoss;
   setInitialOrdes(topPrice,downPrice);

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

   //setPendingOrder();
   //Sleep(500);
      
}  


/////////////////
//****************
//////////////////

void setInitialOrdes(double highPrice, double lowPrice){
   dblPrice = highPrice;
   while(dblPrice>=lowPrice){
      setOrder(dblPrice);
      dblPrice -= 0.5;
      
      }
   

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
   
 void setPendingOrder(){
   //search nearest price
   int order_a, order_b;
   double order_price_a;
   order_a = -1;
   order_b = -1;
   
   int i=OrdersTotal()-1;
   while(i>=0){
      OrderSelect(i,SELECT_BY_POS);
      //check how far is Bid from OrderPrice and 
      //search for the nearest one.
      if(MathAbs(OrderOpenPrice()-Bid)<(stopLoss/2)){
         if(order_a==-1){
            order_a = OrderType();
            order_price_a = OrderOpenPrice();
         }else{
            if(order_b==-1){
               order_b = OrderType();
               i=-1; //exit
            }
         }
   
      }
      
      i--;
      }
      
    //set pending orders  
    if(order_b==-1){
      if(order_a==OP_BUY && Bid<order_price_a)
         OrderSend(currency,OP_SELLLIMIT,0.01,order_price_a,10,order_price_a+stopLoss,0,NULL,magicNumber);
      if(order_a==OP_SELL && Bid<order_price_a)
         OrderSend(currency,OP_BUYSTOP,0.01,order_price_a,10,order_price_a-stopLoss,0,NULL,magicNumber);
      if(order_a==OP_BUY && Bid>order_price_a)
         OrderSend(currency,OP_SELLSTOP,0.01,order_price_a,10,order_price_a+stopLoss,0,NULL,magicNumber);
      if(order_a==OP_SELL && Bid>order_price_a)
         OrderSend(currency,OP_BUYLIMIT,0.01,order_price_a,10,order_price_a-stopLoss,0,NULL,magicNumber);
         
      
      }
 
   }
   