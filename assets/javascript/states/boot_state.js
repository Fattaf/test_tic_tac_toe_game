function BootState() {};

BootState.prototype = {
  preload: function() {
    // load preloader assets
    console.log('BootState#preload');

    this.game.load.image('loading',       '/images/test_loading.gif');
    this.game.load.image('phaserjs_logo', '/images/test_phaser_logo.jpg');
  },

  create: function() {
    // setup game environment
    // scale, input etc..
    console.log('BootState#create');

    this.game.state.start('Preload');
  }
};
