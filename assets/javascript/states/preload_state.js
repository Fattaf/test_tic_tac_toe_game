function PreloadState() {};

PreloadState.prototype = {

  preload: function() {

    this.launchLoader();
    this.load.image('startButton', '/images/test_play.png')
    this.load.spritesheet('item', '/images/test_board1.png', 38, 38);

    // FIXME: for test only!!!! Delete after
    for(var i = 0; i < 100; i++) {
      this.load.spritesheet('item' + i, '/images/number-buttons-90x90.png', 38, 38);
      console.log('load...');
    };
  },

  create: function() {
    // this.state.start('Menu');
  },


  // TODO: preloading animated
  // FIXME: free fonts
  launchLoader: function() {
    var posX = this.world.centerX,
        posY = this.world.centerY;

    // this.addImage(posX, posY);
    this.addText(posX, posY + 60)
    ;
  },

  addImage: function(posX, posY) {
    var loading_sprite = this.add.sprite(posX, posY, 'loading');
    loading_sprite.anchor.setTo(0.5,0.5);
  },

  addText: function(posX, posY) {
    var style = { font: "24px Arial", fill: "#ff0044", align: "center" };
    var text = this.add.text(posX, posY, "Loading...", style);
    text.anchor.set(0.5);
    // this.game.add.tween(text).to({x: 2}, 1000, Phaser.Easing.Back.InOut, true, 0, true).yoyo(true);
  }

};
