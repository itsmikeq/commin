var ChatApplication = React.createClass({
  componentWillMount: function () {

  },
  componentDidMount: function () {
  },
  getInitialState: function () {
    return {
      room: ''
    }
  },
  _handleClick: function (event) {
    event.stopPropagation();
    event.nativeEvent.stopImmediatePropagation();
    event.preventDefault();
    if (!this._connectRoom()) {
      throw new Error("Whoops - unable to connect");
    }
  },
  _handlePress: function (event) {
    event.stopPropagation();
    //event.nativeEvent.stopImmediatePropagation();
    if (event.key == 'Enter') {
      this._connectRoom();
    }
  },
  _connectRoom: function () {
    // Get rid of spaces
    var room = document.getElementById('room-create-join').value.replace(/\s+/g, '');
    if (room == null) {
      return false;
    }
    this.setState({room: room});
    // Need to get some return worked out here
    return (true);
  },
  _reset: function (_room) {
    this.setState({room: _room})
  },
  _selectRoom: function () {
    return (
        <div className="input-field">
          <input id="room-create-join" name='room-create-join'
                 placeholder="Create Room" ref="input-for-room"
                 onKeyDown={this._handlePress}
          />
          <button type="button" onClick={this._handleClick} className="btn waves-effect waves-light">
            Join!
          </button>
        </div>
    )
  },

  render: function () {
    if (this.state.room == "") {
      return (
          <div className="chat-app">
            {this._selectRoom()}
          </div>
      );
    } else {
      return (
          <div className="chat-app">
            <ChatRoom room={this.state.room} reset={this._reset}/>
          </div>

      );
    }
  }
});