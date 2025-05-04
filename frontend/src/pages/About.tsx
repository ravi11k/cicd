import React from 'react';

const About = () => {
  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold text-gray-900 mb-8">About Us</h1>
      
      <div className="space-y-6">
        <section className="bg-white p-6 rounded-lg shadow-md">
          <h2 className="text-2xl font-semibold mb-4">Our Mission</h2>
          <p className="text-gray-600">
            We are dedicated to providing the best possible experience for our users
            through innovative solutions and cutting-edge technology.
          </p>
        </section>

        <section className="bg-white p-6 rounded-lg shadow-md">
          <h2 className="text-2xl font-semibold mb-4">Our Team</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div className="border rounded-lg p-4">
              <h3 className="text-xl font-medium mb-2">John Doe</h3>
              <p className="text-gray-600">CEO & Founder</p>
            </div>
            <div className="border rounded-lg p-4">
              <h3 className="text-xl font-medium mb-2">Jane Smith</h3>
              <p className="text-gray-600">CTO</p>
            </div>
          </div>
        </section>

        <section className="bg-white p-6 rounded-lg shadow-md">
          <h2 className="text-2xl font-semibold mb-4">Our Values</h2>
          <ul className="list-disc list-inside space-y-2 text-gray-600">
            <li>Innovation and creativity</li>
            <li>Customer satisfaction</li>
            <li>Quality and excellence</li>
            <li>Team collaboration</li>
          </ul>
        </section>
      </div>
    </div>
  );
};

export default About; 