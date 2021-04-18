class MockData {



    Map chatdata = {
      "name":"Nick",
      "messages":{
        "786123":{
          "senttime":"22:02-18-10-2020",
          "messagetype":"text",
          "service":"WhatApp",
          "content":"hello world",
          "userimg":"https://cache.pressmailing.net/content/943d7e45-be51-4b70-962c-388e2cb86c22/SodaStream_April_5.jpg"//will be added
        },
        "786124":{
          "senttime":"22:02-18-10-2020",
          "messagetype":"text",
          "service":"WhatApp",
          "content":"hello world",
          "userimg":""//will be added

        },
        "786125":{
          "senttime":"22:02-18-10-2020",
          "messagetype":"text",
          "service":"WhatApp",
          "content":"hello world",
          "userimg":""//will be added

        },
      }
    };

    Map getData (){
      return chatdata;
    }

    Map getMessages(){
      return chatdata["messages"];
    }

}