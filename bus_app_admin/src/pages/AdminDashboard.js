import React, { useState, useEffect } from 'react';
import { db } from '../firebase';
import { collection, getDocs } from 'firebase/firestore';
import Sidebar from '../components/Sidebar';

const AdminDashboard = () => {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    const fetchUsers = async () => {
      const usersCollection = collection(db, 'users');
      const userSnapshot = await getDocs(usersCollection);
      const userList = userSnapshot.docs.map(doc => doc.data());
      setUsers(userList);
    };

    fetchUsers();
  }, []);

  return (
    <div className="admin-dashboard">
      <Sidebar />
      <main>
        <h1>Admin Dashboard</h1>
        <section>
          <h2>Users</h2>
          <ul>
            {users.map((user, index) => (
              <li key={index}>{user.name} - {user.email}</li>
            ))}
          </ul>
        </section>
      </main>
    </div>
  );
};

export default AdminDashboard;
