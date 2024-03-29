//+------------------------------------------------------------------+
//|                                                      monitor.mq4 |
//|                                                    Dollarkillerx |
//|                                 https://github.com/dollarkillerx |
//+------------------------------------------------------------------+
#property strict
#property show_inputs

input string serverAddr = "http://127.0.0.1/api/mql/v1/inform"; // 服务器地址
input int timer = 200; // 消息汇报时间

#include "hash.mqh"
#include "json.mqh"
#include "user.mqh"

User user();

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   Comment("Moitor 服务监控程序 (https://github.com/dollarkillerx) Server: ",serverAddr);

//--- create timer
   EventSetMillisecondTimer(timer);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

  }

double gPercentage = 0;
double gMargin = 0;
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
   printf("当前账户可用保证金: %f 账户杠杆: %d 账户已用保证金: %f \n",AccountFreeMargin(),AccountLeverage(),AccountMargin());


   string data;
   string headers;
   char post[],result[];
   headers = "Content-Type: application/json\r\n";

   double balance = AccountBalance(); // 余额
   double profit = AccountProfit();   // 利润
   double percentage = profit/balance; // 浮亏/浮盈 比例
   double margin = AccountMargin(); // 已用保证金



   if(percentage < gPercentage || margin > gMargin)
     {

      data = StringFormat("{\"user\": %d, \"balance\": %f, \"profit\": %f, \"percentage\": %f, \"server\": \"%s\", \"leverage\": %d, \"margin\": %f}",user.account,balance,profit,percentage,user.server,AccountLeverage(),margin);
      ArrayResize(post,StringToCharArray(data,post,0,WHOLE_ARRAY,CP_UTF8)-1);

      int respHttpCode = WebRequest("POST",serverAddr,"Content-Type: application/json\r\n token: helloworld\r\n",1000,post,result,headers);
      if(respHttpCode != 200)
        {
         string results = CharArrayToString(result);
         printf("错误信息: %s",results);
        }

      gPercentage = percentage;
      gMargin = margin;
     }


  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
