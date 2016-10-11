var ConnectTo = function (room) {
  var id = function () {
    console.log("Getting ID");
    if (gon.current_user) {
      console.log(gon.current_user.id);
      return (gon.current_user.id);
    }
  }();

  App.messages = App.cable.subscriptions.create({channel: "MessagesChannel", room: room}, {
    connected: function () {
      // put in a little delay due to race condition
      //setTimeout(this.perform('subscribed', {message_id: this.message_id}), 1000);
      // Called when the subscription is ready for use on the server
      console.log("Connected");
      // TODO: open up a chat window attached to the requested group
    },
    disconnected: function () {
      // Called when the subscription has been terminated by the server
      console.log("DISConnected");
      // TODO: close chat window attached to the requested group
    },
    received: function (data) {
      console.log("Got something");
      console.log(data);
      //$("#messages").removeClass('hidden');
      return $('#messages').append(this.renderMessage(data));
    },
    renderMessage: function (data) {
      return "<p> <b>" + data.created_by + ": </b>" + data.body + "</p>";
    },
    subscribed: function () {
      // Do something, like create a div or something
    }
  });
};