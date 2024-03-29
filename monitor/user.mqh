//+------------------------------------------------------------------+
//|                                                         user.mqh |
//|                                                    Dollarkillerx |
//|                                 https://github.com/dollarkillerx |
//+------------------------------------------------------------------+
#property copyright "Dollarkillerx"
#property link      "https://github.com/dollarkillerx"
#property strict

// 用户基础信息
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

//+------------------------------------------------------------------+
