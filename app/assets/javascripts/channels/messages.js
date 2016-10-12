var ConnectTo = function (room, appendId) {

  App.messages = App.cable.subscriptions.create({channel: "MessagesChannel", room: room}, {
    connected: function () {
      // put in a little delay due to race condition
      //setTimeout(this.perform('subscribed', {message_id: this.message_id}), 1000);
      // Called when the subscription is ready for use on the server
      console.log("Connected to " + room);
      $.snackbar({content: "Connected to " + room});
    },
    disconnected: function () {
      // Called when the subscription has been terminated by the server
      $.snackbar({content: "Disconnected from " + room});
      // TODO: close chats window attached to the requested group
    },
    received: function (data) {
      return document.getElementById(appendId).insertAdjacentHTML('beforeend', this.renderMessage(data));
    },
    renderMessage: function (data) {
      return "<p> <b>" + data.created_by + ": </b>" + data.body + "</p>";
    },
    subscribed: function () {
      // Do something, like create a div or something
    }
  });
};