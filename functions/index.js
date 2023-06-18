const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.authTriggeredFunction = functions.auth
  .user()
  .onCreate((user) => {
    const userLogsRef = admin.firestore().collection("userLogs");
    const createdTime = admin.firestore.FieldValue.serverTimestamp();

    const newUserLog = {
      uid: user.uid,
      name: user.displayName,
      createdTime: createdTime,
    };

    return userLogsRef.add(newUserLog);
  });
