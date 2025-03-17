import { Container, Row, Col } from 'react-bootstrap';
import ProductItem from './ProductItem';
import { useEffect, useState } from 'react';
import { testList } from '../Product/testList';

function Products() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    setProducts(testList);
  }, []);

  return (
    <Container>
      <Row>
        {products.map((product) => (
          <Col md={4} key={product._id || product.name}>
            <ProductItem 
              id={product._id || product.name} // On utulise l'ID ou le nom comme identifiant
              name={product.name} 
              price={product.price}
            />
          </Col>
        ))}
      </Row>
    </Container>
  );
}

export default Products;