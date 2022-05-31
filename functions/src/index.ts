/* eslint-disable */
import * as functions from 'firebase-functions';
import 'algoliasearch';
import 'firebase-admin';
//import  'firebase';
const algoliasearch = require('algoliasearch')
//const firebase = require('firebase');
const admin = require('firebase-admin');
// const functions = require("firebase-functions");
const ALGOLIA_APP_ID ="G24MEGLUF5";
const Algolia_ADMIN_KEY ="5fcbbc719ca234ca6274bac5e2aaf689";
const ALGOLIA_INDEX_NAME ="products";
admin.initializeApp(functions.config().firebase);
exports.addDataToAlgoliaIndex = functions.https.onRequest((req, res) => {
        const db = admin.firestore();
  const algolia = algoliasearch(
    ALGOLIA_APP_ID,
    Algolia_ADMIN_KEY
  );
  const index = algolia.initIndex(ALGOLIA_INDEX_NAME);
  var docRef = db.collection(ALGOLIA_INDEX_NAME);
  const records : string[] = [];
  docRef.get()
      .then((snapshot) => {
          snapshot.forEach((doc) => {
              const childKey = doc.id;
              const childData = doc.data();
              // We set the Algolia objectID as the Firebase .key
              childData.objectID = childKey;
              // Add object for indexing
              records.push(childData);
              console.log(doc.id, '=>', doc.data());
          });
          // Add or update new objects
          index.saveObjects(records).then((content) => {
           // index.saveObjects(arr, function (err,content){
            //})
              console.log('Documents imported into Algolia');
              process.exit(0);
          })
          .catch(error => {
              console.error('Error when importing documents into Algolia', error);
              process.exit(1);
          });
      })
      .catch((err) => {
          console.error('Error getting documents', err);
      });
});


