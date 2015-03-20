function MenuState() {};

MenuState.prototype = {
  button: null,

  create: function() {
    console.log('MenuState#preload');

    var posX = this.world.centerX,
        posY = this.world.centerY;
    this.button = this.add.button(posX, posY, 'startButton', this.actionOnClick, this);
    this.button.anchor.setTo(0.5, 0.5);
  },

  actionOnClick: function() {
    this.state.start('Play');
  }

};