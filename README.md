# TreasureData #

This library allows your agent code to send data to the [Treasure Data platform](https://www.treasuredata.com) via the [Treasure Data REST API](https://support.treasuredata.com/hc/en-us/articles/360000675487-Postback-API).

**To add this library to your project, add** `#require "TreasureData.agent.lib.nut:1.0.0"` **to the top of your agent code**

## Library Usage ##

### Prerequisites ###

Before using the library you need to have:

- A [Treasure Data API key](https://support.treasuredata.com/hc/en-us/articles/360000763288-Get-API-Keys). For data sending operations the Write-only key is enough.
- Preconfigured [Treasure Data database and table](https://support.treasuredata.com/hc/en-us/articles/360001266348-Database-and-Table-Management).

### Examples ###

Working examples are provided in the [Examples](./Examples) directory.

### Callbacks ###

All requests that are made to the Treasure Data platform occur asynchronously. Every method that sends a request has an optional parameter which takes a callback function that will be executed when the operation is completed, whether successfully or not. The callback’s parameters are listed in the corresponding method description, but every callback has at least one parameter, *error*. If *error* is `null`, the operation has been executed successfully. Otherwise, *error* is [HTTP response table](https://electricimp.com/docs/api/httprequest/sendasync/) and contains the details of the error.

## TreasureData Class ##

### Constructor: TreasureData(*apiKey*) ###

This method returns a new TreasureData instance.

| Parameter | Data Type | Required? | Description |
| --- | --- | --- | --- |
| *apiKey* | String | Yes | [Treasure Data API key](https://support.treasuredata.com/hc/en-us/articles/360000763288-Get-API-Keys) |

```
#require "TreasureData.agent.lib.nut:1.0.0"

const MY_API_KEY = "<YOUR_TREASURE_DATA_API_KEY>";

treasureData <- TreasureData(MY_API_KEY);
```

### sendData(*dbName, tableName, data[, callback]*) ###

This method sends data record to the specified Treasure Data table. For more information, please see [the Treasure Data documentation](https://support.treasuredata.com/hc/en-us/articles/360000675487-Postback-API#POST%20%2Fpostback%2Fv3%2Fevent%2F%7Bdatabase%7D%2F%7Btable%7D).

| Parameter | Data Type | Required? | Description |
| --- | --- | --- | --- |
| *dbName* | String | Yes | [Treasure Data database name](https://support.treasuredata.com/hc/en-us/articles/360001266348-Database-and-Table-Management) |
| *tableName* | String | Yes | [Treasure Data table name](https://support.treasuredata.com/hc/en-us/articles/360001266348-Database-and-Table-Management) |
| *data* | Key-Value Table | Yes | The data to send &mdash; a key-value table, where a "key" is the name of the field (column) in the database table, the "value" is the value to be written into that field. |
| *callback* | Function | Optional | Executed once the operation is completed |

This method returns nothing. The result of the operation may be obtained via the *callback* function, which has the following parameter:

| Parameter | Data Type | Description |
| --- | --- | --- |
| *error* | table | Error details, [HTTP response table](https://electricimp.com/docs/api/httprequest/sendasync/), or `null` if the operation succeeds |
| *data* | Key-Value Table | The original data passed to the `sendData()` method |

```
const DATABASE_NAME = "<YOUR_DATABASE_NAME>";
const TABLE_NAME = "<YOUR_TABLE_NAME>";

treasureData.sendData(
    DATABASE_NAME,
    TABLE_NAME,
    { "column1" : "value", "column2" : 123 },
    function (error, data) {
        if (error) {
            server.error("Sending data failed: status code " + error.statuscode);
        }
    }.bindenv(this));
```

### setDebug(*value*) ###

This method enables (*value* is `true`) or disables (*value* is `false`) the library debug output (including error logging). It is disabled by default. The method returns nothing.

## Testing ##

Tests for the library are provided in the [tests](./tests) directory.

## License ##

The TreasureData library is licensed under the [MIT License](./LICENSE)
