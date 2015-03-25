function ConnectionState() {};

ConnectionState.prototype = {
  outputText: null,

  create: function() {
    this.outputText = null;
    this.addText('Connecting.');
    this.openSocketConn();
  },

  addText: function(message) {
    var posX = this.world.centerX,
        posY = this.world.centerY,
        style = { font: "22px Arial", fill: "#ff0044", align: "center" };

    if (this.outputText === null) {
      this.outputText = this.add.text(posX, posY, message, style);
      this.outputText.anchor.set(0.5);
    } else {
      this.outputText.text = message;
    };
  },

  openSocketConn: function() {
    SocketWrapper.openConnection();

    // FIXIME: refactoring, smells bad!
    var self = this;
    var onMessageEvent = function(message) {
      var data = JSON.parse(message.data);
      self.addText(data.msg);
      self.game.sleep(1000);

      if (data.status === 'success') { self.onSuccessEvent(data.state); };
    };

    SocketWrapper.onMessageHandler(onMessageEvent);
  },

  onSuccessEvent: function(state) {
    this.state.start('Play', true, false, state);
  }
}
