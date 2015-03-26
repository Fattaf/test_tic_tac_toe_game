var PausePanel = function(game){
  Phaser.Group.call(this, game);

  this.init = function() {
    this.x = 0;
    this.y = -100;

    var posX = this.game.world.centerX,
        style = { font: "22px Arial", fill: "#ff0044", align: "center" };

    // Add the panel
    this.panel = this.create(posX, 50, 'panel');
    this.panel.anchor.setTo(0.5, 0);
    // Add text
    this.pauseText = this.game.add.text(posX, 60, 'Opponent Move...', style);
    this.pauseText.anchor.setTo(0.5, 0);

    this.add(this.pauseText);
  };

  this.show = function() {
    this.game.add.tween(this).to({y:0}, 1000, Phaser.Easing.Bounce.Out, true);
  };
  this.hide = function() {
    this.game.add.tween(this).to({y:-100}, 200, Phaser.Easing.Linear.NONE, true);
  };
};

PausePanel.prototype = Object.create(Phaser.Group.prototype);
PausePanel.constructor = PausePanel;
