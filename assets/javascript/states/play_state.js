function PlayState() {};

PlayState.prototype = {
  board: null,

  create: function() {
    console.log('PlayState#create');

    this.board = this.add.group();
    this.makeBoard(this.board);
  },

  makeBoard: function(board) {
    for(var i = 1; i <= 5; i++) {
      for(var j = 1; j <= 5; j++) {
        var cell;
        cell = board.create(100*i, 100*j, 'item', 0);
        cell.name = 'cell' + i + j;
        cell.inputEnabled = true;
        // FIXME: only while test
        // cell.input.enableDrag();
        cell.events.onInputDown.add(this.onDownAction, cell);
      }
    };
  },

  onDownAction: function(cell) {
    console.log('clicked');

    cell.setFrames(1);
  }

};
