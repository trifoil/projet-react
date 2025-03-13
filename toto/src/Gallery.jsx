import React from 'react';
import Photo from './Photo';

const Gallery = () => {
  const imageUrl1 = "https://picsum.photos/id/973/600/300";
  const imageUrl2 = "https://picsum.photos/id/237/600/300";

  return (
    <div style={{ textAlign: 'center' }}>
      <h1>Galerie de photos</h1>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <Photo imageUrl={imageUrl1} />
        <Photo imageUrl={imageUrl2} />
      </div>
    </div>
  );
};

export default Gallery;

