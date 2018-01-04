############
# PISAMain #
############

#var PISA4Tx,PISA4Bal,PISA4Timer,PISA4T1,PISA4T2

# Timer

scoreboard players remove @p[score_PISA4Timer_min=1] PISA4Timer 1

#/# Timer #/#

# 1 Initiate Transaction

## Positive Transactions
scoreboard players set @p[score_PISA4Tx_min=1] PISA4State 1

## Negative Transactions (TODO: Giving?)
scoreboard players set @p[score_PISA4Tx=-1] PISA4State 2

## TODO: display start title

## Proceed to next step
scoreboard players set @p[score_PISA4State=1,score_PISA4State_min=1] PISA4State 100000

#/# 1 Initiate Transaction #/#

# 100000 Load balance to calc

## Load T1

### Card [0]
scoreboard players operation @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=0,score_PISAMode_min=0] PISA4T1 = @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1] PISA4Bal

### Coupon [1]

#### Get Total Coupon Count -> T1
stats entity @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1=0,score_PISA4T1_min=0,score_PISA4T2=0,score_PISA4T2_min=0] clear AffectedItems
minecraft:clear @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1=0,score_PISA4T1_min=0,score_PISA4T2=0,score_PISA4T2_min=0] redstone_block
stats entity @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1=0,score_PISA4T1_min=0,score_PISA4T2=0,score_PISA4T2_min=0] set AffectedItems PISA4T1

### Query [2]
scoreboard players operation @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=2,score_PISAMode_min=2] PISA4T1 = @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=2,score_PISAMode_min=2] PISA4Bal

## Proceed to next step
scoreboard players set @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISA4T2=0,score_PISA4T2_min=0] PISA4State 200000

#/# Load balance to calc #/#

# 200000 Calculate Amount
scoreboard players operation @p[score_PISA4State=200000,score_PISA4State_min=200000] PISA4T1 -= @p[score_PISA4State=200000,score_PISA4State_min=200000] PISA4Tx

## Proceed to next step - Transaction Approval

### Approved 300000
scoreboard players set @p[score_PISA4State=200000,score_PISA4State_min=200000,score_PISA4T1_min=0] PISA4State 300000

### Query Success 400030
scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000,score_PISA4Mode=10,score_PISA4Mode_min=10] PISA4State 400030

### Rejected 500002
scoreboard players set @p[score_PISA4State=200000,score_PISA4State_min=200000,score_PISAT1=-1] PISA4State 500002

#/# Calculate Amount #/#

# 300000 Success

## Set Timer 31 ms
scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000,score_PISA4Timer=0,score_PISA4Timer_min=0] PISA4Timer 31

## Client reception

### Gate [All requests]

#### Open gates
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~-1 fence -1 setblock ~ ~ ~-1 fence_gate 6
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~1 ~ ~ fence -1 setblock ~1 ~ ~ fence_gate 7
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~1 fence -1 setblock ~ ~ ~1 fence_gate 4
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~-1 ~ ~ fence -1 setblock ~-1 ~ ~ fence_gate 5

#### Proceed to next step
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~-1 fence_gate 6 scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000] PISA4State 400011
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~1 ~ ~ fence_gate 7 scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000] PISA4State 400012
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~1 fence_gate 4 scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000] PISA4State 400013
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~-2 ~ lapis_ore -1 execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~-1 ~ ~ fence_gate 5 scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000] PISA4State 400014

### Contactless [1] ONLY

#### Activate
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~-1 lapis_ore -1 setblock ~ ~ ~-1 redstone_block
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~1 ~ ~ lapis_ore -1 setblock ~1 ~ ~ redstone_block
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~1 lapis_ore -1 setblock ~ ~ ~1 redstone_block
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~-1 ~ ~ lapis_ore -1 setblock ~-1 ~ ~ redstone_block

#### Proceed to next step
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~-1 redstone_block -1 scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000] PISA4State 400021
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~1 ~ ~ redstone_block -1 scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000] PISA4State 400022
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~ ~ ~1 redstone_block -1 scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000] PISA4State 400023
execute @p[score_PISA4State=300000,score_PISA4State_min=300000] ~ ~ ~ detect ~-1 ~ ~ redstone_block -1 scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000] PISA4State 400024

## TODO: Query Accepted

## Timeout
scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000,score_PISA4Timer=1,score_PISA4Timer_min=1] PISA4State 500001

#/# 300000 Success #/#


