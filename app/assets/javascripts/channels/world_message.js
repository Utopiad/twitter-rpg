$(document).ready(function() {
  var world_id = $('#world_id').html()
  
  App.world_message = App.cable.subscriptions.create({channel: "WorldMessageChannel", world_id: world_id}, {
    connected: function() {
      // Called when the subscription is ready for use on the server
    },

    disconnected: function() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      var character_id = $('#character_id').html() * 1;
      $('#messages').prepend(data.message);
      if (data.characters != undefined) {
        if (data.characters.indexOf(character_id) != -1) {
          $('#current_life').replaceWith('<span id="current_life">' + data.updated_life[character_id] + '</span>')
        }
      }
    },

    speak: function(message, event_id, character_id, world_id) {
      return this.perform('speak', {message: message, event_id: event_id, 
        character_id: character_id, world_id: world_id});
    }
  });


  $(document).on('keypress', '#chat-speak', function(e) {
    var event_id = $('#event_id').html()
    var character_id = $('#character_id').html()
    if (event.keyCode == 13) {
      App.world_message.speak(event.target.value, event_id, character_id, world_id)
      e.target.value = ""
      e.preventDefault()
    } 
  })
  $("#chat-speak").parents('form').find('.bottom input').click(function(e) {
    var event_id = $('#event_id').html()
    var character_id = $('#character_id').html()
    var world_id = $('#world_id').html()
    var message = $('#chat-speak').val()
    $('#chat-speak')[0].value = "";
    App.world_message.speak(message, event_id, character_id, world_id)
    e.preventDefault()
  })
})