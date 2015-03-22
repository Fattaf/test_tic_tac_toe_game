(function() {
  // the game
  var game = new Phaser.Game(400, 400, Phaser.CANVAS, 'TicTacToe');

  game.state.add('Boot', BootState);
  game.state.add('Preload', PreloadState);
  game.state.add('Menu', MenuState);
  game.state.add('Connection', ConnectionState);
  game.state.add('Play', PlayState);

  // TODO: add waiting state
  // TODO: add game over state
  game.state.start('Boot');
})();
