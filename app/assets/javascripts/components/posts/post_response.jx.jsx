var PostResponse = React.createClass({
  propTypes: {
    body: React.PropTypes.string,
    user: React.PropTypes.object,
    reply_to_user: React.PropTypes.object,
    user_id: React.PropTypes.string,
    updated_at: React.PropTypes.string,
    reply_post_id: React.PropTypes.string
  },
  getInitialState: function () {
    return ({
      posted: false,
      formId: "reply_post_text_" + this.props.post.id
    })
  },
  componentWillUnMount: function() {
    $('.focused').off('keydown', this._handleKeyDown);
  },
  componentDidMount: function () {
    $('.focused').focus();
    $('.response').on('keydown', this._handleKeyDown);
    this.props['formId'] = "reply_post_text" + this.props.post.id;
  },
  _handleKeyDown: function(event) {
    if (event.keyCode == 13 /*enter*/) {
      // not sure if i should call this._submitResponse here or not
    }
    if (event.keyCode == 27 /*esc*/) {
      $(event.target).parents().find('.response').hide();
    }
  },
  _submitResponse: function () {
    // TODO: handle the reply post
    // Create the record
    // Show some feedback that the response has been registered
    var data = document.getElementById(this.state.formId).value;
    // at least 5 characters of response
    if (data.length < 5) {
      return false;
    }
    var self = this;
    $.ajax({
      url: '/posts.json',
      method: 'post',
      data: {id: this.props.post.id, "post[body]": data, "post[reply_post_id]": this.props.post.id},
      success: function (data) {
        // we get data back here - may be better to just append it to the dom
        self.props.hideMe();
        self.props.setPosted(true);
        self.props.callback(data);
      }, error: function (xhr, status, error) {
        $.snackbar({content: error, style: "error", htmlAllowed: true, timeout: 2000});
      }
    });
  },
  render: function () {
    var post = this.props.post;
    return (
        <div className="response">
          <i className="material-icons right clickable" onClick={this.props.hideMe}> close </i>
          <div className="card-title grey-text text-darken-4">
            <br/>
          </div>
          <div className="input-field">
            <i className="material-icons prefix">mode_edit</i>
            <label htmlFor={this.state.formId}>Reply</label>
            <input type="hidden" name="post[reply_post_id]" value={post.id}/>
            <textarea id={this.state.formId} name='post[body]' className="materialize-textarea focused"/>
            <button type="button" onClick={this._submitResponse} className="btn waves-effect waves-light">
              Post
            </button>
          </div>
        </div>
    );

  }
});