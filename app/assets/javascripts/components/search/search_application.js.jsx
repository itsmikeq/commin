var SearchApplication = React.createClass({
  getInitialState: function () {
    return ( {
      resultsData: [],
      results: []
    });
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
        console.log('resultsData:', data.table.data);
      }.bind(this),
      error: function (xhr, status, err) {
        $.snackbar({content: err.toString(), style: "toast", htmlAllowed: true, timeout: 2000});
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderResults: function (data) {
    var resultSet = [];
    data.forEach(function (data) {
      if (data._index == 'posts') {
        resultSet.push(data)
      }
    });
    // This does not work - will need to put into flux
    //var resultView = (
    //    <div className="results">
    //      <PostApplication posts={data._source}
    //                       callback={function(){}}
    //                       key={"post_" + data._id}
    //      />
    //    </div>
    //);
    //React.render(resultView, document.getElementById('posts'));
    //this.setState({results: resultView});
  },
  render: function () {
    return (
        <div>
          <div className="search animate-away">
            <div className="input-field">
              <form action={Routes.search_path({format: 'json'})} className="form" onSubmit={this.handleSubmit}>
                <input id="search" type="text" className="validate valign" placeholder="Search"/>
                <i className="fa fa-search fa-2x main-search animated">
                </i>
                <span className="highlight"></span>
              </form>
            </div>
          </div>
        </div>
    );
  }
});