const admin = require("firebase-admin");

// Sti til din servicekonto-nøgle
const serviceAccount = require("./functions/flutter-gardabooking-firebase-adminsdk.json");

// Initialiser Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// Gør en bruger til admin baseret på UID
const makeUserAdmin = async (uid) => {
  try {
    await admin.auth().setCustomUserClaims(uid, { isAdmin: true });
    console.log(`Brugeren med UID'en ${uid} er nu admin.`);
  } catch (error) {
    console.error(`Fejl opstod ved at gøre brugeren med UID'en ${uid} til admin:`, error);
  }
};

// UID for den admin-bruger, du vil gøre til admin
const adminUid = "R6QJ2u7PHvayatTdz59PVjdTh1g2";

// Kald funktionen til at gøre brugeren til admin med den angivne UID
makeUserAdmin(adminUid);
