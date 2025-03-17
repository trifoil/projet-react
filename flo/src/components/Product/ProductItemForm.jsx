import { Button } from "react-bootstrap";
import { useState } from "react";
import { useCart } from "../Cart/CartContext";

function ProductItemForm({ product }) {
    const [quantity, setQuantity] = useState(1);
    const { addToCart } = useCart();

    const handleQuantityChange = (event) => {
        setQuantity(parseInt(event.target.value));
    };

    const handleSubmit = (event) => {
        event.preventDefault();
        addToCart(product, quantity);
        setQuantity(1);
    };

    return (
        <form onSubmit={handleSubmit} style={{display: "flex", alignItems: "center"}}>
            <label htmlFor="quantity" style={{fontSize: "0.8rem"}}>
                <input 
                    type="number" 
                    id="quantity" 
                    name="quantity" 
                    min="1" 
                    value={quantity}
                    onChange={handleQuantityChange}
                    style={{marginRight: "10px"}}
                />
            </label>
            <Button variant="primary" type="submit">Add</Button>
        </form>
    );
}

export default ProductItemForm;