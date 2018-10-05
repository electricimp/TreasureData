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

const TREASURE_DATA_API_KEY = "@{TREASURE_DATA_API_KEY}";

const TEST_DB_NAME = "__imptest_test_db";
const TEST_TABLE_NAME = "__imptest_test_tbl";

// Test case for sendData method of TreasureData library
class SendDataTestCase extends ImpTestCase {
    _treasureDataClient = null;

    function setUp() {
        _treasureDataClient = TreasureData(TREASURE_DATA_API_KEY);
    }

    function testSendSimpleData() {
        _sendData({ "strValue" : "abc" })
            .then(function (value) {
                return _sendData({ "strValue" : null });
            }.bindenv(this))
            .then(function (value) {
                return _sendData({ "intValue" : 123 });
            }.bindenv(this))
            .then(function (value) {
                return _sendData({ "floatValue" : 456.78 });
            }.bindenv(this))
            .then(function (value) {
                return _sendData({ "boolValue" : true });
            }.bindenv(this))
            .fail(function (reason) {
                return Promise.reject(reason);
            }.bindenv(this));
    }

    function testSendComplexData() {
        _sendData({ "strValue" : "xyz", "intValue" : 456, "floatValue" : 789.23, "boolValue" : false })
            .then(function (value) {
                return _sendData({ "tableValue" : { "a" : "b", "c" : "d" } });
            }.bindenv(this))
            .fail(function (reason) {
                return Promise.reject(reason);
            }.bindenv(this));
    }

    function testSendDataWithDebug() {
        _treasureDataClient.setDebug(true);
        return _sendData({ "strValue" : "abc" })
            .finally(function(valueOrReason) {
                _treasureDataClient.setDebug(false);
            }.bindenv(this));
    }

    function _sendData(data) {
        return Promise(function (resolve, reject) {
            _treasureDataClient.sendData(TEST_DB_NAME, TEST_TABLE_NAME, data, function (error, data) {
                if (error) {
                    return reject(error.details);
                }
                return resolve();
            });
        }.bindenv(this));
    }
}
