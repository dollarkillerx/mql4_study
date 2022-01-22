# 初探EA

#### 基础下单
```
// 开单
// 开单价格, 开单方向, 下单手数, 开单价格, 最大允许滑点数,止损,止盈, 注释, 订单识别码, 挂单有效期, 订单颜色
   int r = OrderSend(Symbol(), OP_BUY,0.1,Ask, 100, Ask - 10000 * Point, Ask + 10000 * Point, "注释",666,0,clrMediumSeaGreen);
   if(r == -1)
     {
      printf("ErrorCode: %d",GetLastError());
     }

```

#### 获取所有订单信息

```
   for(int i=0; i<OrdersTotal(); i++)
     {
      // OrderSelect 选择一个订单
      if(OrderSelect(i,SELECT_BY_POS)==true)
        {
         int ticket = OrderTicket(); // 选中订单ID
         double op = OrderOpenPrice(); // 开单价格
         double sp = OrderStopLoss(); // 止损
         double zy = OrderTakeProfit(); // 止盈
         double magic = OrderMagicNumber(); // 魔术号码
         double comment = OrderComment(); // 注释
         double lots = OrderLots(); // 手数
         printf("订单: %d 开单价格: %f 止损: %f 止盈: %f magic: %d comment: %s lots: %f", ticket,op,sp,zy,magic,comment,lots);
        }
     }
```

### 订单管理

```
//+------------------------------------------------------------------+
//|    Buy 下单函数
//|    double lots, double sl,double tp,string com,int magic
//|    货币,下单手数, 止损, 止盈, 注释, magic
//+------------------------------------------------------------------+
int Buy(string symbol,double lots, double sl,double tp,string com,int magic)
  {

   bool exist = false;
   for(int i=0; i<OrdersTotal(); i++)
     {
      // OrderSelect 选择一个订单
      if(OrderSelect(i,SELECT_BY_POS)==true)
        {
         double _magic = OrderMagicNumber(); // 魔术号码
         string _comment = OrderComment(); // 注释
         if(_magic == magic && _comment == com && OrderSymbol() == Symbol() && OrderType() == OP_BUY)
           {
            exist = true;
           }
        }
     }

   if(exist == true)
     {
      return 0;
     }


// 开单价格, 开单方向, 下单手数, 开单价格, 最大允许滑点数,止损,止盈, 注释, 订单识别码, 挂单有效期, 订单颜色
   int r = OrderSend(symbol, OP_BUY,lots,Ask, 100, sl, tp, com,magic,0,clrMediumSeaGreen);

   return r;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|    Sell 下单函数
//|    double lots, double sl,double tp,string com,int magic
//|    货币,下单手数, 止损, 止盈, 注释, magic
//+------------------------------------------------------------------+
int Sell(string symbol,double lots, double sl,double tp,string com,int magic)
  {

   bool exist = false;
   for(int i=0; i<OrdersTotal(); i++)
     {
      // OrderSelect 选择一个订单
      if(OrderSelect(i,SELECT_BY_POS)==true)
        {
         double _magic = OrderMagicNumber(); // 魔术号码
         string _comment = OrderComment(); // 注释
         if(_magic == magic && _comment == com && OrderSymbol() == Symbol() && OrderType() == OP_SELL)
           {
            exist = true;
           }
        }
     }

   if(exist == true)
     {
      return 0;
     }


// 开单价格, 开单方向, 下单手数, 开单价格, 最大允许滑点数,止损,止盈, 注释, 订单识别码, 挂单有效期, 订单颜色
   int r = OrderSend(symbol, OP_SELL,lots,Bid, 100, sl, tp, com,magic,0,clrMediumSeaGreen);

   return r;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|  Close(orderType string,string comment,int magic)
//|  方向,注释, magic
//+------------------------------------------------------------------+
bool Close(int orderType,string comment,int magic)
  {
   int total = OrdersTotal();
   for(int i=total-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS) == true)
        {
         double _magic = OrderMagicNumber(); // 魔术号码
         string _comment = OrderComment(); // 注释
         if(comment == _comment && magic == _magic && OrderType() == orderType)
           {
            // 订单ID，平仓手数, 平仓价格, 滑点, 颜色
            return OrderClose(OrderTicket(), OrderLots(),OrderClosePrice(),5000, Green);
           }
        }
     }

   return true;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|   CloseAll(int magic)
//|   关闭所有订单 (如果magic 为 0 就关闭所有订单)
//+------------------------------------------------------------------+
void CloseAll(int magic)
  {
   int total = OrdersTotal();
   for(int i=total-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS) == true)
        {
         double _magic = OrderMagicNumber(); // 魔术号码
         if(magic != 0)
           {
            if(magic != _magic)
              {
               continue;
              }
           }

         // 订单ID，平仓手数, 平仓价格, 滑点, 颜色
         bool c = OrderClose(OrderTicket(), OrderLots(),OrderClosePrice(),5000, Green);
        }
     }

     if (OrdersTotal() != 0) {
         CloseAll(magic);
     }
     
  }
//+------------------------------------------------------------------+

```