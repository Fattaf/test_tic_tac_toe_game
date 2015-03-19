function PreloadState() {};

PreloadState.prototype = {
  preload: function() {
    var phaser_logo = this.add.sprite(0, 0, 'phaserjs_logo');


    var loadingImg = this.add.sprite(100, 100, 'loading');

    // loadingImg.anchor.setTo(0.5,0.5);
    // this.load.setPreloadSprite(loadingImg);

    // load all game assets
    // images, spritesheets, atlases, audio etc..


    console.log('PreloadState#preload');
  },
  create: function() {

    console.log('PreloadState#create');
    // this.state.start('Play')
  }
};
