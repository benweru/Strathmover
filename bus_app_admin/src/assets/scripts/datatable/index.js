
import { collection, getDocs } from "firebase/firestore";
import { db } from "../firebase-config.js";


// Function to fetch data from Firestore and populate the table
async function fetchDataAndPopulateTable() {
  const tableBody = document.getElementById('tableBody');
  const querySnapshot = await getDocs(collection(db, "users")); // Adjust the collection name as needed

  querySnapshot.forEach((doc) => {
    const data = doc.data();
    const row = document.createElement('tr');

    // Create cells and append them to the row
    const emailCell = document.createElement('td');
    emailCell.textContent = data.email;
    row.appendChild(emailCell);

    const fullnameCell = document.createElement('td');
    fullnameCell.textContent = data.fullname;
    row.appendChild(fullnameCell);

    const passwordCell = document.createElement('td');
    passwordCell.textContent = data.password;
    row.appendChild(passwordCell);

    const phoneCell = document.createElement('td');
    phoneCell.textContent = data.phone;
    row.appendChild(phoneCell);

    // Append the row to the table body
    tableBody.appendChild(row);
  });
}

// Call the function to fetch data and populate the table when the page loads
window.addEventListener('DOMContentLoaded', fetchDataAndPopulateTable);
