//+------------------------------------------------------------------+
//|                                                        Demo1.mq4 |
//|                                 https://github.com/dollarkillerx |
//|                                 https://github.com/dollarkillerx |
//+------------------------------------------------------------------+
#property copyright "https://github.com/dollarkillerx"
#property link      "https://github.com/dollarkillerx"
#property version   "1.00"
#property strict


#include "hash.mqh"
#include "json.mqh"

// User 用户信息
class User
  {
public:
   int               account;  // 账户ID
   string            name;  // 账户名称
   string            company; // 账户经纪商
   string            server;  // 用户链接服务器
   bool              isDemo; // 是否是演示账户
   double            equity;  // 账户净值
   string            currency; // 账户货币
   double            freeMargin; // 可用保证金
   double            balance; // 余额
   int               leverage; // 当前账户杠杆
   double            profit; // 当前利润

                     User()
     {
      account = AccountNumber();
      name = AccountName();
      company = AccountCompany();
      equity = AccountEquity();
      currency = AccountCurrency();
      freeMargin = AccountFreeMargin();
      leverage = AccountLeverage();
      profit = AccountProfit();
      server = AccountServer();
      balance = AccountBalance();
      isDemo = IsDemo();
     }
  };

// CurrencyInformation 货币信息
class CurrencyInformation
  {
public:
   double            vpoint; // 一个点价格 5 报价点数
   int               digits; // 获取报价有多少个小数
   int               vspread; // 点差
   int               stopLevel; // 止损点数  最少离当前市价 多少点
   int               lotsize; // 一手的价格
   double            tickValue; // 一手波动一点的盈亏价格
   bool              tradeAllowed; // 是否可以交易
   double            minLot; // 最小下单量
   double            marginRequired; // 一手所需保证金

                     CurrencyInformation(string symbol)
     {
      vpoint = NormalizeDouble(MarketInfo(symbol, MODE_POINT),6);
      digits = (int)MarketInfo(symbol, MODE_DIGITS);
      vspread = (int)MarketInfo(symbol,MODE_SPREAD);
      stopLevel = (int)MarketInfo(symbol,MODE_STOPLEVEL);
      lotsize = (int)MarketInfo(symbol,MODE_LOTSIZE);
      tickValue = MarketInfo(symbol,MODE_TICKVALUE);
      tradeAllowed =  MarketInfo(symbol,MODE_TRADEALLOWED);
      minLot = MarketInfo(symbol,MODE_MINLOT);
      marginRequired = MarketInfo(symbol,MODE_MARGINREQUIRED);
     }
  };

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   User u();
   printf("account: %d name: %s company: %s equity: %f currency: %s freeMargin: %f leverage: %d profit: %f server: %s balance: %f isDemo: %d",u.account,u.name,u.company,u.equity,u.currency,u.freeMargin,u.leverage,u.profit,u.server,u.balance,u.isDemo);
//---
   CurrencyInformation ci(Symbol());
   printf("vpoint: %f digits: %d stopLevel: %d lotsize：%d tickValue: %f tradeAllowed： %d minLot：%f marginRequired： %f",ci.vpoint,ci.digits,ci.stopLevel,ci.lotsize,ci.tickValue,ci.tradeAllowed,ci.minLot);
   if(ci.vpoint==0.01)
     {
      printf("true");
     }
   return(INIT_SUCCEEDED);
  }
