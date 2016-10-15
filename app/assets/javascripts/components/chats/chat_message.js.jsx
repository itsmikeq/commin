//<span dangerouslySetInnerHTML={{__html: this.props.message.body}}/>

var ChatMessage = React.createClass({
  getDefaultProps: function () {
    return ({
      message: {}
    });
  },
  render: function () {
    return (
        <div className="chat-message">
          <span className="chat-username"><b>{this.props.message.created_by}: </b></span>
          <span className="chat-text">{this.props.message.body}</span>
        </div>
    );
  }
});