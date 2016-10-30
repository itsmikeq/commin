var Friend = React.createClass({
  componentDidMount: function () {

  },
  render: function () {
    return (
        <div className="card-panel grey lighten-5 z-depth-1">
          <div className="row valign-wrapper">
            <div className="col s4">
              <img src={this.props.image_url} alt=""
                   className="circle responsive-img"/>
            </div>
            <div className="col s8">
              <span className="black-text">
                <p>TODO: Put a user's profile stuff here. Truncate to a couple lines</p>
                <p>TODO: Put a user's current groups/chats/etc.</p>
              </span>
            </div>
          </div>
        </div>
    );
  }
});