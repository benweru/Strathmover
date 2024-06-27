import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import { auth } from './firebase';
import AdminDashboard from './pages/AdminDashboard';
import UsersManagement from './pages/UsersManagement';
import Settings from './pages/Settings';
import DataAnalytics from './pages/DataAnalytics';
import Login from './pages/Login';
import { onAuthStateChanged } from 'firebase/auth';

const AuthGuard = ({ children }) => {
  const [user, setUser] = React.useState(null);
  const [loading, setLoading] = React.useState(true);

  React.useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setUser(user);
      setLoading(false);
    });
    return () => unsubscribe();
  }, []);

  if (loading) {
    return <div>Loading...</div>;
  }

  return user ? children : <Navigate to="/login" />;
};

ReactDOM.render(
  <Router>
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route
        path="/admin"
        element={
          <AuthGuard>
            <AdminDashboard />
          </AuthGuard>
        }
      />
      <Route
        path="/admin/users"
        element={
          <AuthGuard>
            <UsersManagement />
          </AuthGuard>
        }
      />
      <Route
        path="/admin/settings"
        element={
          <AuthGuard>
            <Settings />
          </AuthGuard>
        }
      />
      <Route
        path="/admin/analytics"
        element={
          <AuthGuard>
            <DataAnalytics />
          </AuthGuard>
        }
      />
    </Routes>
  </Router>,
  document.getElementById('root')
);
