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
  render: function () {
    // Define room creation here
    // Render the base template
    return (
        <div>
          <div id="messages_header" className="card-title">
            Chat
          </div>
          <ChatRoom/>
          <div id="messages" className="card-action"></div>
        </div>

    )
  }
});