var Post = React.createClass({
  propTypes: {
    body: React.PropTypes.string,
    user: React.PropTypes.object,
    reply_to_user: React.PropTypes.object,
    user_id: React.PropTypes.string,
    updated_at: React.PropTypes.string,
    reply_post_id: React.PropTypes.string,
    reply_posts: React.PropTypes.array
  },
  getInitialState: function () {
    return ({
      showResponse: false,
      posted: false,
      reply_posts: this.props.post.reply_posts || []
    })
  },
  _getChildrenFromApi: function () {
    var url = Routes.post_path({format: 'json', id: this.props.post.id}) + '?children=true';
    var self = this;
    $.ajax({
      url: url,
      success: function (data) {
        self.setState({reply_posts: data});
      },
      error: function (xhr, status, error) {
        $.snackbar({content: error, style: "toast", htmlAllowed: true, timeout: 2000});
      }
    });
  },
  componentWillMount: function(){
    this._getChildrenFromApi();
  },
  _setPosted: function (_state) {
    this.setState({posted: _state})
  },
  _hideResponse: function () {
    this.setState({showResponse: false})
  },
  _hidePost: function () {
    $('#post_' + this.props.post.id).hide();
  },
  _showResponse: function () {
    this.setState({showResponse: true})
  },
  _renderBody: function () {
    var htmlBody = this.props.post.body;
    return htmlBody.replace(/(^|\s)#([a-z\d-]+)/ig, "$1<a href='" + gon.tags_url_base + "/$2' class='hash_tag'>#$2</a>");
  },
  _deletePost: function () {
    var self = this;
    if (!confirm('are you sure you want to delete ' + this.props.post.id + '?')) {
      return false;
    }
    $.ajax({
      url: Routes.post_path({format: 'json', id: this.props.post.id}),
      method: 'delete',
      contentType: 'application/json',
      dataType: "json",
      success: function () {
        self._hidePost();
        //self._getChildrenFromApi();
      }, error: function (xhr, status, error) {
        $.snackbar({content: error, style: "error", htmlAllowed: true, timeout: 2000});
      }
    });
  },
  username: function () {
    try {
      return (gon.current_user.username);
    } catch (TypeError) {
      // user is not logged in
      return ("");
    }
  },
  _buildPostOptions: function () {
    if (this.username().length > 0) {
      return (
          <PostOptions handleDelete={this._deletePost} handleReply={this._showResponse}
                       canDelete={this.username() == this.props.post.username}/>
      );
    }
  },
  _appendToChildren: function(child){
    var children = this.state.reply_posts || [];
    children.push(child);
    this.state({reply_posts: children})
  },
  _render_responses: function () {
    if (this.state.reply_posts == undefined || this.state.reply_posts.length < 1) {
      return (null);
    }
    var _reply_posts = [];
    var self = this;
    this.state.reply_posts.forEach(
        function (reply_post) {
          _reply_posts.push(
              <Post post={reply_post}
                    callback={self._appendToChildren}
                    key={"reply_post_" + reply_post.id}
              />
          );
        }
    );
    return (_reply_posts);
  },
  render: function () {
    return (
        <div className="row post">
          <div id={'post_' + this.props.post.id} className="card">
            <div className="card-content">
              <div className="card-title text-darken-4 valign">
                <a href={"/posts/by/user/" + this.props.post.username}>@{this.props.post.username}</a>
                <Checkmark display={this.state.posted}/>
              </div>
              <h6 className="small">
                {this.props.post.updated_at}
              </h6>
              <PostBody body={this.props.post.body}/>
            </div>
            <div className="card-action">
              {this._buildPostOptions()}
            </div>
            <div className="responses">
              {this._render_responses()}
            </div>
          </div>
          {this.state.showResponse ?
              <PostResponse post={this.props.post}
                            hideMe={this._hideResponse}
                            setPosted={this._setPosted}
                            callback={this._getChildrenFromApi}/>
              : null
          }
        </div>
    )
  }
});
