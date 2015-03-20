(function() {

  var game = new Phaser.Game(400, 400, Phaser.AUTO, 'TicTacToe');

  game.state.add('Boot', BootState);
  game.state.add('Preload', PreloadState);
  game.state.add('Menu', MenuState);
  game.state.add('Play', PlayState);

  // TODO: add waiting state
  // TODO: add game over state

  game.state.start('Boot');

})();
