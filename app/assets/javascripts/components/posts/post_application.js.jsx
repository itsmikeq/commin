var PostApplication = React.createClass({
  getInitialState: function () {
    return ({
      posts: []
    })
  },
  _getDataFromApi: function (_props) {
    console.log(_props);
    var url = this.props.posts_url + '.json';
    if (_props != undefined) {
      url = this.props.posts_url + '/' + _props.id + '.json'
    }
    var self = this;
    $.ajax({
      url: url,
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
    if (_posts.length > 0) {
      return (
          <div>
            <Search/>
            <div id="posts">
              {_posts}
            </div>
          </div>
      );
    } else {
      return (
          <div className="row">
            <div className="col s8">
              Nothing here... try looking for something
              <Search/>
            </div>
          </div>
      );
    }

  }
});