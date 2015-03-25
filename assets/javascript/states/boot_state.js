function BootState() {};

BootState.prototype = {

  preload: function() {
    this.load.image('loading', '/images/test_loading.png');
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
