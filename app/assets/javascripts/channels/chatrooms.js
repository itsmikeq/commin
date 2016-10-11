this.App = {};

App.cable = ActionCable.createConsumer(gon.ws_url);