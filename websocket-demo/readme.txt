This is a simple demonstration that showcases the power of ColdFusion WebSocket. This simple demo helps you get started with WebSocket. Feel free to make changes to this application and start playing with WebSocket.

The page loads initializes the WebSocket connection (at the client side) which enables the client to be ready to listen for a message from server.
In this code simple, first the subscribe and publish workflow have been explained in simple form and later by added cfcListener, an advance case,(step 4 as describbed below), the custom properties are used while subscribing to a channel and publishing the message to perform some task in CFCListener callbacks.



Procedure:
1. Extract the demo JAR to wwwroot.
2. Access the websocket.cfm file from your browser.
3. This CFM template has a subscribe button to subscribe to a channel and a publish button to publish a message to the registered channel. 
4. Once you are comfortable with initial concept, please comment the third line and uncomment the fourth line in application.cfc to check server-side callback invocation.
5. Check allowSubscribe, allowPublish and beforePublish callback function of 'stockChannelListner.cfc' .  


 
Contact:
Awdhesh Kumar
awdhesh@adobe.com
Adobe ColdFusion Team, India.
