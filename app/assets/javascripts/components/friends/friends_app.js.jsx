var FriendsApplication = React.createClass({
  getInitialState: function () {
    return ( {
      friends: []
    });
  },
  getDefaultProps: function(){
    return({full: false})
  },
  componentDidMount: function () {
    this._getFriends()
  },
  _getFriends: function () {
    var url = Routes.my_friends_path({format: 'json'});
    var self = this;
    $.ajax({
      url: url,
      success: function (data) {
        self.setState({friends: data});
      },
      error: function (xhr, status, error) {
        $.snackbar({content: xhr.responseJSON.error, style: "toast", htmlAllowed: true, timeout: 2000});
      }
    });
  },
  render: function() {
    var _rFriends = [];
    self = this;
    this.state.friends.map(function(friend) {
      _rFriends.push(<Friend image_url={friend.profile_picture_url}
                             username={friend.username}
                             key={friend.id}
                             full={self.props.full}
                             friend_id={friend.id}
                             isFriend={true}
      />);
    });
    return (
        <div>
          {_rFriends}
        </div>
    );
  }
});