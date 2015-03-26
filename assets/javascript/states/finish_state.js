function FinishState() {};

FinishState.prototype = {
  outputText: null,

  init: function(message) {
    this.outputText = message;
  },

  create: function() {
    var posX = this.world.centerX,
        posY = this.world.centerY,
        style = { font: "28px Arial", fill: "#ff0044", align: "center" };

    this.addText(posX, posY, style);
    this.addButton(posX, posY, style);
  },

  actionOnClick: function() {
    this.state.start('Menu');
  },

  addButton: function(posX, posY, style) {
    var button = this.add.button(posX, posY, 'finishButton', this.actionOnClick, this, 1, 0);
    button.anchor.setTo(0.5, 0.1);
  },

  addText: function(posX, posY, style) {
    var text = this.add.text(posX, posY - 50, this.outputText, style);
    text.anchor.set(0.5, 0.5);
  }

}
