function PlayState() {};

PlayState.prototype = {
  board: null,

  init: function(state) {
    this.board = new Board(this.game, this.onMessageSend);
    this.board.init(100, 25);

    // FIXME : bug connected
    if (state === 'play') {
      this.board.onPlay();
    } else {
      this.board.onPause();
    };
  },

  create: function() {
    var self = this;
    SocketWrapper.onMessageHandler(function(msg) {
      var result = self.board.handleMessage(msg);
      if (result !== true) { self.onFinish(result.msg) };
    });
  },

  onFinish: function(message) {
    SocketWrapper.closeConnection();
    this.state.start('Finish', true, false, message);
  }

};
