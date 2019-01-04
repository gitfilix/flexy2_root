<cfwebsocket name='webSocketObj' onMessage='messageHandler'           
             onError='errorHandler' onOpen='openHandler' subscribeTo='chat' />
             
<script>
// All calback functions are listed here.
	
	var messageHandler = function(message)
	{
		var messageData = ColdFusion.JSON.encode(message);
		var txt=document.getElementById("outputDiv");
		txt.innerHTML = txt.innerHTML + messageData + "<br>";
	}

	var errorHandler = function(errorMessage)
	{
		var messageData = ColdFusion.JSON.encode(errorMessage);
		var txt=document.getElementById("outputDiv");
		messageData = "Error Occured:" + messageData;
		txt.innerHTML = txt.innerHTML + messageData + "<br>";
	}
	
	var openHandler = function()
	{
		var txt=document.getElementById("outputDiv");
		var messageData = "WebSocket connection opened Successfully.";
		txt.innerHTML = txt.innerHTML + messageData + "<br>";
		
	}

</script>


<script>
// Various JavaScript functions for send/receive message to server.

	var subscribeMe= function()
	{
		ch = document.getElementById("channelname").value;
		condnchckbox=document.getElementById("conditions");

		if (!condnchckbox.checked) {
			webSocketObj.subscribe(ch);
		}
		else{
			age_value = document.getElementById("age").value;
			minPrice_value = document.getElementById("minPrice").value;
			scriptName_value = document.getElementById("ScriptName").value;
			
			webSocketObj.subscribe(ch, {age: age_value, minPrice:minPrice_value, scriptName:scriptName_value});
		}			
	}


	var publishMessage= function()
	{
		channelName = document.getElementById("publishchannel").value;
	    script_value = document.getElementById("scriptName_publish").value;
		price_value = document.getElementById("Price").value;
		
		var messageToPublish =  {scriptName: script_value, price: price_value};
		
		condnchckbox=document.getElementById("publishConditions");

		if (!condnchckbox.checked) {
			webSocketObj.publish(channelName, messageToPublish);
		}
		else{
			publishedBy_value = document.getElementById("publishedBy").value;
			cityvalue = document.getElementById("city").value;			
			webSocketObj.publish(ch, messageToPublish, {city: city_value, publishedBy:publishedBy_value});
		}			
	}
	
	var closeSocket = function()
	{
		webSocketObj.closeConnection();
		var txt = document.getElementById("outputDiv");
		txt.innerHTML= txt.innerHTML + "<br> Socket closed";
	}
	

	var clearAll = function()
	{
		var txt=document.getElementById("outputDiv");
	    txt.innerHTML= "";
	}
	
</script>



<br><input  id="Clear" type="button" value="Clear" width="600" onclick="clearAll();">
<input  id="Clear" type="button" value="close" width="600" onclick="closeSocket();"><br>

<br> <b>Subscribe to: </b> <br>
Channel Name: <input  id="channelname" name="channelname" type="text" value="stocks" >
<input  id="stocksSubscribe" type="button" value="stocksSubscribe" onclick="subscribeMe();">

<br> <b> Subscribe condition:</b> 
<input  id="conditions" name="conditions" type="checkbox" > <br>
Age: <input  id="age" name="age" type="text" >
Script Name<input  id="ScriptName" name="Script Name" type="text" >
Minimun Price:<input  id="minPrice" name="Min Price" type="text" >


<br><br> <br> <b> Publish : </b><br>
Channrel Name:<input  id="publishchannel" name="Channel Name" type="text" value="stocks" >
Script Name: <input  id="scriptName_publish" name="Script Name" type="text" >
Price: <input  id="Price" name="Price" type="text" >
<input  id="stockspublish" type="button" value=" Publish " onclick="publishMessage();">

<br> <b>Publish condition: </b>
<input  id="publishConditions" name="publishConditions" type="checkbox" ><br>
Publish By: <input  id="publishedBy" name="publishedBy" type="text" >
City: <input  id="city" name="From City" type="text">

<br><br><br>
<div id="outputDiv"></div>  



           