(function() {

  var game = new Phaser.Game(400, 400, Phaser.AUTO, 'TicTacToe');

  game.state.add('Boot', BootState);
  game.state.add('Preload', PreloadState);
  // game.state.add('MainMenu', Ball.MainMenu);
  game.state.add('Play', PlayState);

  game.state.start('Boot');

})();
