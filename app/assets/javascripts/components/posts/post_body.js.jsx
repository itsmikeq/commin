var PostBody = React.createClass({
  propTypes: {
    body: React.PropTypes.string
  },
  render: function () {
    var htmlBody = this.props.body;
    if (htmlBody == undefined) {
      return(null);
    }
    htmlBody = htmlBody.replace(/(^|\s)#([a-z\d-]+)/ig, "$1<a href='" + gon.tags_url_base + "/$2' className='hashtag'>#$2</a>")
    return (
        <p className="card-text">
          <span dangerouslySetInnerHTML={{__html: htmlBody}} />
        </p>
    );
  }
});