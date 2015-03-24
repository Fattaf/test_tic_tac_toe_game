var Board = function(game) {
  Phaser.Group.call(this, game);

  this.init = function() {
    for(var i = 0; i < 20; i++) {
      for(var j = 0; j < 20; j++) {
        var cell = this.create(100*i, 100*j, 'item', 0);
        this.addCellData(cell, i, j);
        this.addCellEvents(cell);
      }
    };

    this.onPause();
  };

  this.addCellData = function(cell, i, j) {
    cell.name = 'cell_' + i + '_' + j;
    cell.pos_x = i;
    cell.pos_y = j;
  };

  this.addCellEvents = function(cell) {
    cell.inputEnabled = true;
    cell.events.onInputDown.add(this.onDownAction, this);
    cell.events.onInputOver.add(this.onNarrowAction, this);
    cell.events.onInputOut.add(this.onUnNarrowAction, this);
  };

  this.onUnNarrowAction = function(cell) {
    cell.frame = 0;
  };

  this.onNarrowAction = function(cell) {
    cell.frame = 1;
  };

  this.onDownAction = function(cell) {
    cell.frame = 2;
    cell.events.destroy();

    this.onPause();

    // FIXME: refactoring. smells bad!!!
    var message = { status: 'move', pos_x: cell.pos_x, pos_y: cell.pos_y };
    SocketWrapper.sendMessage(JSON.stringify(message));
  };

  this.handleMessage = function(message) {
    console.log('---')
    console.log(msg);

    var data = JSON.parse(message.data);

    if (data.status === 'finish') { return data; };

    this.onPlay();

    if (data.status === 'move') { this.markCell(data); };

    return true;
  };

  this.markCell = function(data) {
    var name = 'cell_' + data.pos_x + '_' + data.pos_y;
    var children = this.children;

    for (i in children) {
      if (children[i].name === name) {
        children[i].frame = 3;
        children[i].events.destroy();
        break;
      };
    };
  };

  this.onPause = function() {
    for (i in this.children) {
      this.children[i].inputEnabled = false;
    };
    console.log('pause');
  };

  this.onPlay = function() {
    for (i in this.children) {
      this.children[i].inputEnabled = true;
    };
    console.log('play');
  };

};

Board.prototype = Object.create(Phaser.Group.prototype);
Board.prototype.constructor = Board;
