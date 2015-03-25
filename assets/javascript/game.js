(function() {
  // the game
  var game = new Phaser.Game(800, 800, Phaser.CANVAS, 'TicTacToe');

  game.state.add('Boot', BootState);
  game.state.add('Preload', PreloadState);
  game.state.add('Menu', MenuState);
  game.state.add('Connection', ConnectionState);
  game.state.add('Play', PlayState);
  game.state.add('Finish', FinishState);

  // TODO: add waiting state

  game.state.start('Boot');
})();
