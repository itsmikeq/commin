var Friend = React.createClass({
  componentDidMount: function () {

  },
  render: function () {
    return (
        <div className="card-panel grey lighten-5 z-depth-1">
          <div className="row valign-wrapper">
            <div className="col s4">
              <img src="https://dummyimage.com/200x200/d1cad1/fff.png&text=User+Face" alt=""
                   className="circle responsive-img"/>
            </div>
            <div className="col s8">
              <span className="black-text">
                TODO: Put a user's profile stuff here. Truncate to a couple lines
              </span>
            </div>
          </div>
        </div>
    );
  }
});