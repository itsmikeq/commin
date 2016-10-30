var FriendsApplication = React.createClass({
  getInitialState: function () {
    return ( {
      friends: []
    });
  },
  getInitialProps: function(){
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
    this.state.friends.map((friend)=> {
      _rFriends.push(<Friend image_url={friend.profile_picture.url}
                             username={friend.username}
                             key={friend.id}
                             full={this.props.full}
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