var UserResult = React.createClass({
  getDefaultProps: function () {
    return ({users: []})
  },
  getInitialState: function () {
    return ( {
      users: []
    });
  },
  oneUser: function (_user) {
    return (
        <li className="collection-item avatar">
          <img src="http://materializecss.com/images/yuna.jpg" alt="" className="circle"/>
          <span className="title">{_user.username}</span>
          <p>First Line</p>
          <a href="#!" className="secondary-content"><i className="material-icons">contact_mail</i></a>
        </li>

    );

  },
  render: function () {
    var _results = [];
    this.props.users.map(function (_user) {
      _results.append(this.oneUser(_user));
    });
    if (_results.length > 0) {
      return (_results);
    } else {
      return null;
    }
  }
});