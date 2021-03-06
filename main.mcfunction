# PISAMain

# objectives: PISA4Tx,PISA4State,PISA4Mode,PISA4Bal,PISA4Timer,PISA4T1

# Timer

scoreboard players remove @a[score_PISA4Timer_min=1] PISA4Timer 1

#/# Timer #/#

# Allow Transactions

scoreboard players enable @a[score_PISA4State=0,score_PISA4State_min=0] PISA4Tx

#/# Allow Transactions #/#

# Allow Selection of Transaction Mode

scoreboard players enable @a[score_PISA4State=0,score_PISA4State_min=0] PISA4Mode

#/# Allow Transactions #/#

# 0 Initiate Transaction

## 1 Positive Transactions
scoreboard players set @a[score_PISA4Tx_min=1,score_PISA4State=0,score_PISA4State_min=0] PISA4State 1

## 2 Negative Transactions (-1 = $0,-2 = Give $1)
scoreboard players set @a[score_PISA4Tx=-1,score_PISA4State=0,score_PISA4State_min=0] PISA4State 2
scoreboard players add @a[score_PISA4State=2,score_PISA4State_min=2] PISA4Tx 1

## Proceed to next step
scoreboard players set @a[score_PISA4State=2,score_PISA4State_min=1] PISA4State 100000

#/# 0 Initiate Transaction #/#


# 100000 Load balance to calc

## Load T1

### Card [0]
scoreboard players operation @a[score_PISA4State=100000,score_PISA4State_min=100000,score_PISA4Mode=0,score_PISA4Mode_min=0] PISA4T1 = @a[score_PISA4State=100000,score_PISA4State_min=100000,score_PISA4Mode=0,score_PISA4Mode_min=0] PISA4Bal

### Coupon [1]

#### Get Total Coupon Count -> T1
stats entity @a[score_PISA4State=100000,score_PISA4State_min=100000,score_PISA4Mode=1,score_PISA4Mode_min=1] set AffectedItems @p PISA4T1
execute @a[score_PISA4State=100000,score_PISA4State_min=100000,score_PISA4Mode=1,score_PISA4Mode_min=1] ~ ~ ~ minecraft:clear @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISA4Mode=1,score_PISA4Mode_min=1] redstone_block
stats entity @a[score_PISA4State=100000,score_PISA4State_min=100000,score_PISA4Mode=1,score_PISA4Mode_min=1] clear AffectedItems

### Query [10]
scoreboard players operation @a[score_PISA4State=100000,score_PISA4State_min=100000,score_PISA4Mode=10,score_PISA4Mode_min=10] PISA4T1 = @a[score_PISA4State=100000,score_PISA4State_min=100000,score_PISA4Mode=10,score_PISA4Mode_min=10] PISA4Bal

## Proceed to next step
scoreboard players set @a[score_PISA4State=100000,score_PISA4State_min=100000] PISA4State 200000

#/# Load balance to calc #/#


# 200000 Calculate Amount
scoreboard players operation @a[score_PISA4State=200000,score_PISA4State_min=200000] PISA4T1 -= @a[score_PISA4State=200000,score_PISA4State_min=200000] PISA4Tx

## Proceed to next step - Transaction Approval

### Approved 300000

### Staff Pass Override -> 300001
scoreboard players set @a[score_PISA4State=200000,score_PISA4State_min=200000,score_PISA4Mode=20,score_PISA4Mode_min=20] PISA4State 300001

#### 300001 All (Contactless and Gates) - Card [0]
scoreboard players set @a[score_PISA4State=200000,score_PISA4State_min=200000,score_PISA4Mode=0,score_PISA4Mode_min=0,score_PISA4T1_min=0] PISA4State 300001

#### 300002 Gates Only - Coupon [1]
scoreboard players set @a[score_PISA4State=200000,score_PISA4State_min=200000,score_PISA4Mode=1,score_PISA4Mode_min=1,score_PISA4T1_min=0] PISA4State 300002

#### 300011 Query Success - Query [10]
scoreboard players set @a[score_PISA4State=200000,score_PISA4State_min=200000,score_PISA4Mode=10,score_PISA4Mode_min=10,score_PISA4T1_min=0] PISA4State 300011

### Rejected 500002
scoreboard players set @a[score_PISA4State=200000,score_PISA4State_min=200000,score_PISA4T1=-1] PISA4State 500002

#/# Calculate Amount #/#


# 300000 Success

## Set Timer 31 ms
scoreboard players set @a[score_PISA4State=399999,score_PISA4State_min=300000,score_PISA4Timer=0,score_PISA4Timer_min=0] PISA4Timer 31
scoreboard players set @a[score_PISA4State=399999,score_PISA4State_min=300000,score_PISA4Timer_min=32] PISA4Timer 31

## Client reception

### Gate [All requests]

#### Open gates
execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~-1 fence -1 setblock ~ ~ ~-1 fence_gate 6
execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~1 ~ ~ fence -1 setblock ~1 ~ ~ fence_gate 7
execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~1 fence -1 setblock ~ ~ ~1 fence_gate 4
execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~-1 ~ ~ fence -1 setblock ~-1 ~ ~ fence_gate 5

#### Proceed to next step
execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~-1 fence_gate 6 scoreboard players set @a[score_PISA4State=300002,score_PISA4State_min=300000] PISA4State 400011
execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~1 ~ ~ fence_gate 7 scoreboard players set @a[score_PISA4State=300002,score_PISA4State_min=300000] PISA4State 400012
execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~1 fence_gate 4 scoreboard players set @a[score_PISA4State=300002,score_PISA4State_min=300000] PISA4State 400013
execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @a[score_PISA4State=300002,score_PISA4State_min=300000] ~ ~ ~ detect ~-1 ~ ~ fence_gate 5 scoreboard players set @a[score_PISA4State=300002,score_PISA4State_min=300000] PISA4State 400014

### Contactless [0] ONLY

#### Activate
execute @a[score_PISA4State=300001,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~-1 lapis_ore -1 setblock ~ ~ ~-1 redstone_block
execute @a[score_PISA4State=300001,score_PISA4State_min=300000] ~ ~ ~ detect ~1 ~ ~ lapis_ore -1 setblock ~1 ~ ~ redstone_block
execute @a[score_PISA4State=300001,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~1 lapis_ore -1 setblock ~ ~ ~1 redstone_block
execute @a[score_PISA4State=300001,score_PISA4State_min=300000] ~ ~ ~ detect ~-1 ~ ~ lapis_ore -1 setblock ~-1 ~ ~ redstone_block

## Proceed to next step
execute @a[score_PISA4State=300001,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~-1 redstone_block -1 scoreboard players set @a[score_PISA4State=300001,score_PISA4State_min=300000] PISA4State 400021
execute @a[score_PISA4State=300001,score_PISA4State_min=300000] ~ ~ ~ detect ~1 ~ ~ redstone_block -1 scoreboard players set @a[score_PISA4State=300001,score_PISA4State_min=300000] PISA4State 400022
execute @a[score_PISA4State=300001,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~1 redstone_block -1 scoreboard players set @a[score_PISA4State=300001,score_PISA4State_min=300000] PISA4State 400023
execute @a[score_PISA4State=300001,score_PISA4State_min=300000] ~ ~ ~ detect ~-1 ~ ~ redstone_block -1 scoreboard players set @a[score_PISA4State=300001,score_PISA4State_min=300000] PISA4State 400024

### Query Accepted - 400030
scoreboard players set @a[score_PISA4State=300011,score_PISA4State_min=300011] PISA4State 400030 

## Timeout
scoreboard players set @a[score_PISA4State=399999,score_PISA4State_min=300000,score_PISA4Timer=1,score_PISA4Timer_min=1] PISA4State 500001

#/# 300000 Success #/#


# 400000 Transaction Completed (Hold 3 ticks)

## SET Timer
scoreboard players set @a[score_PISA4State=499999,score_PISA4State_min=400000,score_PISA4Timer_min=5] PISA4Timer 4
scoreboard players set @a[score_PISA4State=499999,score_PISA4State_min=400000,score_PISA4Timer=0] PISA4Timer 4

## Proceed to next step
scoreboard players set @a[score_PISA4State=499999,score_PISA4State_min=400000,score_PISA4Timer=1,score_PISA4Timer_min=1] PISA4State 600000

#/# 400000 Transaction Completed #/#


# 500000 Transaction Failed (Hold 3 ticks)

## SET Timer
scoreboard players set @a[score_PISA4State=599999,score_PISA4State_min=500000,score_PISA4Timer_min=5] PISA4Timer 4
scoreboard players set @a[score_PISA4State=599999,score_PISA4State_min=500000,score_PISA4Timer=0] PISA4Timer 4

## Proceed to next step
scoreboard players set @a[score_PISA4State=599999,score_PISA4State_min=500000,score_PISA4Timer=1,score_PISA4Timer_min=1] PISA4State 700000

#/# 500000 Transaction Failed #/#


# 600000 Initiate Payment

## Card [0]
scoreboard players operation @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=0,score_PISA4Mode_min=0] PISA4Bal = @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=0,score_PISA4Mode_min=0] PISA4T1
scoreboard players set @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=0,score_PISA4Mode_min=0] PISA4T1 0

## Coupon [1]

### Change
give @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=1,score_PISA4Mode_min=1,score_PISA4T1_min=1000] redstone_block 1000
scoreboard players remove @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=1,score_PISA4Mode_min=1,score_PISA4T1_min=1000] PISA4T1 1000

give @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=1,score_PISA4Mode_min=1,score_PISA4T1=999,score_PISA4T1_min=100] redstone_block 100
scoreboard players remove @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=1,score_PISA4Mode_min=1,score_PISA4T1=999,score_PISA4T1_min=100] PISA4T1 100

give @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=1,score_PISA4Mode_min=1,score_PISA4T1=99,score_PISA4T1_min=10] redstone_block 10
scoreboard players remove @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=1,score_PISA4Mode_min=1,score_PISA4T1=99,score_PISA4T1_min=10] PISA4T1 10

give @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=1,score_PISA4Mode_min=1,score_PISA4T1=9,score_PISA4T1_min=1] redstone_block 1
scoreboard players remove @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=1,score_PISA4Mode_min=1,score_PISA4T1=9,score_PISA4T1_min=1] PISA4T1 1

## Query [10]
scoreboard players set @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=10,score_PISA4Mode_min=10] PISA4T1 0

## Staff Pass [20]
scoreboard players set @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4Mode=20,score_PISA4Mode_min=20] PISA4T1 0

## Proceed to next step
scoreboard players set @a[score_PISA4State=600000,score_PISA4State_min=600000,score_PISA4T1=0,score_PISA4T1_min=0] PISA4State 800000

#/# 600000 Initiate Payment #/#


# 700000 Rollback

## Card [0]

### Proceed to next step
scoreboard players set @a[score_PISA4State=700000,score_PISA4State_min=700000,score_PISA4Mode=0,score_PISA4Mode_min=0] PISA4State 800000

## Coupon [1] (Use change to return tickets)

### Get original value
scoreboard players operation @a[score_PISA4State=700000,score_PISA4State_min=700000,score_PISA4Mode=1,score_PISA4Mode_min=1] PISA4T1 += @a[score_PISA4State=700000,score_PISA4State_min=700000,score_PISA4Mode=1,score_PISA4Mode_min=1] PISA4Tx

### Proceed to next step
scoreboard players set @a[score_PISA4State=700000,score_PISA4State_min=700000,score_PISA4Mode=1,score_PISA4Mode_min=1] PISA4State 600000

## Query [10]

### Proceed to next step
scoreboard players set @a[score_PISA4State=700000,score_PISA4State_min=700000,score_PISA4Mode=10,score_PISA4Mode_min=10] PISA4State 800000


#/# 700000 Rollback #/#


# 800000 Cleanup

scoreboard players set @a[score_PISA4State=800000,score_PISA4State_min=800000] PISA4Tx 0
scoreboard players set @a[score_PISA4State=800000,score_PISA4State_min=800000] PISA4Mode 0
scoreboard players set @a[score_PISA4State=800000,score_PISA4State_min=800000] PISA4Timer 0
scoreboard players set @a[score_PISA4State=800000,score_PISA4State_min=800000] PISA4T1 0
scoreboard players set @a[score_PISA4State=800000,score_PISA4State_min=800000] PISA4State 0

#/# 800000 Cleanup #/#
