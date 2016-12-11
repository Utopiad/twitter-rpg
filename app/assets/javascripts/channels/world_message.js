App.world_message = App.cable.subscriptions.create("WorldMessageChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    $('#messages').append(data.message)
  },

  speak: function(message) {
    return this.perform('speak', {message: message});
  }
});


$(document).on('keypress', '#chat-speak', function(e) {
  if (event.keyCode == 13) {
    App.world_message.speak(event.target.value)
    e.target.value = ""
    e.preventDefault()
  } 
})