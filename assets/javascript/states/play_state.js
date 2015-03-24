function PlayState() {};

PlayState.prototype = {
  board: null,

  init: function(state) {
    this.board = new Board(this.game);
    this.board.init();
    if (state === 'pause') { this.board.onPause(); };
  },

  create: function() {

    // FIXIME: refactoring, smells bad!
    var self = this;
    var onMessageEvent = function(msg) {
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
