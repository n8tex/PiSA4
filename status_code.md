### State

#### 0 Initialization
##### 1 Positive Transaction
##### 2 Negative Transaction
Includes offset 1, i.e. PISATx = -1 used for $0 transactions

#### 100000 Load Balance
Loads balance to T1

#### 200000 Calculate Balance
Deducts transaction volume from T2

#### 300000 Transaction Approved
Transaction is approved by server - awaiting client confirmation

Status is held for 30 ms
##### 300001 Card - All Contraptions Available
##### 300002 Coupon - Gates Only
##### 300011 Query Approved - No Contraptions

#### 400000 Transaction Completed
Status is held for 2 ms
##### 400010 Gate Opened
###### 400011 North
###### 400012 East
###### 400013 South
###### 400014 West
##### 400020 Contactless Triggered
###### 400021 North
###### 400022 East
###### 400023 South
###### 400024 West
##### 400030 Query Success

#### 500000 Transaction Failed / Rejected
Status is held for 2 ms
##### 500001 Timeout
##### 500002 Not enough balance

#### 600000 Initiate Payment
Deducts balance from account for cards

Return additional coupons if using coupons

#### 700000 Rollback
Prepare for coupon return if using coupons

#### 800000 Cleanup
Reset all variable (Tx,Mode,State,T1) used to 0


### Mode
#### 1 Card
#### 2 Coupon
#### 10 Query
