var ChatRoom = React.createClass({
  getInitialState: function () {
    return {
      room: ""
    }
  },
  componentDidMount: function () {
    new ConnectTo(this.props.room, 'messages');
  },
  render: function () {
    return (
        <div>
          <div>
            <ChatMessage room={this.props.room}/>
            Connected Room: {this.props.room}
          </div>
        </div>
    );

  }
});
