import { Card } from 'react-bootstrap';
import ProductItemForm from './ProductItemForm';

function ProductItem(props) {
    // Créer un objet avec toutes les propriétés nécéssaires
    const product = {
        _id: props.id || props.key, // Utiliser l'ID ou la clé comme identifiant
        name: props.name,
        price: props.price,
        // Ajoutez d'autres propriétés si besoin
    };
    
    return (
        <Card style={{ width: '18rem', margin: "10px" }}>
            <Card.Img variant="top" src="https://dummyimage.com/800x480/1500ff/000011" alt="" />
            <Card.Body>
                <Card.Title>{props.name}</Card.Title>
                <Card.Text>{props.price} €</Card.Text>
                <ProductItemForm product={product} />
            </Card.Body>
        </Card>
    );
}   

export default ProductItem;