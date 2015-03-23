function PlayState() {};

PlayState.prototype = {
  board: null,

  create: function() {
    // console.log('PlayState#create');

    var self = this;
    this.board = this.add.group();
    this.makeBoard();

    var onMessageEvent = function(msg) {
      var data = JSON.parse(msg.data);
      var board = self.board;

      if (data.status === 'finish') {
        self.onFinish(data.msg)
      } else {
        self.findCell(data, board);
      };
    };

    SocketWrapper.onMessageHandler(onMessageEvent);
  },

  makeBoard: function() {
    for(var i = 0; i < 20; i++) {
      for(var j = 0; j < 20; j++) {
        var cell;
        cell = this.board.create(100*i, 100*j, 'item', 0);
        cell.name = 'cell_' + i + '_' + j;

        cell.inputEnabled = true;
        cell.events.onInputDown.add(this.onDownAction, cell);
        cell.events.onInputOver.add(this.onNarrowAction, cell);
        cell.events.onInputOut.add(this.onUnNarrowAction, cell);
      }
    };
  },

  onUnNarrowAction: function() {
    this.frame = 0;
  },

  onNarrowAction: function() {
    this.frame = 1;
  },

  onDownAction: function() {
    console.log('clicked');

    var res = this.name.match(/(\d+)_(\d+)/)
    var message = JSON.stringify({ status: 'move', pos_x: res[1], pos_y: res[2] })

    SocketWrapper.sendMessage(message);

    this.frame = 2;
    this.events.destroy();
  },

  onFinish: function(message) {
    SocketWrapper.closeConnection();
    this.state.start('Finish', true, false, message);
  },

  findCell: function(data, board) {
    var name = 'cell_' + data.pos_x + '_' + data.pos_y;
    var children = board.children;

    for (i in children) {
      if (children[i].name === name) {

        children[i].frame = 3;
        children[i].events.destroy();

        break;
      };
    };
  }

};
