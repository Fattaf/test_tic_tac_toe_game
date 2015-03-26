function BootState() {};

BootState.prototype = {

  preload: function() {
    // this.load.image('loading', '/images/test_loading.png');
    this.load.spritesheet('loading', '/images/images1.png', 33.3, 33);
    this.stage.backgroundColor = '#ffffff';

    this.game.sleep = function(ms) {
      ms += new Date().getTime();
      while (new Date() < ms){}
    }
  },

  create: function() {
    this.state.start('Preload');
  }

};
