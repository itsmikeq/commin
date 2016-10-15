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
    if (event.type == "click") {
      var toSend = document.getElementById('post-chat-input').value;
      this._sendMessage(toSend);
      // used to keep history and cause a re-render of the dom element
      this.setState({lastMessage: toSend});
      document.getElementById('post-chat-input').focus();
      document.getElementById('post-chat-input').removeAttribute('disabled')
    }
  },
  render: function () {
    this._clearInput();
    return (
        <div className="chat-messages">
          <div className="input-field">
            <textarea disabled id="post-chat-input" name='post-chat' className="materialize-textarea"
                      ref="input-for-room"
                      onKeyDown={this._handlePress}
            />
            <label htmlFor="post-chat-input">
              Say Something
            </label>
            <button type="button" onClick={this._handlePress} className="btn waves-effect waves-light disabled">
              <div id="chat-loading">
                <i className="fa fa-loader fa-spinner fa-spin"/>
                Loading
              </div>
              Post!
            </button>
          </div>
        </div>
    );

  }

});