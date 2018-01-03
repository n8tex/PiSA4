############
# PISAMain #
############

# Timer
scoreboard players remove @p[score_PISA4Timer_min=1] PISA4Timer 1

# 1 Initiate Transaction

scoreboard players set @p[score_PISA4Tx_min=1] PISA4State 1

## TODO: display start title

## Proceed to next step
scoreboard players set @p[score_PISA4State=1,score_PISA4State_min=1] PISA4State 100000

/# Initiate Transaction #/

# 100000 Load balance to calc

## Load T1

### Card [0]
scoreboard players operation @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=0,score_PISAMode_min=0] PISA4T1 = @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1] PISA4Bal

### Coupon [1]

#### Get Total Coupon Count -> T1
stats entity @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1=0,score_PISA4T1_min=0,score_PISA4T2=0,score_PISA4T2_min=0] clear AffectedItems
minecraft:clear @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1=0,score_PISA4T1_min=0,score_PISA4T2=0,score_PISA4T2_min=0] redstone_block
stats entity @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1=0,score_PISA4T1_min=0,score_PISA4T2=0,score_PISA4T2_min=0] set AffectedItems PISA4T1

#### T2 = T1 for giving
scoreboard players operation @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T2=0,score_PISA4T2_min=0] PISA4T2 = @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T2=0,score_PISA4T2_min=0] PISA4T1

#### Give Item

#### 1000
minecraft:give @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1_min=1,score_PISA4T2_min=1000] redstone_block 1000
scoreboard players remove @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1_min=1,score_PISA4T2_min=1000] PISA4T2 1000

#### 100
minecraft:give @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1_min=1,score_PISA4T2_min=100] redstone_block 100
scoreboard players remove @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1_min=1,score_PISA4T2_min=100] PISA4T2 100

#### 10
minecraft:give @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1_min=1,score_PISA4T2_min=10] redstone_block 10
scoreboard players remove @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1_min=1,score_PISA4T2_min=10] PISA4T2 10

#### 1
minecraft:give @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1_min=1,score_PISA4T2_min=1] redstone_block 1
scoreboard players remove @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=1,score_PISAMode_min=1,score_PISA4T1_min=1,score_PISA4T2_min=1] PISA4T2 1


### Query [2]
scoreboard players operation @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=2,score_PISAMode_min=2] PISA4T1 = @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISAMode=2,score_PISAMode_min=2] PISA4Bal

## Proceed to next step
scoreboard players set @p[score_PISA4State=100000,score_PISA4State_min=100000,score_PISA4T2=0,score_PISA4T2_min=0] PISA4State 200000

/# Load balance to calc #/

# 200000 Calculate Amount
scoreboard players operation @p[score_PISA4State=200000,score_PISA4State_min=200000] PISA4T1 -= @p[score_PISA4State=200000,score_PISA4State_min=200000] PISA4Tx

## Proceed to next step - Transaction Approval

### Approved 300000
scoreboard players set @p[score_PISA4State=200000,score_PISA4State_min=200000,score_PISA4T1_min=0] PISA4State 300000

### Rejected 500002
scoreboard players set @p[score_PISA4State=200000,score_PISA4State_min=200000,score_PISAT1=-1] PISA4State 500002

/# Calculate Amount #/

# 300000 Success

## Set Timer 31 ms
scoreboard players set @p[score_PISA4State=300000,score_PISA4State_min=300000,score_PISA4Timer=0,score_PISA4Timer_min=0] PISA4Timer 31

## Client reception
