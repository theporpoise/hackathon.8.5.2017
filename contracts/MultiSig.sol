pragma solidity ^0.4.4;

contract owned {
	address public owner;

	function owned() {
		owner = msg.sender;
	}

	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}
}

contract mortal is owned {
	function kill() onlyOwner {
		selfdestruct(owner);
	}
}

contract MultiSig is owned, mortal {
	address public trustOne;
	address public trustTwo;
	uint256 public sigOne;
	uint256 public sigTwo;
	address public releaseAddress;

	function MultiSig() {
	}

	function () payable {
	}

	function transfer(address _to, uint256 amount) onlyOwner {
		_to.transfer(amount);
	}

	function setTrustees(address _trustOne, address _trustTwo) onlyOwner{
		trustOne = _trustOne;
		trustTwo = _trustTwo;
	}

	function setRelease(address _releaseAddress) onlyOwner {
		releaseAddress = _releaseAddress;
	}

	function sign() {
		if (msg.sender == trustOne) {
			sigOne = 1;
		} else if (msg.sender == trustTwo) {
			sigTwo = 1;
		}
	}

	function releaseFunds() {
		require((sigOne == 1) && (sigTwo == 1));
		releaseAddress.transfer(this.balance);
	}
}