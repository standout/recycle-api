# API Documentation

Sorteramera is an application made for listing the nearest recycle locations.
This is the documentation for the Sortera Mera API. All info is obtainable without [authorisation](#authorisation), however updating entries can only be done by admins.

### Terminology

* **Recycle location**

	A recycle location is a recycle center or station. The entry in the 	database contains information about opening hours, city, materials you can recycle etc.


* **Change request**

	If the info provided about a recycle location is faulty a change request can be made. The change request will be saved separately and not be applied until approved by an admin.


## Get closest recycle locations

To get nearby recycle locations you make a `GET` request containing longitude and latitude of your location.

* **URL**

	`/recycle_locations`
* **Method**

	`GET`
* **URL params**

	**Required**

    `longitude=[float]`

    `latitude=[float]`

* **Success**

	**Code:** 200

    **Content example:**

  	```
    {
        "recycle_locations" : [
          {
            "id": 1,
            "name": "Asarum",
            "kind": "recycle_station",
            "materials": [
              "glass",
              "cardboard",
              "metal",
              "plastic",
              "magazines"
            ],
            "latitude": 56.2075,
            "longitude": 14.85139,
            "street_name": null,
            "zip_code": null,
            "city": "Asarum",
            "created_at": "2016-10-20T09:43:59.337Z",
            "updated_at": "2016-10-20T09:43:59.337Z",
            "opening_hours": [
              null,
              null,
              null,
              null,
              null,
              null,
              null
            ],
            "distance": 0,
            "bearing": "0.0"
          }

        ...
    }
  	```


## Submit a change request

A change request can be sent to the API. The request will be saved and applied on [admin confirmation](#apply-change-request).

* **URL**

	`/change_request/:location_id`

	*Where location_id is the id of the recycle location.*

* **Method**

	`POST`


* **Data params**

	The data should contain the keys and values of the requested changes. Arrays will be handled automatically. Therefore if change to only one array item is requested an array should be sent with the other values empty.

    ```
    {
		"city" : "Gotham",
		"opening_hours" : [ , "10:00", , , , ,]
	}
    ```

    *This request suggests the city name is Gotham and that the tuesday opening hour is 10:00*

* **Success**

	*A change is added to the queue.*

	**Code:** 200

* **Example**

	**Content:**
	```
    	{
			"city" : "Elite",
			"opening_hours" : [ , , , , ,"13:37" , ]
		}
    ```

    *Would request a change to the recycle location with id 1337. The request suggests that the town name is Elite and that the recycle location opens at 13:37 on saturdays.*



## Get pending changes

To get all queued changes you can make a `GET` request to the API.

* **URL**

	`/pending_changes`

* **Method**

	`GET`

* **Success**

	**Code:** 200

    **Content:**

    A `JSON` array containing all queued changes.

 	**Returns:**
	```
	{
  		"recycle_locations": [
    	{
          "info": {
          	"name": "Hogwarts",
          	"change_id": 1,
           	"created_at": "2016-11-01T09:54:27.621Z"
      	},
          "latitude" : [51.7506, 51.8674],
          "longitude" : [-1.2566, -2.2469]
        },
        {
          "info": {
            "name": "Gotham",
            "change_id": 2,
            "created_at": "2016-11-01T09:54:27.621Z"
          },
          "opening_hours_mon" : ["12:00", "10:00"],
          "opening_hours_sat" : ["10:00", "9:00"]
        },

        ...
    }
	```

* **Notes**

	* *Each returned object in the array will contain changes specific to the corresponding recycle location.*
	* *The 'info' key contains information about the change request.*
	* Array changes comes formatted. For example a change to `opening_hours[0]` would be returned with the key `opening_hours_mon`.
	* The `change_id` value is used when you want to [apply the change](#apply-change-request).

## Authorisation

Authorisation has to be made before any recycle locations entries can be [updated](#apply-change-request). By sending a `POST` request to the API; containing user email and password, you will be provided with an authorisation token. The token will be required when making any entry update. The token lasts for 24 hours.

### Get admin token

* **URL**

	`/authenticate`

* **Method**

	`POST`

* **Data params**

    **Content-Type:** `JSON``

    ```
    {
    	"email" : "foo@bar.com",
        "password" : "foobar"
    }
    ```

    *The sent data must contain user email and password.*

* **Success**

	**Code:** 200

    **Content:** A `JSON` object containing the token.

* **Example**

    **Content:**

    ```
    {
    	"email" : "foo@bar.com",
        "password" : "foobar"
    }
    ```

    **Returns:**

    ```
    {
    	"auth_token" : "super_secret_super_cool_token"
    }
    ```


 ## Apply change request

 To apply a change request you must provide a valid token. See [previous](#authorisation) article to see how you can obtain a token.

 * **URL**

	`/apply_change`

* **Method**

	`PUT`

* **Data params**

	**Content-Type:** `JSON``

	```
    {
    	"change_id" : 123,
    	"auth_token" : "super_secret_super_cool_token",
        "opening_hours_mon" : "1"
        "city" : ""
    }
    ```

* **Success**

	**Code:** 200

    *Recycle location will be updated in the database*

* **Example**

    **Content:**

    ```
    {
    	"change_id" : 123,
    	"auth_token" : "super_secret_super_cool_token",
        "opening_hours_mon" : "1"
        "city" : ""
    }
    ```

    *This will apply the marked changes to the change request with id 123. This will only happen if the auth_token is valid.*

* **Notes**

	* Change requests are customized to work with html forms, each indivudal change represented by a checkbox. Therefore a non empty string will apply that change whilst an empty string wont.
