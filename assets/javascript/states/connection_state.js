function ConnectionState() {};

ConnectionState.prototype = {
  outputText: null,

  create: function() {
    console.log('ConnectionState#create');

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

    var self = this;
    var onMessageEvent = function(message) {
      // FIXME: only for test. delete after.
      // console.log(message);

      var data = JSON.parse(message.data);
      self.addText(data.msg);
      if (data.status === 'success') { self.onSuccessEvent(); };
    };

    SocketWrapper.onMessageHandler(onMessageEvent);
  },

  onSuccessEvent: function() {
    this.state.start('Play');
  }
}
