var Checkmark = React.createClass({
  getInitialState: function () {
    return ({
      displayed: false
    })
  },
  _handleClick: function () {
    this.setState({displayed: true})
  },
  render: function () {
    // a bit jankey but this hides after click
    if (!this.props.display && !this.state.displayed) {
      return (null);
    } else if (this.state.displayed) {
      return (null);
    }
    return (
        <div className="valign-wrapper">
          <div onClick={this._handleClick} style={{height: '36px'}} className="valign center-align">
            <svg className="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
              <circle className="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
              <path className="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
            </svg>
          </div>
        </div>
    )
  }
});