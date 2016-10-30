var Friend = React.createClass({
  componentDidMount: function () {

  },
  getInitialState: function () {
    return ({
      isFriend: this.props.isFriend,
      disabled: 'enabled'
    });
  },
  getDefaultProps: function () {
    // full: do we return all of the attributes, or is this part of another page
    return ({
      full: false
    })
  },
  extraRenderItems: function () {
    return (<p>TODO: Put a user's current groups/chats/etc.</p>);
  },
  addFriend: function (elem) {
    var self = this;
    $.ajax({
      type: 'POST',
      data: JSON.stringify({id: this.props.friend_id}),
      contentType: 'application/json',
      url: Routes.my_friends_path({format: 'json'}),
      success: function (data) {
        self.setState({
          isFriend: !self.state.isFriend,
          disabled: (self.state.disabled == 'enabled') ? 'disabled' : 'enabled'
        })
      },
      error: function (xhr, status, error) {
        console.log('error', error);
        $.snackbar({content: xhr.responseJSON.error, style: "toast", htmlAllowed: true, timeout: 2000});
      }
    })
  },
  classForStatus: function () {
    if (this.state.isFriend) {
      return ('fa fa-minus-circle fa-2x');
    }
    return ('fa fa-plus-circle fa-2x');
  },
  render: function () {
    return (
        <div className={"friend card-panel grey lighten-5 z-depth-1 " + this.state.disabled}>
          <div className="toggle-friend pull-right" onClick={this.addFriend}>
            <i className={this.classForStatus()}/>
          </div>
          <div className="row valign-wrapper">
            <div className="col s4">
              <img src={this.props.image_url} alt=""
                   className="circle responsive-img"/>
            </div>
            <div className="col s8">
              <span className="black-text">
                <p>TODO: Put a user's profile stuff here. Truncate to a couple lines</p>
                {this.props.full && this.extraRenderItems()}
              </span>
            </div>
          </div>
        </div>
    );
  }
});