var ChatMessage = React.createClass({
  componentWillMount: function () {

  },
  componentDidMount: function () {
    // TODO: Grab the last few messages
  },
  getInitialState: function () {
    return ({lastMessage: ""})
  },
  _sendMessage: function (body) {
    App.messages.perform('create_message', {body: body, room: this.props.room})
  },
  _clearInput: function () {
    if (document.getElementById('post-chat-input') != null) {
      document.getElementById('post-chat-input').value = "";
    }
  },
  _handlePress: function (event) {
    event.stopPropagation();
    if (event.key == 'Enter' || event.type == "click") {
      var toSend = document.getElementById('post-chat-input').value;
      this._sendMessage(toSend);
      // used to keep history and cause a re-render of the dom element
      this.setState({lastMessage: toSend});
    }
  },
  render: function () {
    this._clearInput();
    return (
        <div className="input-field">
          <input id="post-chat-input" name='post-chat' className="materialize-textarea focused"
                 placeholder="Say Something" ref="input-for-room"
                 onKeyDown={this._handlePress}
          />
          <button type="button" onClick={this._handlePress} className="btn waves-effect waves-light">
            Post!
          </button>
        </div>
    );

  }

});