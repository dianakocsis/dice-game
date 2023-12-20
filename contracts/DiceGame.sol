//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/// @title DiceGame - A contract that allows users to roll a dice and win Ether.
contract DiceGame {

  uint256 public nonce = 0;
  uint256 public prize = 0;

  event Roll(address indexed player, uint256 amount, uint256 roll);
  event Winner(address winner, uint256 amount);

  error NotEnoughEther();

  /// @notice Set the prize to 10% of the contract's balance.
  constructor() payable {
    resetPrize();
  }

  /// @notice Reset the prize to 10% of the contract's balance.
  function resetPrize() private {
    prize = ((address(this).balance * 10) / 100);
  }

  /// @notice Roll a dice and win Ether if the roll is less than or equal to 5, can only call this function when the
  ///         amount of Ether sent is greater than or equal to 0.002, the contract keeps 60% of the Ether sent and
  ///         sends 40% to the winner.
  /// @dev The block hash of the previous block is used to generate randomness which is not secure and can be hacked.
  function rollTheDice() public payable {
    if (msg.value < 0.002 ether) {
      revert NotEnoughEther();
    }

    bytes32 prevHash = blockhash(block.number - 1);
    bytes32 hash = keccak256(abi.encodePacked(prevHash, address(this), nonce));
    uint256 roll = uint256(hash) % 16;

    nonce++;
    prize += ((msg.value * 40) / 100);

    emit Roll(msg.sender, msg.value, roll);

    if (roll > 5) {
      return;
    }

    uint256 amount = prize;
    (bool sent, ) = msg.sender.call{value: amount}("");
    require(sent, "Failed to send Ether");

    resetPrize();
    emit Winner(msg.sender, amount);
  }

  /// @notice Receives ether.
  receive() external payable {}

}
