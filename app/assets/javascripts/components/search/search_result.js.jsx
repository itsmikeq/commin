var SearchResult = React.createClass({
  getDefaultProps: function () {
    return ({userResults: [], postResults: [], roomResults: []})
  },
  getInitialState: function () {
    return ( {
      userResults: [],
      postResults: [],
      roomResults: []
    });
  },

  render: function () {
    var users = null;
    var posts = null;
    var rooms = null;

    if (this.props.userResults != undefined) {
      users = this.props.userResults.map(function (user) {
        return (<UserResult user={user} key={"user-" + user._id}/>);
      });
    }
    console.log("rendering posts");
    if (this.props.postResults != undefined) {
      return (<PostResult posts={this.props.postResults}/>);
    }
    if (this.props.roomResults != undefined) {
      rooms = this.props.roomResults.map(function (room) {
        return (<GroupResult room={room} key={"room-" + room._id}/>);
      });
    }
    console.log('posts: ',posts);
    return (
        <div className="search-results" key="search-results" parent={$('nav')}>
          <ul id="dropdown" className="dropdown-content collection">
            {posts}
            {users}
            {rooms}
          </ul>
        </div>
    );
  }
});