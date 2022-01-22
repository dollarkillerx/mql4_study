# 获取K线数据


#### 获取当前K线数据
```
   double ask = Ask;
   double bid = Bid;
   double gbpUsdAsk = MarketInfo("GBPUSD", MODE_ASK);
   double gbpUsdBid = MarketInfo("GBPUSD",MODE_BID);

   printf("当前窗口 ASK： %f Bid %f ", ask, bid);
   printf("GBPUSD ASK： %f Bid %f", gbpUsdAsk, gbpUsdBid);


// K线 ：每根K线都有数据 最新的是0  依次是 0 1 2 3 4 5 6
   double op = Open[0];  // 最新K线 开盘价
   double hi = High[0];     // 最新K线 最高价
   double lo = Low[0];// 最新K线 最低价
   double clo = Close[0];// 最新K线 收盘价

// 获取跨周期货币对
   double open15m = iOpen(NULL,15,0); // 货币对名称(NULL 当前货币对), 周期(0 当前周期), K线序号
   printf("open15m: %f", open15m);

// 获取一个范围的最高最低价格的序号
   int highbar = iHighest(NULL,0,MODE_CLOSE,100,0); // 货币对,周期, 价格类型, 数量, 从那个序号开始
   printf("highbar: %d", highbar);
   
   // 调用系统指标
   double ma0 = iMA(NULL,0,20,0,MODE_EMA,PRICE_CLOSE,0); // 货币对, 货币周期, MA周期, MA平移, MA 移动平均, MA 价格计算方式, k线序号
   printf("ma0: %f", ma0);
   
```