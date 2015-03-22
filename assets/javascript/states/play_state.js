// FIXME ready message form opponent

function PlayState() {};

PlayState.prototype = {
  board: null,

  preload: function() {
    console.log('PlayState#preload');

    onMessage = function(msg) { console.log(msg.data) };
    SocketWrapper.onMessageHandler(onMessage);
  },

  create: function() {
    console.log('PlayState#create');

    this.board = this.add.group();
    this.makeBoard(this.board);
  },

  makeBoard: function(board) {
    for(var i = 1; i <= 3; i++) {
      for(var j = 1; j <= 3; j++) {
        var cell;
        cell = board.create(100*i, 100*j, 'item', 0);
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
  }

};
