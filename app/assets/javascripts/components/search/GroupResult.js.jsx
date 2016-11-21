var GroupResult = React.createClass({
  getDefaultProps: function () {
    return ({groups: []})
  },
  getInitialState: function () {
    return ( {
      groups: []
    });
  },
  oneGroup: function (_group) {
    return (
        <li className="collection-item avatar">
          <img src="http://materializecss.com/images/yuna.jpg" alt="" className="circle"/>
          <span className="title">{_group.username}</span>
          <p>First Line</p>
          <a href="#!" className="secondary-content"><i className="material-icons">contact_mail</i></a>
        </li>

    );

  },
  render: function () {
    var _results = [];
    this.props.groups.map(function (_group) {
      _results.append(this.oneGroup(_group));
    });
    if (_results.length > 0) {
      return (_results);
    } else {
      return null;
    }
  }
});