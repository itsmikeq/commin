var PostResult = React.createClass({
  getDefaultProps: function () {
    return ({posts: []})
  },
  getInitialState: function () {
    return ( {
      posts: []
    });
  },
  _onePost: function (_post) {
    return (
        <li className="collection-item" key={"post-" + _post._id}>
          <span className="title">{_post.title}</span>
          <p>First Line</p>
          <a href="#!" className="secondary-content"><i className="material-icons">contact_mail</i></a>
        </li>
    );
  },
  render: function () {
    var self = this;
    var _results = this.props.posts.map(function (_post) {
      return self._onePost(_post);
    });
    if (_results.length > 0) {
      console.log('returning posts from render');
      return (<div key={"posts-results" + _results.length}>{_results}</div>);
    }else{
      console.log('returning null from render');
      return null;
    }
  }

});