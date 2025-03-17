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

    ```
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

    Answer :


8) Adding a product with Postwoman

    Adding a product in the "coffee" category

    Answer :

    Listing all articles to check if it was added :

    Answer :
    
9) 

10) Modify a product price



## Frontend 

