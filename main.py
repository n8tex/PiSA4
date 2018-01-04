# main.py
# Pseudocode for main.mcfunction
# NOT ACTUALLY RUNNABLE PYTHON CODE!
# Copyright 2017 (C) Alphor Integrated Technologies

# Some scoreboard stuff so that things can be shown easily #
class ScoreboardTrigger(Object):
    def __init__(self):
        self.value = 0
        self.enabled = False
    def set(self,value):
        if enabled:
            self.value = value
            enabled = False
    def add(self,value):
        if enabled:
            self.value += value        
            enabled = False
    def remove(self,value):
        if enabled:
            self.value -= value
            enabled = False
    def enable(self):
        self.enabled = True

class ScoreboardObjective(ScoreBoardTrigger):
    def __init__(self):
        self.value = 0
        self.enabled = True
    def enable(self):
        pass

# Init
Tx, Mode = [ScoreboardTrigger() for x in range(2)]
State,Bal,Timer,T1 = [ScoreboardObjective() for x in range(4)]

# Timer #
# Placed on top to facilitate further actions
if Timer.value > 1:
    Timer.value -= 1
#/# Timer #/#



# Allow Transactions and Transaction Mode Selection #
# Only when last transaction finished to prevent multi-triggers
if State == 0:
    State.enable()
    Mode.enable()
#/# Allow Transactions and Transaction Mode Selection #/#



# 000000 Initiate Transaction #
# TX Positive, $1 = -$1; TX Negative, $1 = +$(1 - 1) = $0
if (Tx.value > 1) and (State.value in range(0)):
    State.set(1) # State 1, Initiation

if (Tx.value < 1) and (State.value in range(0)):
    State.set(2) # State 2, Negative Initiation
    Tx.add(1) # Offset 1 to accomodate $0 transactions

# Proceed to next step
if State.value in range(1,3):
    State.set(100000)
#/# 000000 Initiate Transaction #/#



# 100000 Load balance to memory #
if Mode.value == 0: # Using Card
    T1.value = Bal.value

if Mode.value == 1: # Using redstone blocks
    T1.value = Inventory.pop(redstone_block) # Remove and count all redstone blocks

if Mode.value == 10: # Query
    T1.value = Bal.value
    
# Staff pass does not need to load to memory, it is bypassed

# Proceed to next step
if State.value == 100000:
    State.set(200000)
#/# 100000 Load balance to memory #/#



# 200000 Calculate Amount #
T1.value -= Tx.value

# Proceed to next step - Transaction Approval
# 300001 Contactless and Gates | 300002 Gates | 300011 Query
if State.value == 200000:
    if Mode.value == 20: # Staff pass
        State.set(300001)
    if Mode.value == 0: # Card
        if Tx.value >= 0:
            State.set(300001)
    if Mode.value == 1: # Redstone Block
        if Tx.value >= 0:
            State.set(300002)
    if Mode.value == 10: # Query
        if Tx.value >= 0:
            State.set(300011)
    if Tx.value <= -1:
        State.set(500002) # See Section 500000 for more information
#/# 200000 Calculate Amount #/#



# 300000 Transaction Approved #
if State.value in range(300000,400000) and (Timer.value == 0 or\ # Values in between used
                                            Timer.value >= 32):  # As running
    Timer.set(31)


dir_code = {"n":1,"e":2,"w":3,"s":4} # Internal Reference
gate_id = {"n":6,"e":7,"w":4,"s":5} # Open fence gate data
dir_combo = {"n":[0,0,-1],"e":[1,0,0],"w":[0,0,1],"s":[0,0,-1]} # Towards In-game Reference

if State.value in range(300000,300003):
    if blockat(player_location[0],
               player_location[1], 
               player_location[2] - 2) == ["lapis_ore",-1]:
        for dir in ["n","e","w","s"]:
            if blockat(list(map(lambda a,b: a + b,zip(player_location,dir_combo[dir])))) ==
               ["fence",-1]:
               # Open Gates
               blockat(list(map(lambda a,b: a + b,zip(player_location,dir_combo[dir])))).set(["fence_gate",gate_id[dir]])
        # Proceed to next step
        for dir in ["n","e","w","s"]:
            if blockat(list(map(lambda a,b: a + b,zip(player_location,dir_combo[dir])))) ==
           ["fence_gate",gate_id[dir]]:
                State.value = 400010 + dir_code[dir]

if State.value in range(300000,300002):
    for dir in ["n","e","w","s"]:
        if blockat(list(map(lambda a,b: a + b,zip(player_location,dir_combo[dir])))) ==
               ["lapis_ore",-1]:
               # Trigger Contactless
               blockat(list(map(lambda a,b: a + b,zip(player_location,dir_combo[dir])))).set(["redstone_block",0])
        # Proceed to next step
        for dir in ["n","e","w","s"]:
            if blockat(list(map(lambda a,b: a + b,zip(player_location,dir_combo[dir])))) ==
           ["redstone_block",-1]:
                State.value = 400020 + dir_code[dir]

if State.value == 300011: # Query Success
    State.value = 400030

# Timeout
if State.value in range(300000,400000) and Timer.value == 1:
    State.set(500001) # See Section 500000 for more details
#/# 300000 Transaction Approved #/#



# 400000 Transaction Completed #
# Mostly for plugin binds
# 40001* Gates | 40002* Contactless | 400030 Query
if State.value in range(400000,500000) and (Timer.value == 0 or\ # Values in between used
                                            Timer.value >= 5):  # As running
    Timer.set(4)

# Proceed to next step
if State.value in range(400000,500000) and Timer.value == 1:
    State.set(600000)
#/# 400000 Transaction Completed #/#



# 500000 Transaction Failed #
# Mostly for plugin binds
# 500001 Timeout | 500002 Not enough funds
if State.value in range(400000,500000) and (Timer.value == 0 or\ # Values in between used
                                            Timer.value >= 5):  # As running
    Timer.set(4)

# Proceed to next step
if State.value in range(500000,600000) and Timer.value == 1:
    State.set(700000)
#/# 500000 Transaction Failed #/#    



# 600000 Initiate Payment #
if State.value == 600000:
    if Mode.value == 0: # Card
        PISABal.value = T1.value # Use running as reference
    T1.set(0) # End condition
    if Mode.value == 1: # Redstone Block
        if T1.value >= 1000:
            Item.give(["redstone_block",0],1000] # Give change
            T1.remove(1000)
        if T1.value in range(100,1000): # Prevent multi-fire slowing down change giving
            Item.give(["redstone_block",0],100]
            T1.remove(100)
        if T1.value in range(10,100):
            Item.give(["redstone_block",0],10])
            T1.remove(10)
        if T1.value in range(1,10):
            Item.give(["redstone_block",0],1)
            T1.remove(1)
    if Mode.value == 10: # Query
        T1.set(0) # Skips the process
    if Mode.value == 20:
        T1.set(0) # Skips the process

    # Proceed to next step
    if T1 == 0:
        State.set(800000)
#/# 600000 Initiate Payment #/#



# 700000 Rollback #
# Revert all done, irreversible changes
if State.value == 700000:
    if Mode.value == 0: # Card, no permanent variables changed so skip
        State.set(800000)
    if Mode.value == 1: # Redstone Block
        T1 += Tx # Get original balance by reverting deduct step in 200000
        State.set(600000) # Use change giving to return redstone blocks
    if Mode.value == 10: # Query, placeholder, no permanent variables changed
        State.set(800000)
#/# 700000 Rollback #/#



# 800000 Cleanup #
# Just reset all running variables, also useful for first time setup
if State.value == 800000:
    Tx.set(0)
    Mode.set(0)
    Timer.set(0)
    T1.set(0)
    State.set(0) # Done last as a whole reset!
#/# 800000 Cleanup #/#
