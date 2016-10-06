var Button = React.createClass({
  propTypes: {
    buttonStyle: React.PropTypes.string,
    handleClick: function(){},
    label: React.PropTypes.string
  },
  render: function () {
    return (
        <button
            className="btn waves-effect waves-light"
            style={this.props.buttonStyle}
            onClick={this.props.handleClick}>{this.props.label}</button>
    );
  }
});