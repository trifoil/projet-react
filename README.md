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
        ```
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

    ```
    {  
    "email": "augustin.vangeebergen@std.heh.be",
    "password": "$argon2i$v=19$m=16,t=2,p=1$dWxPMWFZOHlEQVdNYTJtcA$Agb67pRHnvQNdUxtcPi7kA", 
    "role": "admin" 
    }
    ```

## Frontend 

