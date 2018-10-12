# Treasure Data Examples #

This document describes the example application provided with the [Treasure Data library](../README.md).

## DataSender Example ##

This example sends data into a preconfigured Treasure Data table:

- Data is sent every ten seconds.
- Every data record contains:
  - A `"value"` attribute. This is an integer value, which starts at 1 and increases by 1 with every record sent. It restarts from 1 every time the example is restarted.
  - A `"strvalue"` attribute. This is a string value, which contains integer from the `"value"` attribute, converted to string and prefixed by `strValue`.

## Setup and Run ##

### Treasure Data Account Configuration ###

- Login to your [Treasure Data account](https://console.treasuredata.com) in your web browser.
- Choose **Databases** in the left menu and click **NEW DATABASE**.
![NewDatabase](../png/NewDatabase.png?raw=true)
- Enter `test_database` as the database name and click **CREATE**.
![CreateDatabase](../png/CreateDatabase.png?raw=true)
- Click **NEW TABLE**.
![NewTable](../png/NewTable.png?raw=true)
- Enter `test_table` as the table name and click **CREATE**.
![CreateTable](../png/CreateTable.png?raw=true)
- Choose **Team** in the left menu, choose your user and click **API Keys**.
![ApiKeys](../png/ApiKeys.png?raw=true)
- Copy the **Write-only key** and paste into a plain text document or equivalent. This will be used as the value of the *TREASURE_DATA_API_KEY* constant in the imp agent code.

### Setting Up and Running the Application ###

- In [Electric Imp’s impCentral™](https://impcentral.electricimp.com) create a Product and Development Device Group.
- Assign a development device to the newly created Device Group.
- Open the code editor for the newly created Device Group.
- Copy the [DataSender source code](./DataSender.agent.nut) and paste it into the code editor as the agent code.
- Set the *TREASURE_DATA_API_KEY* constant in the agent example code to the value of Treasure Data API key you retrieved and saved earlier.
![SetTreasureDataConsts](../png/SetTreasureDataConsts.png?raw=true)
- Click **Build and Force Restart**.
- Use the code editor’s log pane to confirm that data is being sent successfully:
![DataSenderLogs](../png/SenderExample.png?raw=true)

### Monitor the data in Treasure Data ###

- Return to your [Treasure Data account](https://console.treasuredata.com).
- Choose **Databases** in the left menu and click **test_database** database.
- Click **test_table** table.
- Ensure **test_table** contains **strvalue** and **value** columns and some records are displayed in the table preview.

**Note 1:** The data appears in the table preview with **4~5 minutes delay** after sending.

**Note 2:** The table preview **does not show all received records**. Only some of them. To get all records from the table you may execute an SQL SELECT Query.

![TablePreview](../png/TablePreview.png?raw=true)
