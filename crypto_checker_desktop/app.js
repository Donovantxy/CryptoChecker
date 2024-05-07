const { app, BrowserWindow } = require("electron/main");
const path = require("node:path");
const fs = require("node:fs");

let mainWindow;

function createWindow() {
  // const width = 950;
  const width = 450;
  const height = 850;
  mainWindow = new BrowserWindow({
    width,
    height,
    resizable: false,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false
    },
  })
  // .setAspectRatio(width/height);

  const indexPath = path.join(__dirname, 'dist/crypto-checker-desktop/browser/index.html');
  mainWindow.loadFile(indexPath);
  
  fs.watch(path.join(__dirname, "dist/crypto-checker-desktop/browser/index.html"), () => {
    mainWindow.loadFile(indexPath);
  });

}

app.whenReady().then(() => {
  createWindow();

  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});
