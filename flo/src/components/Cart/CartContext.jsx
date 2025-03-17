import { createContext, useReducer, useContext } from 'react';

// Création du contexte
export const CartContext = createContext();

// État initial du panier
const initialState = {
  items: [],
  totalQuantity: 0
};

// Actions
const ADD_TO_CART = 'ADD_TO_CART';
const REMOVE_FROM_CART = 'REMOVE_FROM_CART';
const CLEAR_CART = 'CLEAR_CART';

// Fonction reducer pour gérer les états du panier
function cartReducer(state, action) {
  switch (action.type) {
    case ADD_TO_CART:
      { const { product, quantity } = action.payload;
      const existingItemIndex = state.items.findIndex(item => item._id === product._id);
      
      if (existingItemIndex !== -1) {
        // Si le produit existe déjà, mettre à jour la quantité
        const updatedItems = [...state.items];
        updatedItems[existingItemIndex] = {
          ...updatedItems[existingItemIndex],
          quantity: updatedItems[existingItemIndex].quantity + quantity
        };
        
        return {
          ...state,
          items: updatedItems,
          totalQuantity: state.totalQuantity + quantity
        };
      } else {
        // Sinon, ajouter le nouveau produit
        return {
          ...state,
          items: [...state.items, { ...product, quantity }],
          totalQuantity: state.totalQuantity + quantity
        };
      } }
    
    case REMOVE_FROM_CART:
      { const updatedItems = state.items.filter(item => item._id !== action.payload._id);
      const removedItem = state.items.find(item => item._id !== action.payload._id);
      const removedQuantity = removedItem ? removedItem.quantity : 0;
      
      return {
        ...state,
        items: updatedItems,
        totalQuantity: state.totalQuantity - removedQuantity
      }; }
    
    case CLEAR_CART:
      return initialState;
    
    default:
      return state;
  }
}

// Fournisseur du contexte
export function CartProvider({ children }) {
  const [cartState, dispatch] = useReducer(cartReducer, initialState);
  
  // Actions disponibles
  const addToCart = (product, quantity) => {
    dispatch({ 
      type: ADD_TO_CART, 
      payload: { product, quantity }
    });
  };
  
  const removeFromCart = (product) => {
    dispatch({
      type: REMOVE_FROM_CART,
      payload: product
    });
  };
  
  const clearCart = () => {
    dispatch({ type: CLEAR_CART });
  };
  
  const cartContext = {
    items: cartState.items,
    totalQuantity: cartState.totalQuantity,
    addToCart,
    removeFromCart,
    clearCart
  };
  
  return (
    <CartContext.Provider value={cartContext}>
      {children}
    </CartContext.Provider>
  );
}

// Hook personnalisé pour utiliser le contexte du panier
export function useCart() {
  return useContext(CartContext);
}