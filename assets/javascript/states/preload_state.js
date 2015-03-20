function PreloadState() {};

PreloadState.prototype = {
  // loading_sprite: null,

  preload: function() {
    console.log('PreloadState#preload');

    this.launchLoader();
    this.load.image('startButton', '/images/test_play.png')
    this.load.spritesheet('item', '/images/number-buttons-90x90.png', 90, 90);
    // FIXME: for test only!!!!
    for(var i = 0; i < 100; i++) {
      console.log('load...');
      this.load.spritesheet('buttons' + i, '/images/number-buttons-90x90.png');
    };

  },

  create: function() {
    console.log('PreloadState#create');

    this.state.start('Menu');
  },

  // update: function() {
    // loading_sprite.rotation += 0.1;
  // },

  // TODO: preloading animated
  // FIXME: free fonts
  // FIXME: free images
  launchLoader: function() {
    var positionX = this.world.centerX,
        positionY = this.world.centerY;

    this.addImage(positionX, positionY);
    this.addText(positionX, positionY + 60);
  },

  addImage: function(positionX, positionY) {
    var loading_sprite = this.add.sprite(positionX, positionY, 'loading');
    loading_sprite.anchor.setTo(0.5,0.5);
  },

  addText: function(positionX, positionY) {
    var style = { font: "22px Arial", fill: "#ff0044", align: "center" };
    var text = this.add.text(positionX, positionY, "Loading...", style);
    text.anchor.set(0.5);
  }

};
