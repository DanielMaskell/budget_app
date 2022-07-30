import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
const db = admin.firestore();

exports.onPaymentAdded =
    functions.firestore.document("payments/{referenceId}")
        .onCreate(async (snap, context) => {
          // const values = snap.data();
          await db.collection("months").add({
            name: "april",
            days: 30,
            finished: true,
          });
        });
