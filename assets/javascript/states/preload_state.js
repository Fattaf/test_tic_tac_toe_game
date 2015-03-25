function PreloadState() {};

PreloadState.prototype = {

  preload: function() {
    this.launchLoader();
    this.load.spritesheet('item', '/images/test_board1.png', 38, 38);
    this.load.spritesheet('startButton', '/images/css.png', 80, 30);
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
    var loading_sprite = this.add.sprite(posX, posY, 'loading');
    loading_sprite.anchor.setTo(0.5,0.5);
  },

  addText: function(posX, posY) {
    var style = { font: "24px Arial", fill: "#ff0044", align: "center" };
    var text = this.add.text(posX, posY, "Loading...", style);
    text.anchor.set(0.5);
  },

};
