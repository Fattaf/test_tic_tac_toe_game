function BootState() {};

BootState.prototype = {

  preload: function() {
    this.load.image('loading', '/images/test_loading1.jpg');
    this.stage.backgroundColor = '#ffffff';
  },

  create: function() {
    this.state.start('Preload');
  }

};
