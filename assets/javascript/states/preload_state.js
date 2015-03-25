function PreloadState() {};

PreloadState.prototype = {

  preload: function() {
    this.launchLoader();
    this.load.spritesheet('item', '/images/test_board1.png', 38, 38);
    this.load.spritesheet('startButton', '/images/button.png', 80, 30);
    this.load.spritesheet('finishButton', '/images/button_last.png', 80, 30);
    this.load.image('panel', '/images/panel.png');
  },

  create: function() {
    this.game.sleep(1000);
    this.state.start('Menu');
  },

  launchLoader: function() {
    var posX = this.world.centerX,
        posY = this.world.centerY;

    this.addImage(posX, posY);
    this.addText(posX, posY + 60);
  },

  addImage: function(posX, posY) {
    var frames = [],
        loading_sprite = this.add.sprite(posX, posY, 'loading');

    for(var i = 0; i < 19; i++) { frames.push(i); };
    loading_sprite.anchor.setTo(0.5,0.5);
    loading_sprite.animations.add('ani', frames, 10, true);
    loading_sprite.play('ani');
  },

  addText: function(posX, posY) {
    var style = { font: "28px Arial", fill: "#ff0044", align: "center" };
    var text = this.add.text(posX, posY, "Loading...", style);
    text.anchor.set(0.5);
  },

};
