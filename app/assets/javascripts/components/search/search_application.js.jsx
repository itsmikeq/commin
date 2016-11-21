var SearchApplication = React.createClass({
  getInitialState: function () {
    return ( {
      resultsData: [],
      results: [],
      userResults: [],
      postResults: [],
      roomResults: []
    });
  },
  componentDidMount: function () {
  },

  handleSubmit: function (e) {
    e.persist();
    e.preventDefault();

    var query = $(e.target).find('input').val();
    console.log(e);
    $.ajax({
      url: e.target.action + '?query=' + query,
      dataType: 'json',
      cache: false,
      success: function (data) {
        this.renderResults(data.table.data);
        //console.log('resultsData:', data.table.data);
        $('#search').dropdown({
              inDuration: 300,
              outDuration: 225,
              belowOrigin: true, // Displays dropdown below the button
              alignment: 'right' // Displays dropdown with edge aligned to the left of button
            }
        );
      }.bind(this),
      error: function (xhr, status, err) {
        $.snackbar({content: err.toString(), style: "toast", htmlAllowed: true, timeout: 2000});
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  _cleanResults: function (res) {
    if (res.length < 1) {
      return null;
    } else {
      return res;
    }
  },
  renderResults: function (data) {
    var resultSet = {users: [], posts: [], rooms: []};
    data.forEach(function (data) {
      if (data._index == 'posts') {
        resultSet.posts.push(data)
      } else if (data._index == 'users') {
        resultSet.users.push(data)
      } else if (data._index == 'rooms') {
        resultSet.rooms.push(data)
      }
    });
    console.log("Setting state");
    this.setState({
      userResults: this._cleanResults(resultSet.users),
      postResults: this._cleanResults(resultSet.posts),
      roomResults: this._cleanResults(resultSet.rooms)
    });
  },
  render: function () {
    console.log("rendering");
    return (
        <div>
          <div className="search animate-away" data-activates="dropdown" data-beloworigin="true">
            <div className="input-field">
              <form action={Routes.search_path({format: 'json'})} className="form" onSubmit={this.handleSubmit}>
                <input id="search" type="text" className="validate valign" placeholder="Search"/>
                <i className="fa fa-search fa-2x main-search animated">
                </i>
                <span className="highlight"></span>
              </form>
            </div>
          </div>
          <div className="search-results">
            <SearchResult userResults={this.state.userResults} postResults={this.state.postResults}
                          roomResults={this.state.roomResults}/>, document.body
          </div>
        </div>
    );
  }
});