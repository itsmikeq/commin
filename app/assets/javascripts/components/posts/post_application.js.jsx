var PostApplication = React.createClass({
  getInitialState: function () {
    return ({
      posts: []
    })
  },
  _getDataFromApi: function (_props) {
    console.log(_props);
    var url = Routes.posts_path({format: 'json'});
    if (_props != undefined) {
      url = Routes.post_path({format: 'json', id: _props.id})
    }
    var self = this;
    $.ajax({
      url: url,
      success: function (data) {
        self.setState({posts: data});
      },
      error: function (xhr, status, error) {
        $.snackbar({content: error, style: "toast", htmlAllowed: true, timeout: 2000});
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