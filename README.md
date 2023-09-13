<h1>Tie Ordering Management Application</h1>

<h3> The Tie Ordering Management Application is a mobile app designed to streamline the process of managing tie orders. </h3>

Built using Flutter, this application provides an intuitive and user-friendly interface for both viewing existing orders and adding new ones.

<h2>Key Features</h2>

- <h3>MongoDB Integration</h3>

  - Seamlessly connects to a MongoDB database, ensuring robust data storage and retrieval capabilities.

- <h3>Order Management</h3>

  - Add Order: Effortlessly create and submit new tie orders.
  - View Orders: Access a comprehensive list of existing tie orders.
  - Edit Order Details: Modify specific details of a selected order.
  - Delete Order: Remove unwanted or outdated orders.

<h2>Usage</h2>

- <h3>Adding a New Order</h3>

  1. Launch the application and navigate to the main menu.
  2. Click on the "新增订单" button to create a new tie order.
  3. Fill in the required details, such as order date, school, color, length, and quantity.
  4. Click "Submit" to add the new order to the database.

- <h3>Viewing Existing Orders</h3>

  1. From the main menu, select "查看订单记录"(Check Order Record) to access the list of existing tie orders.
  2. Click on a specific order to view its details, including order date, school, color, length, quantity, order status, and completion date.

- <h3>Editing Order Details</h3>

  1. While viewing the details of an order, click on the "修改订单"(Edit Order) button.
  2. Update the necessary information, and click "修改"(Edit) to apply the changes.

- <h3>Deleting an Order</h3>

  1. While viewing the details of an order, click on the "删除订单"(Delete Order) button.
  2. A confirmation dialog will appear. Click "确定"(Confirm) to proceed with the deletion, or "取消"(Cancel) to cancel the operation.


<h2>Caution (MongoDB Link Placement)</h2>

- Move to app/lib/dbHelper/constant.dart

- Place MongoDB Link into this line of code:-
> const MONGO_CONN_URL = "link for mongoDB;
