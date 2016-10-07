var PostOptions = React.createClass({
  _buildDelete: function () {
    if (this.props.canDelete) {
      return (
          <li>
            <a className="btn-floating blue">
              <i className="material-icons" onClick={this.props.handleDelete}>delete</i>
            </a>
          </li>
      )
    } else {
      return (null)
    }
  },
  render: function () {
    return (
        <div className="valign-wrapper post-button-list">
          <ul className="valign">
            <li>
              <a className="btn btn-floating btn-reply" onClick={this.props.handleReply}>
                <i className="fa fa-reply"/>
              </a>
            </li>
            {
              this._buildDelete()
            }
          </ul>
        </div>
    );
  }
});