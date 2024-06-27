import React, { useState } from 'react';
import { db } from '../firebase';
import { doc, setDoc, getDoc } from 'firebase/firestore';
import Sidebar from '../components/Sidebar';

const Settings = () => {
  const [settings, setSettings] = useState({
    darkMode: false,
    notifications: true
  });

  const handleToggle = async (setting) => {
    const newValue = !settings[setting];
    setSettings({ ...settings, [setting]: newValue });
    await setDoc(doc(db, 'settings', 'main'), { ...settings, [setting]: newValue });
  };

  const fetchSettings = async () => {
    const settingsDoc = await getDoc(doc(db, 'settings', 'main'));
    if (settingsDoc.exists()) {
      setSettings(settingsDoc.data());
    }
  };

  useEffect(() => {
    fetchSettings();
  }, []);

  return (
    <div className="settings">
      <Sidebar />
      <main>
        <h1>Settings</h1>
        <div>
          <label>
            Dark Mode
            <input
              type="checkbox"
              checked={settings.darkMode}
              onChange={() => handleToggle('darkMode')}
            />
          </label>
        </div>
        <div>
          <label>
            Notifications
            <input
              type="checkbox"
              checked={settings.notifications}
              onChange={() => handleToggle('notifications')}
            />
          </label>
        </div>
      </main>
    </div>
  );
};

export default Settings;
