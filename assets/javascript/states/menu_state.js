function MenuState() {};

MenuState.prototype = {
  button: null,

  create: function() {
    var posX = this.world.centerX,
        posY = this.world.centerY;
    this.button = this.add.button(posX, posY, 'startButton', this.actionOnClick, this, 1, 0);
    this.button.anchor.setTo(0.5, 0.5);
  },

  actionOnClick: function() {
    this.state.start('Connection');
  }

};
