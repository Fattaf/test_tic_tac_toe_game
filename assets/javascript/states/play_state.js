function PlayState() {};

PlayState.prototype = {
  board: null,

  // preload: function() {
  //   console.log('PlayState#preload');
  // },

  create: function() {
    console.log('PlayState#create');
    var self = this;
    this.board = this.add.group();
    this.makeBoard();


    onMessage = function(msg) {
      var board = self.board;
      self.findCell(msg.data, board);
    };
    SocketWrapper.onMessageHandler(onMessage);
  },

  makeBoard: function() {
    for(var i = 1; i <= 3; i++) {
      for(var j = 1; j <= 3; j++) {
        var cell;
        cell = this.board.create(100*i, 100*j, 'item', 0);
        cell.name = 'cell' + i + j;

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

    SocketWrapper.sendMessage(this.name);

    this.frame = 2;
    this.events.destroy();
  },

  findCell: function(name, board) {
    console.log(name);
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
