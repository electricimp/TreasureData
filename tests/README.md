# Test Instructions #

The tests in the current directory are intended to check the behavior of the TreasureData library. The current set of tests check:
- sending data to a preconfigured Treasure Data table
- processing of wrong parameters passed into the library methods

The tests are written for and should be used with [impt](https://github.com/electricimp/imp-central-impt). See [impt Testing Guide](https://github.com/electricimp/imp-central-impt/blob/master/TestingGuide.md) for the details of how to configure and run the tests.

The tests for TreasureData library require pre-setup described below.

## TreasureData Account Configuration ##

- Login to your [Treasure Data account](https://console.treasuredata.com) in your web browser.
- Choose **Databases** in the left menu and click **NEW DATABASE**.
- Enter `__imptest_test_db` as the database name and click **CREATE**.
- Click **NEW TABLE**.
- Enter `__imptest_test_tbl` as the table name and click **CREATE**.
- Choose **Team** in the left menu, choose your user and click **API Keys**.
- Copy the **Master key** and paste into a plain text document or equivalent. This will be used as the value of the *TREASURE_DATA_API_KEY* environment variable in the imp agent code.

## Set Environment Variables ##

- Set *TREASURE_DATA_API_KEY* environment variable to the value of API Key you retrieved and saved in the previous steps.
- For integration with [Travis](https://travis-ci.org) set *EI_LOGIN_KEY* environment variable to the valid impCentral login key.

## Run Tests ##

- See [impt Testing Guide](https://github.com/electricimp/imp-central-impt/blob/master/TestingGuide.md) for the details of how to configure and run the tests.
- Run [impt](https://github.com/electricimp/imp-central-impt) commands from the root directory of the lib. It contains a [default test configuration file](../.impt.test) which should be updated by *impt* commands for your testing environment (at least the Device Group must be updated).
