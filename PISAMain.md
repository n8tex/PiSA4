### PISAMain
1 Get Transaction Details
    Get Transaction Mode (Card[0] or Coupon[1] or Query[2]) + Get Transaction Amount

100000 Check Balance Available

200000 Amount Calculated

300000 Success

400000. Transaction Success (Hold 2 ticks)
    400001 Gate Opened
    400002 Contactless Opened
    400003 Query Success

500000 Transaction Failed (Hold 2 ticks)
    500001 Timeout
    500002 Query Failed

600000 Success Cleanup

700000 Failed Cleanup

800000 Reset
