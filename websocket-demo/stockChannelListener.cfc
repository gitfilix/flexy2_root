component extends="CFIDE.websocket.ChannelListener"
{

     /**
    * Invoked before you subscribe to a channel/subchannel. Used to check whether the requested
    * client should be allowed to subscribe to the given channel. Properties defined in the object susbcriberInfo can be used to take the authorization decision.
    * @param subscriberInfo: A struct that contains custom options passed in subscribe request. Also contains the object ConnectionInfo  
    *     as subkey 'connectionInfo'. 
    * @return a boolean value. If true, allows the requested client to subscribe.
    */   
    public any function allowSubscribe(Struct subscriberInfo)
    {
        // overwrite this function to check for permissoin.
        // Here permission is being granted to all the clients elder than 18 years.
        if(subscriberInfo.age > 18)
             return true;  // Grant permission to subscribe
        else
             return false; // Deny permission to subscribe			
    }
    
    /**
    * Invoked before publishing on a channel/subchannel. Used to check whether the requested
    * client should be allowed to publish on the given channel. Properties defined in the object publisherInfo can be used to take the authorization decision
    * @param publisherInfo: A struct that contains custom options passed in the publish request. Also contains the object ConnectionInfo  
    *     as subkey 'connectionInfo'. 
    * @return a boolean value. If true, allows the requested client to publish the message.
    */   
    public any function allowPublish(Struct publisherInfo)
      {
        //A person from SFO only can publish.
        // Here publishing permission is being granted to all the clients from San Fancisco.
        if(publisherInfo.city eq 'SFO')
             return true;  // Grant permission to publish
        else
             return false; // Deny permission to publish			
      }
    
    
  /**
    * Invoked before publishing the given message on requested channel/subchannel. Used to execute a business logic if required and to format messages.
    * @param message: The message object that needs to be published. 
    * @param publisherInfo: A struct that contains custom options passed in the publish request. Also contains the object ConnectionInfo  
    *     as subkey 'connectionInfo'. 
    * @return message: The message object that needs to be published after formating the original message if required.  
    */   
    public any function beforePublish(any message, Struct publisherInfo)
    {
        //Adding published time information to the message object.
        //If the message is struct then add the time information as a key otherwise append it as string.
        if(isStruct(message)
           message.publishedAt = now(); 	
        else
           message = message+"publihsedAt:" +now();// String append.        				
    }
    
  /**
    * Invoked before sending the message to a subscribed client. Used to decide whether the message should be sent to a specific client or not.
    * This function is called for all clients subscribed to a channel separately. Properties defined in the object subscriberInfo and 
    * publisherInfo can help in finding client's interest in the message.
    * @param message: The message object that needs to be published. 
    * @param subscriberInfo: A struct that contains custom options passed in the subscribe request. Also contains the object ConnectionInfo  
    *     as subkey 'connectionInfo'. 
    * @param publisherInfo: A struct that contains custom options passed in the publish request. Also contains the object ConnectionInfo  
    *     as subkey 'connectionInfo'. 
    * @return a boolean value: If true, sends the message to the specific client.
    */   
    public any function canSendMessage(any message, Struct subscriberInfo, Struct publisherInfo)
    {
        // A check can be added here, based on subscriberInfo to decide 
        // whether the individual client is interested in listenening for this perticular message.
        // By default client is ineterested and hence return true.
        
        return true;       				
    }

  /**
    * Invoked before sending the message to a subscribed client. Can be used to format the message as per client requirement prior to sending.
    * @param message: The message object that needs to be published. 
    * @param subscriberInfo: A struct that contains custom options passed in the subscribe request. Also contains the object ConnectionInfo  
    *     as subkey 'connectionInfo'. 
    * @return message: The message object that is returned.  
    */       
    public any function beforeSendMessage(any message, Struct subscriberInfo)
    {
        //Invoked before sending the message to a subscribed client. 
        // Can be used to format the message as per client requirement prior to sending.
        // By default don't do anything and return the original message as it is.
        
        return message;       				
    }
    
    
  
}
