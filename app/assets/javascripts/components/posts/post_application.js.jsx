var PostApplication = React.createClass({
  getInitialState: function () {
    return ({
      posts: []
    })
  },
  _getDataFromApi: function () {
    var self = this;
    $.ajax({
      url: this.props.posts_url + '.json',
      success: function (data) {
        self.setState({posts: data});
      },
      error: function (xhr, status, error) {
        $('#snackbar-error').snackbar({content: error, style: "toast", htmlAllowed: true, timeout: 2000});
      }
    });
  },
  componentDidMount: function () {
    this._getDataFromApi();
  },
  render: function () {
    _posts = [];
    var self = this;
    this.state.posts.forEach(
        function (post) {
          _posts.push(<
              Post post={post}
                   callback={self._getDataFromApi}
                   key={"post_" + post.id}
          />);
        }
    );
    return (
        <div id="posts">
          {_posts}
        </div>
    );
  }
});