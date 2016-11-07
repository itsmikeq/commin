var PostApplication = React.createClass({
  getInitialState: function () {
    return ({
      posts: this.props.posts
    })
  },
  getDefaultProps: function () {
    return ({posts: []})
  },
  _getDataFromApi: function (_props) {
    var self = this;
    PostsApi.getDataFromApi({
      callback: function (data) {
        self.setState({posts: data})
      }
    })
  },
  componentDidMount: function () {
    if (this.props.posts.length < 1) {
      this._getDataFromApi();
    } else {
      this.setState({posts: this.props.posts})
    }
  },
  render: function () {
    console.log('posts', this.props.posts);

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
            <div id="posts">
              {_posts}
            </div>
          </div>
      );
    } else {
      return (
          <div className="row">
            <div className="col m8 s12 center-align">
              <i className="fa fa-circle-o-notch fa-spin fa-3x"/>
            </div>
          </div>
      );
    }

  }
});