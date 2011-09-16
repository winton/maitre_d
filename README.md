Maitre D
========

A reservation API for deploy environments.

Setup
-----

<pre>
git clone git@github.com:winton/maitre_d.git
rake gems:install
</pre>

Now your environment is ready to run `passenger start` on the application (or whatever you use to run Sinatra apps).

/reservations/create
--------------------

### Get

    { seconds: 3600, environment: 'beta', user: 'me' }

### Response

Returns state of created reservation:

    { status: 'reserved', expires: 1316133837, user: 'me' }
 
/reservations/show
------------------

### Get

    { environment: 'beta' }

### Response

    { status: 'available' }

or

    { status: 'reserved', expires: 1316133837, user: 'me' }

/reservations/destroy
---------------------

### Get

    { environment: 'beta' }

### Response

Returns state of reservation when you destroyed it:

    { status: 'available' }

or

    { status: 'reserved', expires: 1316133837, user: 'me' }