var SocketWrapper = {
  socket: null,

  openConnection: function() {
    if (this.socket !== null) { return this.socket; };

    var path = 'ws://' + window.location.host + window.location.pathname;
    this.socket = new WebSocket(path);

    return this.socket;
  },

  closeConnection: function() {
    this.socket.close();
    this.socket = null;
  },

  sendMessage: function(msg) {
    this.checkConnection();
    this.socket.send(msg);
  },

  onMessageHandler: function(customFunc) {
    this.checkConnection();
    this.socket.onmessage = function(msg) { customFunc(msg); };
  },

  checkConnection: function() {
    if (this.socket === null) { this.openConnection(); };
    this.socket
  }

}
