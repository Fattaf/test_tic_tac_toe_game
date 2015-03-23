function PreloadState() {};

PreloadState.prototype = {
  // loading_sprite: null,

  preload: function() {
    // console.log('PreloadState#preload');

    this.launchLoader();
    this.load.image('startButton', '/images/test_play.png')
    this.load.spritesheet('item', '/images/number-buttons-90x90.png', 90, 90);

    // FIXME: for test only!!!! Delete after
    for(var i = 0; i < 100; i++) {
      this.load.spritesheet('item' + i, '/images/number-buttons-90x90.png', 90, 90);
      console.log('load...');
    };
  },

  create: function() {
    // console.log('PreloadState#create');

    this.state.start('Menu');
  },

  // update: function() {
    // loading_sprite.rotation += 0.1;
  // },

  // TODO: preloading animated
  // FIXME: free fonts
  // FIXME: free images
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
    var style = { font: "22px Arial", fill: "#ff0044", align: "center" };
    var text = this.add.text(posX, posY, "Loading...", style);
    text.anchor.set(0.5);
  }

};
