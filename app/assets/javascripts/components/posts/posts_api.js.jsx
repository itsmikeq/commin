var PostsApi = {
  data: {},
  getDataFromApi: function (props) {
    var url = Routes.posts_path({format: 'json'});
    if (props.id != undefined) {
      url = Routes.post_path({format: 'json', id: props.id})
    }
    $.ajax({
      url: url,
      success: function (data) {
        if (props.callback != undefined && typeof(props.callback) == "function") {
          props.callback(data)
        } else {
          this.data = data;
        }
      }.bind(this),
      error: function (xhr, status, error) {
        $.snackbar({content: error, style: "toast", htmlAllowed: true, timeout: 2000});
      }
    });
  }
};