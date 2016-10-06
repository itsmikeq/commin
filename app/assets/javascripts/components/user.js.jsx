var User = React.createClass({
  propTypes: {
    username: React.PropTypes.string
  },

  render: function() {
    return(<div>{this.props.user.username}</div>);
  }
});
