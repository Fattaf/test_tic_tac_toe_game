(function() {
  var game = new Phaser.Game(1000, 850, Phaser.CANVAS, 'TicTacToe');

  game.state.add('Boot', BootState);
  game.state.add('Preload', PreloadState);
  game.state.add('Menu', MenuState);
  game.state.add('Connection', ConnectionState);
  game.state.add('Play', PlayState);
  game.state.add('Finish', FinishState);

  game.state.start('Boot');
})();
