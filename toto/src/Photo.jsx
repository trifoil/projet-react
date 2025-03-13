import React from 'react';

const Photo = ({ imageUrl }) => {
  return (
    <div style={{ margin: '10px' }}>
      <img src={imageUrl} alt="Random" style={{ height: '300px' }} />
    </div>
  );
};

export default Photo;