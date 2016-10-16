var ChatPost = React.createClass({
  componentWillMount: function () {

  },
  componentDidMount: function () {
    $('.tooltipped').tooltip();
  },
  getInitialState: function () {
    return ({lastMessage: ""})
  },
  _sendMessage: function (body) {
    this.props.messages.perform('create_message', {body: body, room: this.props.room})
  },
  _clearInput: function () {
    if (document.getElementById('post-chat-input') != null) {
      document.getElementById('post-chat-input').value = "";
    }
  },
  _handlePress: function (event) {
    event.stopPropagation();
  },
  _handleClick: function (event) {
    event.stopPropagation();
    var toSend = document.getElementById('post-chat-input').value;
    this._sendMessage(toSend);
    // used to keep history and cause a re-render of the dom element
    this.setState({lastMessage: toSend});
    document.getElementById('post-chat-input').focus();
    document.getElementById('post-chat-input').removeAttribute('disabled');
    // I think this timeout is needed because the entire thing is rerendered every post... may want to change
    setTimeout(function () {
      document.getElementById('messages').scrollTo(0, document.body.scrollHeight)
    }, 200);
  },
  render: function () {
    this._clearInput();
    return (
        <div className="chat-messages">
          <div className="input-field m5">
            <input disabled id="post-chat-input" name='post-chat' type="text"
                   ref="input-for-room"
                   onKeyDown={this._handlePress}
            />
            <label htmlFor="post-chat-input">
              Say Something
            </label>
          </div>
          <button type="button" onClick={this._handleClick} className="btn waves-effect waves-light disabled">
            <div id="chat-loading">
              <i className="fa fa-loader fa-spinner fa-spin"/>
              Connecting
            </div>
            Post!
          </button>
        </div>
    );

  }

});