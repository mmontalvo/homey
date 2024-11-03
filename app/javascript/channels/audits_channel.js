import consumer from "channels/consumer"

consumer.subscriptions.create("AuditsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    this.appendLine(data)
  },

  appendLine(data) {
    const html = this.createLine(data)
    const element = document.querySelector("#list-audits")
    element.insertAdjacentHTML("beforeend", html)
  },

  createLine(data) {
    return `
      <article class="message-line">
        <span class="user">${data["user_email"]}</span>
        <span class="comment">${data["comment"]}</span>
        <span class="changes">${data["changes"]}</span>
      </article>
    `
  }
});
