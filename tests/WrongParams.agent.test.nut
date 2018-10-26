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

// Test case for wrong parameters of TreasureData library methods
class WrongParamsTestCase extends ImpTestCase {
    function testWrongConstructorParams() {
        return Promise.all([
            _testWrongConstructorParams(null),
            _testWrongConstructorParams(""),
            _testWrongConstructorParams("<INVALID_API_KEY>"),
        ]);
    }

    function testWrongSendDataParams() {
        return Promise.all([
            _testWrongSendDataParams("", TEST_TABLE_NAME, {}),
            _testWrongSendDataParams(TEST_DB_NAME, "", {}),
            _testWrongSendDataParams(TEST_DB_NAME, TEST_TABLE_NAME, null),
            _testWrongSendDataParams("#INVALID_DB_NAME", TEST_TABLE_NAME, {}),
            _testWrongSendDataParams(TEST_DB_NAME, "#INVALID_TABLE_NAME", {})
        ]);
    }

    function _testWrongConstructorParams(apiKey) {
        local client = TreasureData(apiKey);
        return Promise(function (resolve, reject) {
            client.sendData(
                TEST_DB_NAME,
                TEST_TABLE_NAME,
                {},
                function (error, data) {
                    if (!error) {
                        return reject("Invalid apiKey accepted in sendData");
                    }
                    return resolve("");
                }.bindenv(this));
        }.bindenv(this));
    }

    function _testWrongSendDataParams(dbName, tableName, data) {
        local client = TreasureData(TREASURE_DATA_API_KEY);
        return Promise(function (resolve, reject) {
            client.sendData(
                dbName,
                tableName,
                data,
                function (error, data) {
                    if (!error) {
                        return reject("Invalid params accepted in sendData");
                    }
                    return resolve("");
                }.bindenv(this));
        }.bindenv(this));
    }
}
