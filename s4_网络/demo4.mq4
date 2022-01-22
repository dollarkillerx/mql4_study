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
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
// ここからテキストをjson形式に変換してWebリクエスト送信
   string data;
   string headers;
   char post[],result[];

// ヘッダー部分の作成
   headers = "Content-Type: application/json\r\n";

   data = "{\"content\":\"helloworld\"}";

   ArrayResize(post,StringToCharArray(data,post,0,WHOLE_ARRAY,CP_UTF8)-1);

   int respHttpCode = WebRequest("POST","http://127.0.0.1/v1/vp","Content-Type: application/json\r\n",1000,post,result,headers);
   printf("respHttpCode: %d",respHttpCode);
   string results = CharArrayToString(result);
   printf("result: %s",results);

   // JSON 参考: https://www.mql5.com/en/code/11134
   JSONParser *parser = new JSONParser();
   JSONValue *jv = parser.parse(results);
   if (jv != NULL) {
      if (jv.isObject()) {
         JSONObject *jo = jv;
         Print("firstName:" + jo.getString("firstName"));
      }
   }

//---
   return(INIT_SUCCEEDED);
  }
