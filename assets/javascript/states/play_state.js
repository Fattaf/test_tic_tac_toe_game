function PlayState() {};

PlayState.prototype = {
  board: null,

  create: function() {
    this.board = new Board(this.game);
    this.board.init();


    // FIXIME: refactoring, smells bad!
    var self = this;
    var onMessageEvent = function(msg) {
      console.log(msg);

      var result = self.board.handleMessage(msg);
      if (result !== true) { self.onFinish(result.msg) };
    };

    SocketWrapper.onMessageHandler(onMessageEvent);
  },

  onFinish: function(message) {
    SocketWrapper.closeConnection();

    this.state.start('Finish', true, false, message);
  },

};
