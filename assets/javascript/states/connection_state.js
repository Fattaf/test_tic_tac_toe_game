function ConnectionState() {};

ConnectionState.prototype = {
  response: null,

  create: function() {
    console.log('ConnectionState#create');

    this.addText('Connecting.');
    this.openSocketConn();
  },

  addText: function(message) {
    var posX = this.world.centerX,
        posY = this.world.centerY,
        style = { font: "22px Arial", fill: "#ff0044", align: "center" };

    if (this.response === null) {
      this.response = this.add.text(posX, posY, message, style);
      this.response.anchor.set(0.5);
    } else {
      this.response.text = message;
    };
  },

  openSocketConn: function() {
    var self = this;
    socket = new WebSocket('ws://' + window.location.host + window.location.pathname);
    socket.onmessage = function(message) {
      self.addText(message.data);

      // TODO: refactoring

      if (message.data === 'Game found.') {
        self.onSuccessEvent();
      };
    };
  },

  onSuccessEvent: function() {
    this.state.start('Play');
  }
}
