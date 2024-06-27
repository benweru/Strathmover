// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDS_2KmRHX2qsBp7rjK1S9u_p2FdqC675k",
  authDomain: "strathmover.firebaseapp.com",
  projectId: "strathmover",
  storageBucket: "strathmover.appspot.com",
  messagingSenderId: "493256316498",
  appId: "1:493256316498:web:7c3fb1daa7ba252797318b",
  measurementId: "G-ZRBR8T9K9N"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

export { db };