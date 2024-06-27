import * as $ from 'jquery';
import { collection, getDocs } from "firebase/firestore";
import { db } from "../firebase-config.js";

async function fetchEmails() {
  const querySnapshot = await getDocs(collection(db, "emails"));
  return querySnapshot.docs.map(doc => doc.data());
}

async function displayEmails() {
  const emails = await fetchEmails();
  
  // Assuming you have an element with class 'email-list' to display email items
  const emailListElement = $('.email-list');
  
  // Clear the list before appending new data
  emailListElement.empty();
  
  emails.forEach(email => {
    const emailItem = $(`
      <div class="email-list-item">
        <div class="email-list-item-subject">${email.subject}</div>
        <div class="email-list-item-snippet">${email.snippet}</div>
      </div>
    `);
    emailListElement.append(emailItem);
  });
}

export default (function () {
  $('.email-side-toggle').on('click', e => {
    $('.email-app').toggleClass('side-active');
    e.preventDefault();
  });

  $('.email-list-item, .back-to-mailbox').on('click', e => {
    $('.email-content').toggleClass('open');
    e.preventDefault();
  });

  // Call displayEmails to fetch and display emails when the page loads
  $(document).ready(function() {
    displayEmails();
  });
}());
