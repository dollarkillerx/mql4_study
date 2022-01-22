//+------------------------------------------------------------------+
//|                                                        demo1.mq4 |
//|                                 https://github.com/dollarkillerx |
//|                                 https://github.com/dollarkillerx |
//+------------------------------------------------------------------+
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
#property show_inputs


enum Week
  {
   M=1, // 星期一
   T=2, // 星期二
  };

input Week wk;  // 请选择星期
extern Week wk2;  // 请选择星期

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()  // 当加载EA时执行
  {
//---
   color d= Red;
   datetime e = D'22.01.2022';
   MessageBox(e,"a");
   Comment("这是在左上角的显示注释: ", "ea 加载上了");

   GlobalVariableSet("ok",0); // key val
   datetime o = TimeCurrent(); // 返回服务器时间
   MessageBox(o,"服务器时间");
   
   int a = 2123;
   int b = 214321;
   int c;
   add(a,b,c);
   MessageBox(c,"c");
   
   if (a > b) {
      MessageBox("a > b");
   }else {
      MessageBox("a < b");
   }
   
   int cp[10];
   for (int i=0;i<10;i++) {
      cp[i] = i +1;
   }
   
   
   MessageBox("OrderTotal: ", OrdersTotal()); //  OrdersTotal() 获取当前所有订单
   // while (OrdersTotal() > 0) {
      // 平仓
      
   // }
   
//---
   return(INIT_SUCCEEDED);
  }
  
  
  void add(int a, int b,int &result) {
     result = a + b;
  }
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)  // 当卸载EA时执行
  {
//---

   printf("在控制台打印: ", "ea 卸载了");

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()  // 每一次tick 挑动执行
  {
//---

  }
//+------------------------------------------------------------------+
