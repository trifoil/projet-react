# projet-react

## Backend install

1) Use this script to install the required backend 

    ```sh
    sudo rm -rf projet-react
    sudo dnf install git -y
    git clone https://github.com/trifoil/projet-react.git
    cd projet-react
    sudo sh install.sh
    ```

    The script asks you to provide this to allow pictures storage :

    ```
    CLOUD_NAME
    CLOUD_API_KEY
    CLOUD_API_SECRET
    CLOUD_PROJECT
    ```

2) Start the project

    ```sh
    cd toto
    npm install
    npm run dev
    ```

3) Test the database    

    In Compass, you can check the things that are in the database. Connect with id ```root``` and password ```test```.    

    * URI :
            ```
            mongodb://root:test@192.168.124.237:27017/
            ```
    * username : ```root```
    * password : ```test```

4) Test the API

    Access Postwoman with http://192.168.124.237:3001/

    Doc : https://documenter.getpostman.com/view/11050349/2s946feCf5#406e4d25-5959-44ff-8bad-bcea58609c91

    In Postwoman, make sure you format the url correctly (localhost won't work since it is in a docker network) :    
    * Method : ```POST```
    * URL :
        ```
        http://192.168.124.237:3000/api/auth/register
        ```
    * Content type : ```multipart/form-data```
    * Headers :     
        * Content-Type : multipart/form-data
        * Accept-Language : en_MX
    * Raw input (add the image through the ui):            
        ```json
        {
        "username": "testuser",
        "name": "Test User",
        "email": "test@example.com",
        "password": "Test@1234",
        "passwordConfirmation": "Test@1234",
        "role": "user",
        "image": [
            {}
        ],
        "phone": "1234567890",
        "address": "123 Test Street",
        "companyName": "Test Company"
        }
        ```

5) Create an admin account

    To hash the password : https://argon2.online/

    Example :

    * Plain Text Input : ```Test123*```
    * Salt : ```ulO1aY8yDAWMa2mp```
    * Parallelism Factor : ```1```
    * Memory Cost : ```16```
    * Iterations : ```2```
    * Hash Length : ```16```

    Gives

    * Hex Form : ```0206faee94479ef40d754c6d70f8bb9```
    * Encoded Form : ```$argon2i$v=19$m=16,t=2,p=1$dWxPMWFZOHlEQVdNYTJtcA$Agb67pRHnvQNdUxtcPi7kA```

    Example JSON of admin account, to put in "users" of the database:

    ```json
    {  
    "email": "augustin.vangeebergen@std.heh.be",
    "password": "$argon2i$v=19$m=16,t=2,p=1$dWxPMWFZOHlEQVdNYTJtcA$Agb67pRHnvQNdUxtcPi7kA", 
    "role": "admin" 
    }
    ```

6) Connection as an admin

    To fetch the token that will be used later, whe have to talk to the API.

    * Method : ```POST```
    * URL :
        ```
        http://192.168.124.237:3000/api/auth/login
        ```
    * Content type : ```application/json```
    * Headers :     
        * Accept-Language : en_MX
    * Raw input (add the image through the ui): 
        ```json
        {
        "email": "augustin.vangeebergen@std.heh.be",
        "password": "Test123*"
        }
        ```

    The answer will look like this :

    ```json
    {
    "type": "Success",
    "message": "User logged in successfuly.",
    "user": {
        "isEmailVerified": false,
        "_id": "67d77f2d9ff9d2c7fc162b8b",
        "email": "augustin.vangeebergen@std.heh.be",
        "password": "$argon2i$v=19$m=16,t=2,p=1$dWxPMWFZOHlEQVdNYTJtcA$Agb67pRHnvQNdUxtcPi7kA",
        "role": "admin"
    },
    "tokens": {
        "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2N2Q3N2YyZDlmZjlkMmM3ZmMxNjJiOGIiLCJpYXQiOjE3NDIxODc4OTEsImV4cCI6MTc0MjE5MTQ5MSwidHlwZSI6ImFjY2VzcyJ9.mNPAcd7NU-GJWvTsZ2TBuj2Ts9rlpIFQllzx9b1x_jA",
        "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2N2Q3N2YyZDlmZjlkMmM3ZmMxNjJiOGIiLCJpYXQiOjE3NDIxODc4OTEsImV4cCI6MTc0MjI3NDI5MSwidHlwZSI6InJlZnJlc2gifQ.GWaQKeftA3IPb6Z6iSWM4uc5U09yueEtWxebZJwnNew"
    }
    }
    ```

7) Adding a category

    Using the received token, add a category "coffee" :

    * Method : ```POST```
    * URL :
        ```
        http://192.168.124.237:3000/api/category
        ```
    * Content type : ```multipart/form-data```
    * Headers :     
        * Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2N2Q3N2YyZDlmZjlkMmM3ZmMxNjJiOGIiLCJpYXQiOjE3NDIxODc4OTEsImV4cCI6MTc0MjE5MTQ5MSwidHlwZSI6ImFjY2VzcyJ9.mNPAcd7NU-GJWvTsZ2TBuj2Ts9rlpIFQllzx9b1x_jA
        * Accept-Language : en_MX
        * Content-Type : multipart/form-data
    * Body (add the following fields):
        * name: coffee
        * description: all products with coffee
        * image: (Upload an image file for the category, e.g., a coffee-related image).

    Answer :

    ```json
    {
    "type": "Success",
    "message": "Category created successfully.",
    "category": {
        "name": "coffee",
        "description": "all products with coffee",
        "image": "https://res.cloudinary.com/dtthivula/image/upload/v1742188071/test/Category/coffee/li7mqk7py25kzbch6euh.webp",
        "imageId": "test/Category/coffee/li7mqk7py25kzbch6euh",
        "_id": "67d7ae281808a2f9e65a22c3"
    }
    }
    ```

    Listing all categories to check if it was added :

    * Method : ```GET```
    * URL :
        ```
        http://192.168.124.237:3000/api/category
        ```
    * Headers :     
        * Accept-Language : en_MX

    Answer :
    ```json
    {
    "type": "Success",
    "message": "Found categories successfully.",
    "categories": [
        {
            "_id": "67d7ae281808a2f9e65a22c3",
            "name": "coffee",
            "description": "all products with coffee",
            "image": "https://res.cloudinary.com/dtthivula/image/upload/v1742188071/test/Category/coffee/li7mqk7py25kzbch6euh.webp",
            "imageId": "test/Category/coffee/li7mqk7py25kzbch6euh"
        }
    ]
    }
    ```


8) Adding a product with Postwoman

    Adding a product in the "coffee" category :

    * Method : ```POST```
    * URL :
        ```
        http://192.168.124.237:3000/api/product
        ```
    * Content type : ```multipart/form-data```
    * Headers :     
        * Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2N2Q3N2YyZDlmZjlkMmM3ZmMxNjJiOGIiLCJpYXQiOjE3NDIxODc4OTEsImV4cCI6MTc0MjE5MTQ5MSwidHlwZSI6ImFjY2VzcyJ9.mNPAcd7NU-GJWvTsZ2TBuj2Ts9rlpIFQllzx9b1x_jA
        * Accept-Language : en_MX
        * Content-Type : multipart/form-data
    * Body (add the following fields):
        * name: Arabica Coffee
        * description: High-quality Arabica coffee beans, perfect for brewing.
        * category : 67d7ae281808a2f9e65a22c3 (id of coffee category)
        * price : 1500
        * priceDiscount : 10
        * colors : Brown
        * sizes : 250g, 500g
        * quantity : 100 
        * sold : 0
        * isOutOfStock : false
        * mainImage : (image principale)
        * images : (additional images)
    * Body (raw input)
        ```json
        {
            "name": "Arabica Coffee",
            "description": "High-quality Arabica coffee beans, perfect for brewing.",
            "category": "67d7ae281808a2f9e65a22c3", 
            "price": "1500",
            "priceDiscount": "10",
            "colors": "Brown",
            "sizes": "250g, 500g",
            "quantity": "100",
            "sold": "0",
            "isOutOfStock": "false",
            "mainImage": [
                {}
            ]
        }
        ```

    Answer :
    ```json
    {
    "type": "Success",
    "message": "Product created successfully.",
    "product": {
        "name": "Arabica Coffee",
        "mainImage": "https://res.cloudinary.com/dtthivula/image/upload/v1742194402/test/Products/ArabicaCoffee/yzo22styftlnr8r24jhy.webp",
        "mainImageId": "test/Products/ArabicaCoffee/yzo22styftlnr8r24jhy",
        "images": [
        "https://res.cloudinary.com/dtthivula/image/upload/v1742194400/test/Products/ArabicaCoffee/l472odrq3uea6ildoh9v.webp"
        ],
        "imagesId": [
        "test/Products/ArabicaCoffee/l472odrq3uea6ildoh9v"
        ],
        "description": "High-quality Arabica coffee beans, perfect for brewing.",
        "category": "67d7ae281808a2f9e65a22c3",
        "seller": "67d77f2d9ff9d2c7fc162b8b",
        "price": 1500,
        "priceAfterDiscount": 1350,
        "priceDiscount": 10,
        "colors": [
        "67d7c6e31808a2f9e65a22dc"
        ],
        "sizes": [
        "67d7c6e31808a2f9e65a22e2",
        "67d7c6e31808a2f9e65a22e0"
        ],
        "quantity": 100,
        "sold": 0,
        "isOutOfStock": false,
        "ratingsAverage": 4.5,
        "ratingsQuantity": 0,
        "_id": "67d7c6e31808a2f9e65a22d9",
        "slug": "arabica-coffee",
        "id": "67d7c6e31808a2f9e65a22d9"
    }
    }
    ```
    Listing all articles to check if it was added :

    * Method : ```GET```
    * URL :
        ```
        http://192.168.124.237:3000/api/product
        ```

    Answer :
    ```json
    {
    "type": "Success",
    "message": "Products found successfully.",
    "products": [
        {
        "_id": "67d7c6e31808a2f9e65a22d9",
        "name": "Arabica Coffee",
        "mainImage": "https://res.cloudinary.com/dtthivula/image/upload/v1742194402/test/Products/ArabicaCoffee/yzo22styftlnr8r24jhy.webp",
        "mainImageId": "test/Products/ArabicaCoffee/yzo22styftlnr8r24jhy",
        "images": [
            "https://res.cloudinary.com/dtthivula/image/upload/v1742194400/test/Products/ArabicaCoffee/l472odrq3uea6ildoh9v.webp"
        ],
        "imagesId": [
            "test/Products/ArabicaCoffee/l472odrq3uea6ildoh9v"
        ],
        "description": "High-quality Arabica coffee beans, perfect for brewing.",
        "category": "67d7ae281808a2f9e65a22c3",
        "seller": "67d77f2d9ff9d2c7fc162b8b",
        "price": 1500,
        "priceAfterDiscount": 1350,
        "priceDiscount": 10,
        "colors": [
            {
            "_id": "67d7c6e31808a2f9e65a22dc",
            "color": "Brown"
            }
        ],
        "sizes": [
            {
            "_id": "67d7c6e31808a2f9e65a22e2",
            "size": "500g"
            },
            {
            "_id": "67d7c6e31808a2f9e65a22e0",
            "size": "250g"
            }
        ],
        "quantity": 100,
        "sold": 0,
        "isOutOfStock": false,
        "ratingsAverage": 4.5,
        "ratingsQuantity": 0,
        "slug": "arabica-coffee",
        "id": "67d7c6e31808a2f9e65a22d9"
        }
    ]
    }
    ```

9) Modify a product price

    * Method : ```PATCH```
    * URL :
        ```
        http://192.168.124.237:3000/api/product/67d7c6e31808a2f9e65a22d9/details        
        ```
    * Content type : ```application/json```
    * Headers :     
        * Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2N2Q3N2YyZDlmZjlkMmM3ZmMxNjJiOGIiLCJpYXQiOjE3NDIxODc4OTEsImV4cCI6MTc0MjE5MTQ5MSwidHlwZSI6ImFjY2VzcyJ9.mNPAcd7NU-GJWvTsZ2TBuj2Ts9rlpIFQllzx9b1x_jA
        * Accept-Language : en_MX
    * Raw Body :
        ```
        {
            "price": 1450
        }
        ```
    Answer :
    ```json
    {
        "type": "Success",
        "message": "Product detials updated successfully."
    }
    ```

    Checking if the price got modified :

    * Method : ```GET```
    * URL :
        ```
        http://192.168.124.237:3000/api/product/67d7c6e31808a2f9e65a22d9
        ```

    Answer :

    ```json
    {
    "type": "Success",
    "message": "Product found successfully.",
    "product": {
        "_id": "67d7c6e31808a2f9e65a22d9",
        "name": "Arabica Coffee",
        "mainImage": "https://res.cloudinary.com/dtthivula/image/upload/v1742194402/test/Products/ArabicaCoffee/yzo22styftlnr8r24jhy.webp",
        "mainImageId": "test/Products/ArabicaCoffee/yzo22styftlnr8r24jhy",
        "images": [
        "https://res.cloudinary.com/dtthivula/image/upload/v1742194400/test/Products/ArabicaCoffee/l472odrq3uea6ildoh9v.webp"
        ],
        "imagesId": [
        "test/Products/ArabicaCoffee/l472odrq3uea6ildoh9v"
        ],
        "description": "High-quality Arabica coffee beans, perfect for brewing.",
        "category": "67d7ae281808a2f9e65a22c3",
        "seller": "67d77f2d9ff9d2c7fc162b8b",
        "price": 1450,
        "priceAfterDiscount": 1350,
        "priceDiscount": 10,
        "colors": [
        {
            "_id": "67d7c6e31808a2f9e65a22dc",
            "color": "Brown"
        }
        ],
        "sizes": [
        {
            "_id": "67d7c6e31808a2f9e65a22e2",
            "size": "500g"
        },
        {
            "_id": "67d7c6e31808a2f9e65a22e0",
            "size": "250g"
        }
        ],
        "quantity": 100,
        "sold": 0,
        "isOutOfStock": false,
        "ratingsAverage": 4.5,
        "ratingsQuantity": 0,
        "createdAt": "2025-03-17T06:53:23.497Z",
        "updatedAt": "2025-03-17T08:23:31.319Z",
        "slug": "arabica-coffee",
        "__v": 1
    }
    }
    ```

10) Add another product 

    Add a product in the same category :

    Answer :
    

11) Get a product details

    Get details of a product id :

    Answer :


12) Get products by filter

    Http query using filters to display "name" and "price" only :

    Answer :


13) Delete product

    Use a query to delete a product :

    Answer :

## Frontend 

