
App.chat = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {
    console.log('connected to the Channel');
    
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
    console.log('disconnected from the Channel');
  },

  received: function(data) {
    
    // Called when there's incoming data on the websocket for this channel
    var messages = $('#messages');
    messages.append(data['message']);
    
  },
});