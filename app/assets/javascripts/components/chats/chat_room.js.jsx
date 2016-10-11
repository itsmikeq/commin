var ChatRoom = React.createClass({
  getInitialState: function () {
    return {
      room: ""
    }
  },
  componentDidMount: function () {
  },
  _connectRoom: function () {
    var room = document.getElementById('room-create-join').value;
    if (room == null) {
      return false;
    }
    this.setState({room: room});
    // Need to get some return worked out here
    return (true);

  },
  _handleClick: function (event) {
    event.stopPropagation();
    event.nativeEvent.stopImmediatePropagation();
    event.preventDefault();
    if (!this._connectRoom()) {
      throw "Whoops";
    } else {
      console.log("Connected from click");
    }
  },
  _showSnackConnected: function () {
    $.snackbar({content: "Connected to " + this.state.room});
  },
  _handlePress: function (event) {
    event.stopPropagation();
    //event.nativeEvent.stopImmediatePropagation();
    if (event.key == 'Enter') {
      this._connectRoom();
    }
  },
  _selectRoom: function () {
    return (
        <div className="input-field">
          <input id="room-create-join" name='room-create-join' className="materialize-textarea focused"
                 placeholder="Create Room" ref="input-for-room"
                 onKeyDown={this._handlePress}
          />
          <button type="button" onClick={this._handleClick} className="btn waves-effect waves-light">
            Create!
          </button>

        </div>
    )
  },
  render: function () {
    var message = "";
    if (this.state.room != "") {
      new ConnectTo(this.state.room, 'messages');
      this._showSnackConnected();
    }

    if (this.state.room) {
      message = (
          <div>
            {this._selectRoom()}
            Connected Room: {this.state.room}
            <div>
              <ChatMessage room={this.state.room}/>
            </div>
          </div>
      );

    } else {
      message = (
          this._selectRoom()
      );
    }
    return (message)
  }
});
