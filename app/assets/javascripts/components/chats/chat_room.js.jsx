var ChatRoom = React.createClass({
  getInitialState: function () {
    return {
      cable: ActionCable.createConsumer(gon.ws_url),
      room: this.props.room,
      app: {},
      messages: []
    }
  },
  getDefaultProps: function () {
    return ({
      room: ""
    });
  },
  componentDidMount: function () {
    var self = this;
    // fixes race condition with action cable
    setTimeout(function () {
      self._connect();
      self._get_latest_messages()
    }, 500)
  },
  _leave: function () {
    this.state.app.unsubscribe();
    // remove the lingering tooltip 'cause materializecss can be dumb
    $('.material-tooltip').remove();
    $.snackbar({content: "Disconnected from " + this.props.room});
    this.props.reset('');
  },
  _get_latest_messages: function () {
    var self = this;
    var _messages = [];
    $.ajax({
      url: '/messages/latest.json?room=' + self.state.room,
      success: function (data) {
        $.each(data, function (i, d) {
          _messages.push(d);
        });
        self.setState({messages: _messages});
      },
      error: function (xhr, status, error) {
        $('#snackbar-error').snackbar({content: error, style: "toast", htmlAllowed: true, timeout: 2000});
      }
    });
  },
  _connect: function () {
    var self = this;
    var room = this.props.room;
    this.setState({
      app: this.state.cable.subscriptions.create({channel: "MessagesChannel", room: room}, {
        connected: function (data) {
          //Called when the subscription is ready for use on the server
          $.snackbar({content: "Connected to " + room});
          // TODO: clean these up to remove JQ
          $('.disabled').removeClass('disabled');
          document.getElementById('post-chat-input').removeAttribute('disabled')
          $('#chat-loading').hide()
        },
        disconnected: function () {
          // Called when the subscription has been terminated by the server
          // TODO: close chats window attached to the requested group
          $.snackbar({content: "Server has disconnected " + room});
        },
        received: function (data) {
          // TODO: prune some of the messages so we dont have a memory leak over time
          var _messages = self.state.messages;
          _messages.push(data);
          return (
              self.setState({messages: _messages})
          );
        }
      })
    });
  },
  render: function () {
    return (
        <div className="chat-room">
          <div id="messages" className="card-action">
            {this.state.messages.map(function (msg) {
              return (<ChatMessage message={msg} key={"message_" + msg.id}/>)
            })}
          </div>
          <div>
            <ChatPost room={this.props.room} messages={this.state.app}/>
          </div>
          <div className="row">
            <div className="chips right">
              <span> <b>Room: </b></span>
              <div className="tooltipped chip hoverable" data-position="bottom" data-delay="50" data-tooltip="Leave"
                   onClick={this._leave}>{this.props.room}
                <i className="material-icons close">close</i>
              </div>
            </div>
          </div>

        </div>
    );

  }
});
