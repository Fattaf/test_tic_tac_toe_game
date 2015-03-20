function BootState() {};

BootState.prototype = {

  preload: function() {
    console.log('BootState#preload');

    this.load.image('loading', '/images/test_loading1.jpg');
    this.stage.backgroundColor = '#ffffff';
  },

  create: function() {
    console.log('BootState#create');

    this.state.start('Preload');
  }

};
