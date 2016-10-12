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
      throw "Whoops";
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
  _connectRoom: function () {
    var room = document.getElementById('room-create-join').value;
    if (room == null) {
      return false;
    }
    this.setState({room: room});
    // Need to get some return worked out here
    return (true);

  },
  _leaveRoom: function(){
    // TODO: Leave a room, rerender
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
    // Define room creation here
    // Render the base template
    if (this.state.room == ""){
      return(this._selectRoom());
    } else {
      return (
          <div>
            <div id="messages_header" className="card-title">
              Chat
            </div>
            <div id="messages" className="card-action"></div>
            <ChatRoom room={this.state.room}/>
          </div>

      );
    }
  }
});