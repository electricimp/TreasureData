# TreasureData #

This library allows your agent code to send data to the [Treasure Data platform](https://www.treasuredata.com) via the [Treasure Data Postback API](https://support.treasuredata.com/hc/en-us/articles/360000675487-Postback-API).

Before using the library you will need:

- A [Treasure Data API key](https://support.treasuredata.com/hc/en-us/articles/360000763288-Get-API-Keys). To send data, all you need is the write-only key.
- A pre-configured [Treasure Data database and table](https://support.treasuredata.com/hc/en-us/articles/360001266348-Database-and-Table-Management).

**To include this library to your project, add** `#require "TreasureData.agent.lib.nut:1.0.0"` **to the top of your agent code**

## TreasureData Class Usage ##

### Constructor: TreasureData(*apiKey*) ###

This method returns a new TreasureData instance.

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *apiKey* | String | Yes | A [Treasure Data API key](https://support.treasuredata.com/hc/en-us/articles/360000763288-Get-API-Keys) |

#### Example ####

```squirrel
#require "TreasureData.agent.lib.nut:1.0.0"

const MY_API_KEY = "<YOUR_TREASURE_DATA_API_KEY>";

treasureData <- TreasureData(MY_API_KEY);
```

## TreasureData Class Methods ##

### Callbacks ###

All requests that are made to the Treasure Data platform occur asynchronously. Every method that sends a request has an optional parameter which takes a callback function that will be executed when the operation has completed, whether successfully or not. The callback’s parameters are listed in the corresponding method description, but every callback has at least one parameter, *error*. If *error* is `null`, the operation has been executed successfully. Otherwise, *error* is an [HTTP response table](https://developer.electricimp.com/api/httprequest/sendasync) which contains the details of the error.

### sendData(*dbName, tableName, data[, callback]*) ###

This method sends a data record to the specified Treasure Data database and table. For more information, please see [the Treasure Data documentation](https://support.treasuredata.com/hc/en-us/articles/360000675487-Postback-API#POST%20%2Fpostback%2Fv3%2Fevent%2F%7Bdatabase%7D%2F%7Btable%7D).

#### Parameters ####

| Parameter | Data&nbsp;Type | Required? | Description |
| --- | --- | --- | --- |
| *dbName* | String | Yes | A [Treasure Data database name](https://support.treasuredata.com/hc/en-us/articles/360001266348-Database-and-Table-Management) |
| *tableName* | String | Yes | A [Treasure Data table name](https://support.treasuredata.com/hc/en-us/articles/360001266348-Database-and-Table-Management) |
| *data* | Table | Yes | The data to send. Each key in the data table is the name of the field (column) in the database table; a key’s value is the data to be written into that field |
| *callback* | Function | Optional | A function to be executed once the operation has completed |

#### Callback ####

If specified, the function passed into *callback* should include the following parameters:

| Parameter | Data&nbsp;Type | Description |
| --- | --- | --- |
| *error* | Table | Error details as an [HTTP response table](https://developer.electricimp.com/api/httprequest/sendasync), or `null` if the operation succeeded |
| *data* | Table | The original data passed to *sendData()* |

#### Returns ####

Nothing &mdash; The result of the operation may be obtained via the callback.

#### Example ####

```squirrel
const DATABASE_NAME = "<YOUR_DATABASE_NAME>";
const TABLE_NAME = "<YOUR_TABLE_NAME>";

treasureData.sendData(DATABASE_NAME,
                      TABLE_NAME,
                      { "column1" : "string", "column2" : 123 },
                      function (error, data) {
                          if (error) {
                              server.error("Sending data failed: status code " + error.statuscode);
                          }
                      }.bindenv(this));
```

### setDebug(*value*) ###

This method enables (*value* is `true`) or disables (*value* is `false`) the library debug output (including error logging). It is disabled by default. 

#### Returns ####

Nothing.

## Examples ##

Full working examples are provided in the [Examples](./Examples) directory.

## Testing ##

Tests for the library are provided in the [tests](./tests) directory.

## License ##

This library is licensed under the [MIT License](./LICENSE)
