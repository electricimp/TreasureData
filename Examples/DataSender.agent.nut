// MIT License
//
// Copyright 2018 Electric Imp
//
// SPDX-License-Identifier: MIT
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

#require "TreasureData.agent.lib.nut:1.0.0"

// TreasureData library sample.
// Periodically sends data to preconfigured TreasureData table.
// Data are sent every 10 seconds, they consist of integer increasing value, converted to string
// and measureTime attribute with data measurement time in seconds since the epoch format.

const TREASURE_DATA_DATABASE_NAME = "test_database";
const TREASURE_DATA_TABLE_NAME = "test_table";
const SEND_DATA_PERIOD_SEC = 10.0;

class DataSender {
    _counter = 0;
    _treasureDataClient = null;

    constructor(apiKey) {
        _treasureDataClient = TreasureData(apiKey);
    }

    // Returns a data to be sent
    function getData() {
        _counter++;
        return {
            "value" : _counter,
            "strValue" : "strValue" + _counter.tostring()
        };
    }

    // Periodically sends data to pre-configured TreasureData table
    function sendData() {
        _treasureDataClient.sendData(
            TREASURE_DATA_DATABASE_NAME,
            TREASURE_DATA_TABLE_NAME,
            getData(),
            onDataSent.bindenv(this));

        imp.wakeup(SEND_DATA_PERIOD_SEC, sendData.bindenv(this));
    }

    // Callback executed once the data is sent
    function onDataSent(error, data) {
        if (error) {
            server.error("Data sending failed: " + error.details);
        } else {
            server.log("Data sent successfully:");
            server.log(http.jsonencode(data));
        }
    }
}

// ----------------------------------------------------------
// TREASURE DATA CONSTANTS
// ----------------------------------------------------------
const TREASURE_DATA_API_KEY = "<YOUR_API_KEY>";

// Start application
dataSender <- DataSender(TREASURE_DATA_API_KEY);
dataSender.sendData();
