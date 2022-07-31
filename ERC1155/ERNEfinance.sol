/**
 *Submitted for verification at Etherscan.io on 2020-10-07
*/

pragma solidity ^0.6.12;
    
// "SPDX-License-Identifier: UNLICENSED"

// File: contracts/utils/SafeMath.sol


/**
* @title SafeMath
* @dev Unsigned math operations with safety checks that revert on error
*/
library SafeMath {

    /**
    * @dev Multiplies two unsigned integers, reverts on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
          return 0;
        }
        
        uint256 c = a * b;
        require(c / a == b, "SafeMath#mul: OVERFLOW");
        
        return c;
    }
    
    /**
    * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, "SafeMath#div: DIVISION_BY_ZERO");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        
        return c;
    }
    
    /**
    * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath#sub: UNDERFLOW");
        uint256 c = a - b;
    
    return c;
    }
    
    /**
    * @dev Adds two unsigned integers, reverts on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath#add: OVERFLOW");
        
    return c; 
    }
    
    /**
    * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
    * reverts when dividing by zero.
    */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath#mod: DIVISION_BY_ZERO");
        return a % b;
    }
}
    
// File: contracts/interfaces/IERC1155TokenReceiver.sol
    
pragma solidity ^0.6.8;
    
    /**
    * @dev ERC-1155 interface for accepting safe transfers.
    */
interface IERC1155TokenReceiver {
    
    
    /**
    * @notice Handle the receipt of a single ERC1155 token type
    * @dev An ERC1155-compliant smart contract MUST call this function on the token recipient contract, at the end of a `safeTransferFrom` after the balance has been updated
    * This function MAY throw to revert and reject the transfer
    * Return of other amount than the magic value MUST result in the transaction being reverted
    * Note: The token contract address is always the message sender
    * @param _operator  The address which called the `safeTransferFrom` function
    * @param _from      The address which previously owned the token
    * @param _id        The id of the token being transferred
    * @param _amount    The amount of tokens being transferred
    * @param _data      Additional data with no specified format
    * @return           `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
    */
    function onERC1155Received(address _operator, address _from, uint256 _id, uint256 _amount, bytes calldata _data) external returns(bytes4);
    
    /**
    * @notice Handle the receipt of multiple ERC1155 token types
    * @dev An ERC1155-compliant smart contract MUST call this function on the token recipient contract, at the end of a `safeBatchTransferFrom` after the balances have been updated
    * This function MAY throw to revert and reject the transfer
    * Return of other amount than the magic value WILL result in the transaction being reverted
    * Note: The token contract address is always the message sender
    * @param _operator  The address which called the `safeBatchTransferFrom` function
    * @param _from      The address which previously owned the token
    * @param _ids       An array containing ids of each token being transferred
    * @param _amounts   An array containing amounts of each token being transferred
    * @param _data      Additional data with no specified format
    * @return           `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
    */
    function onERC1155BatchReceived(address _operator, address _from, uint256[] calldata _ids, uint256[] calldata _amounts, bytes calldata _data) external returns(bytes4);
}
    
    // File: contracts/interfaces/IERC1155.sol
    
pragma solidity ^0.6.8;
    
    
interface IERC1155 {
    
    /****************************************|
    |                 Events                 |
    |_______________________________________*/
    
    /**
    * @dev Either TransferSingle or TransferBatch MUST emit when tokens are transferred, including zero amount transfers as well as minting or burning
    *   Operator MUST be msg.sender
    *   When minting/creating tokens, the `_from` field MUST be set to `0x0`
    *   When burning/destroying tokens, the `_to` field MUST be set to `0x0`
    *   The total amount transferred from address 0x0 minus the total amount transferred to 0x0 may be used by clients and exchanges to be added to the "circulating supply" for a given token ID
    *   To broadcast the existence of a token ID with no initial balance, the contract SHOULD emit the TransferSingle event from `0x0` to `0x0`, with the token creator as `_operator`, and a `_amount` of 0
    */
    event TransferSingle(address indexed _operator, address indexed _from, address indexed _to, uint256 _id, uint256 _amount);
    
    /**
    * @dev Either TransferSingle or TransferBatch MUST emit when tokens are transferred, including zero amount transfers as well as minting or burning
    *   Operator MUST be msg.sender
    *   When minting/creating tokens, the `_from` field MUST be set to `0x0`
    *   When burning/destroying tokens, the `_to` field MUST be set to `0x0`
    *   The total amount transferred from address 0x0 minus the total amount transferred to 0x0 may be used by clients and exchanges to be added to the "circulating supply" for a given token ID
    *   To broadcast the existence of multiple token IDs with no initial balance, this SHOULD emit the TransferBatch event from `0x0` to `0x0`, with the token creator as `_operator`, and a `_amount` of 0
    */
    event TransferBatch(address indexed _operator, address indexed _from, address indexed _to, uint256[] _ids, uint256[] _amounts);
    
    /**
    * @dev MUST emit when an approval is updated
    */
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    
    /**
    * @dev MUST emit when the URI is updated for a token ID
    *   URIs are defined in RFC 3986
    *   The URI MUST point a JSON file that conforms to the "ERC-1155 Metadata JSON Schema"
    */
    event URI(string _amount, uint256 indexed _id);
    
    
    /****************************************|
    |                Functions               |
    |_______________________________________*/
    
    /**
    * @notice Transfers amount of an _id from the _from address to the _to address specified
    * @dev MUST emit TransferSingle event on success
    * Caller must be approved to manage the _from account's tokens (see isApprovedForAll)
    * MUST throw if `_to` is the zero address
    * MUST throw if balance of sender for token `_id` is lower than the `_amount` sent
    * MUST throw on any other error
    * When transfer is complete, this function MUST check if `_to` is a smart contract (code size > 0). If so, it MUST call `onERC1155Received` on `_to` and revert if the return amount is not `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
    * @param _from    Source address
    * @param _to      Target address
    * @param _id      ID of the token type
    * @param _amount  Transfered amount
    * @param _data    Additional data with no specified format, sent in call to `_to`
    */
    function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _amount, bytes calldata _data) external;
    
    /**
    * @notice Send multiple types of Tokens from the _from address to the _to address (with safety call)
    * @dev MUST emit TransferBatch event on success
    * Caller must be approved to manage the _from account's tokens (see isApprovedForAll)
    * MUST throw if `_to` is the zero address
    * MUST throw if length of `_ids` is not the same as length of `_amounts`
    * MUST throw if any of the balance of sender for token `_ids` is lower than the respective `_amounts` sent
    * MUST throw on any other error
    * When transfer is complete, this function MUST check if `_to` is a smart contract (code size > 0). If so, it MUST call `onERC1155BatchReceived` on `_to` and revert if the return amount is not `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
    * Transfers and events MUST occur in the array order they were submitted (_ids[0] before _ids[1], etc)
    * @param _from     Source addresses
    * @param _to       Target addresses
    * @param _ids      IDs of each token type
    * @param _amounts  Transfer amounts per token type
    * @param _data     Additional data with no specified format, sent in call to `_to`
    */
    function safeBatchTransferFrom(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _amounts, bytes calldata _data) external;
    
    /**
    * @notice Get the balance of an account's Tokens
    * @param _owner  The address of the token holder
    * @param _id     ID of the Token
    * @return        The _owner's balance of the Token type requested
    */
    function balanceOf(address _owner, uint256 _id) external view returns (uint256);
    
    /**
    * @notice Get the balance of multiple account/token pairs
    * @param _owners The addresses of the token holders
    * @param _ids    ID of the Tokens
    * @return        The _owner's balance of the Token types requested (i.e. balance for each (owner, id) pair)
    */
    function balanceOfBatch(address[] calldata _owners, uint256[] calldata _ids) external view returns (uint256[] memory);
    
    /**
    * @notice Enable or disable approval for a third party ("operator") to manage all of caller's tokens
    * @dev MUST emit the ApprovalForAll event on success
    * @param _operator  Address to add to the set of authorized operators
    * @param _approved  True if the operator is approved, false to revoke approval
    */
    function setApprovalForAll(address _operator, bool _approved) external;
    
    /**
    * @notice Queries the approval status of an operator for a given owner
    * @param _owner     The owner of the Tokens
    * @param _operator  Address of authorized operator
    * @return isOperator True if the operator is approved, false if not
    */
    function isApprovedForAll(address _owner, address _operator) external view returns (bool isOperator);
}
    
    // File: contracts/utils/Address.sol
    
pragma solidity ^0.6.8;
    
    
    /**
    * Utility library of inline functions on addresses
    */
library Address {
    
    // Default hash for EOA accounts returned by extcodehash
    bytes32 constant internal ACCOUNT_HASH = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
    
    /**
    * Returns whether the target address is a contract
    * @dev This function will return false if invoked during the constructor of a contract.
    * @param _address address of the account to check
    * @return Whether the target address is a contract
    */
    function isContract(address _address) internal view returns (bool) {
        bytes32 codehash;
    
        // Currently there is no better way to check if there is a contract in an address
        // than to check the size of the code at that address or if it has a non-zero code hash or account hash
        assembly { codehash := extcodehash(_address) }
        return (codehash != 0x0 && codehash != ACCOUNT_HASH);
    }
}
    
// File: contracts/utils/ERC165.sol
    
pragma solidity ^0.6.8;
    
abstract contract ERC165 {
    /**
    * @notice Query if a contract implements an interface
    * @param _interfaceID The interface identifier, as specified in ERC-165
    * @return `true` if the contract implements `_interfaceID`
    */
    function supportsInterface(bytes4 _interfaceID) virtual public pure returns (bool) {
        return _interfaceID == this.supportsInterface.selector;
    }
}
    
/*
* @dev Provides information about the current execution context, including the
* sender of the transaction and its data. While these are generally available
* via msg.sender and msg.data, they should not be accessed in such a direct
* manner, since when dealing with GSN meta-transactions the account sending and
* paying for execution may not be the actual sender (as far as an application
* is concerned).
*
* This contract is only required for intermediate, library-like contracts.
*/
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks
    
    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }
    
    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}
    
contract Ownable is Context {
    address private _owner;
    
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    
    
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }
    
    
    function owner() public view returns (address) {
        return _owner;
    }
    
    /**
     * Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }
    
    /**
     * Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }
    
    /**
     *  Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    
    /**
     *  Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }
    
    /**
     *  Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
    
contract Allowable is Ownable {
    
    // Contains details regarding allowed addresses
    mapping (address => mapping(uint256 => bool) )public permissions;
    // Active status
    bool public isActive = true;

    /**
    * @dev Reverts if an address is not allowed. Can be used when extending this contract.
    */
    
    modifier whenActive(address _from,address _to,uint256 tokenId){
        require (!permissions[_from][tokenId] && !permissions[_to][tokenId] );          
        _;
    }
    
    modifier active(){
            require(isActive, "Not Active");            
        _;
    }
    
    /**
    * @dev Adds single address to the permissions list. Allowed only for contract owner.
    * @param _operator Address to be added to the permissions list
    */
    function allow(address _operator,uint256 _tokenId) external onlyOwner {
        permissions[_operator][_tokenId] = false;
    }
    
    /**
    * @dev Removes single address from an permissions list. Allowed only for contract owner.  
    * @param _operator Address to be removed from the permissions list
    */
    function deny(address _operator,uint256 _tokenId) external onlyOwner {
         permissions[_operator][_tokenId] = true;
    }
    
    /**
    * @dev Sets active status of the contract. Allowed only for contract owner.  
    * @param _status Status of the contract
    */
    function activate(bool _status) onlyOwner public {
        isActive = _status;
    }
    
}

// File: contracts/tokens/ERC1155/ERC1155.sol
    
pragma solidity ^0.6.8;

/**
* @dev Implementation of Multi-Token Standard contract
*/
contract ERC1155 is IERC1155, ERC165 , Allowable{
    using SafeMath for uint256;
    using Address for address;
    
    /***********************************|
    |        Variables and Events       |
    |__________________________________*/
    
    // Contract name
      string public name;
      // Contract symbol
      string public symbol;
    
    // onReceive function signatures
    bytes4 constant internal ERC1155_RECEIVED_VALUE = 0xf23a6e61;
    bytes4 constant internal ERC1155_BATCH_RECEIVED_VALUE = 0xbc197c81;
    
    // Objects balances
    mapping (address => mapping(uint256 => uint256)) internal balances;
    
    // Operator Functions
    mapping (address => mapping(address => bool)) internal operators;
    
    //  A record of each accounts delegate
    mapping (address => mapping (uint256 => address)) internal _delegates;
    
    /// @notice A checkpoint for marking number of votes from a given block
    struct Checkpoint {
        uint32 fromBlock;
        uint256 votes;
    }
    
    /// @notice A record of votes checkpoints for each account, by index
    mapping (address => mapping (uint32 => mapping(uint256=> Checkpoint))) public checkpoints;
    
    /// @notice The number of checkpoints for each account
    mapping (address => mapping (uint256 => uint32)) public numCheckpoints;
    
    /// @notice The EIP-712 typehash for the contract's domain
    bytes32 public constant DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,uint256 chainId,address verifyingContract)");
    
    /// @notice The EIP-712 typehash for the delegation struct used by the contract
    bytes32 public constant DELEGATION_TYPEHASH = keccak256("Delegation(address delegatee,uint256 nonce,uint256 expiry)");
    
    /// @notice A record of states for signing / validating signatures
    mapping (address => uint) public nonces;
    
      /// @notice An event thats emitted when an account changes its delegate
    event DelegateChanged(address indexed delegator, address indexed fromDelegate, address indexed toDelegate);
    
    /// @notice An event thats emitted when a delegate account's vote balance changes
    event DelegateVotesChanged(address indexed delegate, uint previousBalance, uint newBalance);
    
    
    
    
    /***********************************|
    |     Public Transfer Functions     |
    |__________________________________*/
    
    /**
    * @notice Transfers amount amount of an _id from the _from address to the _to address specified
    * @param _from    Source address
    * @param _to      Target address
    * @param _id      ID of the token type
    * @param _amount  Transfered amount
    * @param _data    Additional data with no specified format, sent in call to `_to`
    */
    function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _amount, bytes memory _data)
        public active() whenActive(_from,_to,_id) override 
    {
        require((msg.sender == _from) || isApprovedForAll(_from, msg.sender), "ERC1155#safeTransferFrom: INVALID_OPERATOR");
        require(_to != address(0),"ERC1155#safeTransferFrom: INVALID_RECIPIENT");
        // require(_amount <= balances[_from][_id]) is not necessary since checked with safemath operations
        
        _safeTransferFrom(_from, _to, _id, _amount);
        _callonERC1155Received(_from, _to, _id, _amount, gasleft(), _data);
    
    }
    
    /**
    
    /**
    * @notice Send multiple types of Tokens from the _from address to the _to address (with safety call)
    * @param _from     Source addresses
    * @param _to       Target addresses
    * @param _ids      IDs of each token type
    * @param _amounts  Transfer amounts per token type
    * @param _data     Additional data with no specified format, sent in call to `_to`
    */
    function safeBatchTransferFrom(address _from, address _to, uint256[] memory _ids, uint256[] memory _amounts, bytes memory _data)
        public override active() 
    {
        // Requirements
        require((msg.sender == _from) || isApprovedForAll(_from, msg.sender), "ERC1155#safeBatchTransferFrom: INVALID_OPERATOR");
        require(_to != address(0), "ERC1155#safeBatchTransferFrom: INVALID_RECIPIENT");
        
        _safeBatchTransferFrom(_from, _to, _ids, _amounts);
        _callonERC1155BatchReceived(_from, _to, _ids, _amounts, gasleft(), _data);
    }
    
    
    /***********************************|
    |    Internal Transfer Functions    |
    |__________________________________*/
    
    /**
    * @notice Transfers amount amount of an _id from the _from address to the _to address specified
    * @param _from    Source address
    * @param _to      Target address
    * @param _id      ID of the token type
    * @param _amount  Transfered amount
    */
    function _safeTransferFrom(address _from, address _to, uint256 _id, uint256 _amount)
        internal
    {
        // Update balances
        balances[_from][_id] = balances[_from][_id].sub(_amount); // Subtract amount
        balances[_to][_id] = balances[_to][_id].add(_amount);     // Add amount
        
        _moveDelegates(_delegates[_from][_id], _delegates[_to][_id], _amount,_id);
        
        // Emit event
        emit TransferSingle(msg.sender, _from, _to, _id, _amount);
    }
    
    /**
    * @notice Verifies if receiver is contract and if so, calls (_to).onERC1155Received(...)
    */
    function _callonERC1155Received(address _from, address _to, uint256 _id, uint256 _amount, uint256 _gasLimit, bytes memory _data)
        internal
    {
        // Check if recipient is contract
        if (_to.isContract()) {
          bytes4 retval = IERC1155TokenReceiver(_to).onERC1155Received{gas: _gasLimit}(msg.sender, _from, _id, _amount, _data);
          require(retval == ERC1155_RECEIVED_VALUE, "ERC1155#_callonERC1155Received: INVALID_ON_RECEIVE_MESSAGE");
        }
    }
    
    /**
    * @notice Send multiple types of Tokens from the _from address to the _to address (with safety call)
    * @param _from     Source addresses
    * @param _to       Target addresses
    * @param _ids      IDs of each token type
    * @param _amounts  Transfer amounts per token type
    */
    function _safeBatchTransferFrom(address _from, address _to, uint256[] memory _ids, uint256[] memory _amounts)
        internal
    {
        require(_ids.length == _amounts.length, "ERC1155#_safeBatchTransferFrom: INVALID_ARRAYS_LENGTH");
        
        // Number of transfer to execute
        uint256 nTransfer = _ids.length;
        
        // Executing all transfers
        for (uint256 i = 0; i < nTransfer; i++) {
            require (!permissions[_from][_ids[i]] && !permissions[_to][_ids[i]],"blocked user");          
          // Update storage balance of previous bin
          balances[_from][_ids[i]] = balances[_from][_ids[i]].sub(_amounts[i]);
          balances[_to][_ids[i]] = balances[_to][_ids[i]].add(_amounts[i]);
        }
        
        // Emit event
        emit TransferBatch(msg.sender, _from, _to, _ids, _amounts);
    }
    
    /**
    * @notice Verifies if receiver is contract and if so, calls (_to).onERC1155BatchReceived(...)
    */
    function _callonERC1155BatchReceived(address _from, address _to, uint256[] memory _ids, uint256[] memory _amounts, uint256 _gasLimit, bytes memory _data)
        internal
    {
        // Pass data if recipient is contract
        if (_to.isContract()) {
          bytes4 retval = IERC1155TokenReceiver(_to).onERC1155BatchReceived{gas: _gasLimit}(msg.sender, _from, _ids, _amounts, _data);
          require(retval == ERC1155_BATCH_RECEIVED_VALUE, "ERC1155#_callonERC1155BatchReceived: INVALID_ON_RECEIVE_MESSAGE");
        }
    }
    
    
    /***********************************|
    |         Operator Functions        |
    |__________________________________*/
    
    /**
    * @notice Enable or disable approval for a third party ("operator") to manage all of caller's tokens
    * @param _operator  Address to add to the set of authorized operators
    * @param _approved  True if the operator is approved, false to revoke approval
    */
    function setApprovalForAll(address _operator, bool _approved)
        external  override
    {
        // Update operator status
        operators[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }
    
    
    
    /**
    * @notice Queries the approval status of an operator for a given owner
    * @param _owner     The owner of the Tokens
    * @param _operator  Address of authorized operator
    * @return isOperator True if the operator is approved, false if not
    */
    function isApprovedForAll(address _owner, address _operator)
        public override view returns (bool isOperator)
    {
        return operators[_owner][_operator];
    }
    
    
    /***********************************|
    |         Balance Functions         |
    |__________________________________*/
    
    /**
    * @notice Get the balance of an account's Tokens
    * @param _owner  The address of the token holder
    * @param _id     ID of the Token
    * @return The _owner's balance of the Token type requested
    */
    function balanceOf(address _owner, uint256 _id)
        public override view returns (uint256)
    {
        return balances[_owner][_id];
    }
    
    /**
    * @notice Get the balance of multiple account/token pairs
    * @param _owners The addresses of the token holders
    * @param _ids    ID of the Tokens
    * @return        The _owner's balance of the Token types requested (i.e. balance for each (owner, id) pair)
    */
    function balanceOfBatch(address[] memory _owners, uint256[] memory _ids)
        public override view returns (uint256[] memory)
    {
        require(_owners.length == _ids.length, "ERC1155#balanceOfBatch: INVALID_ARRAY_LENGTH");
        
        // Variables
        uint256[] memory batchBalances = new uint256[](_owners.length);
        
        // Iterate over each owner and token ID
        for (uint256 i = 0; i < _owners.length; i++) {
          batchBalances[i] = balances[_owners[i]][_ids[i]];
        }
        
        return batchBalances;
    }
    
    /**
    * @notice Manages the delagates
    * @param delegator  The addresses of delegator
    * @param delegatee  The addresses of delegator
    * @param tokenId    Token type
    */ 
    function _delegate(address delegator, address delegatee, uint256 tokenId)
        internal
    {
        address currentDelegate = _delegates[delegator][tokenId];
        uint256 delegatorBalance = balanceOf(delegator,tokenId); // balance of underlying (not scaled);
        _delegates[delegator][tokenId] = delegatee;
    
        emit DelegateChanged(delegator, currentDelegate, delegatee);
    
        _moveDelegates(currentDelegate, delegatee, delegatorBalance,tokenId);
    }
    
    /**
    * @notice Move the delegate control to delegatee
    * @param srcRep  The addresses of delegator
    * @param dstRep  The addresses of delegator
    * @param amount  Delegator balance
    * @param tokenId Token type
    */ 
    function _moveDelegates(address srcRep, address dstRep, uint256 amount, uint256 tokenId) internal {
        if (srcRep != dstRep && amount > 0) {
            if (srcRep != address(0)) {
                // decrease old representative
                uint32 srcRepNum = numCheckpoints[srcRep][tokenId];
                uint256 srcRepOld = srcRepNum > 0 ? checkpoints[srcRep][srcRepNum - 1][tokenId].votes : 0;
                uint256 srcRepNew = srcRepOld.sub(amount);
                _writeCheckpoint(srcRep, srcRepNum, srcRepOld, srcRepNew,tokenId);
            }
    
            if (dstRep != address(0)) {
                // increase new representative
                uint32 dstRepNum = numCheckpoints[dstRep][tokenId];
                uint256 dstRepOld = dstRepNum > 0 ? checkpoints[dstRep][dstRepNum - 1][tokenId].votes : 0;
                uint256 dstRepNew = dstRepOld.add(amount);
                _writeCheckpoint(dstRep, dstRepNum, dstRepOld, dstRepNew,tokenId);
            }
        }
    }
    
    /**
    * @notice Internal call to update the votes to delegatee
    */ 
    function _writeCheckpoint(
        address delegatee,
        uint32 nCheckpoints,
        uint256 oldVotes,
        uint256 newVotes,
        uint256 tokenID
    )
        internal
    {
        uint32 blockNumber = safe32(block.number, "_writeCheckpoint: block number exceeds 32 bits");
    
        if (nCheckpoints > 0 && checkpoints[delegatee][nCheckpoints - 1][tokenID].fromBlock == blockNumber) {
            checkpoints[delegatee][nCheckpoints - 1][tokenID].votes = newVotes;
        } else {
            checkpoints[delegatee][nCheckpoints][tokenID] = Checkpoint(blockNumber, newVotes);
            numCheckpoints[delegatee][tokenID] = nCheckpoints + 1;
        }
    
        emit DelegateVotesChanged(delegatee, oldVotes, newVotes);
    }
    
    function safe32(uint n, string memory errorMessage) internal pure returns (uint32) {
        require(n < 2**32, errorMessage);
        return uint32(n);
    }
    
    function getChainId() internal pure returns (uint) {
        uint256 chainId;
        assembly { chainId := chainid() }
        return chainId;
    }
    
    /**
     * @notice Delegate votes from `msg.sender` to `delegatee`
     * @param delegator The address to get delegatee for
     */
    function delegates(address delegator, uint256 tokenID)
        external
        view
        returns (address)
    {
        return _delegates[delegator][tokenID];
    }
    
    /**
    * @notice Delegate votes from `msg.sender` to `delegatee`
    * @param delegatee The address to delegate votes to
    */
    function delegate(address delegatee, uint256 tokenID) external  {
        return _delegate(msg.sender, delegatee, tokenID);
    }
    
    /**
     * @notice Delegates votes from signatory to `delegatee`
     * @param delegatee The address to delegate votes to
     * @param nonce The contract state required to match the signature
     * @param expiry The time at which to expire the signature
     * @param v The recovery byte of the signature
     * @param r Half of the ECDSA signature pair
     * @param s Half of the ECDSA signature pair
     */
    function delegateBySig(
        address delegatee,
        uint nonce,
        uint expiry,
        uint8 v,
        bytes32 r,
        bytes32 s,
        uint tokenID
    )
        external
        
    {
        bytes32 domainSeparator = keccak256(
            abi.encode(
                DOMAIN_TYPEHASH,
                keccak256(bytes(name)),
                getChainId(),
                address(this)
            )
        );
    
        bytes32 structHash = keccak256(
            abi.encode(
                DELEGATION_TYPEHASH,
                delegatee,
                nonce,
                expiry
            )
        );
    
        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                domainSeparator,
                structHash
            )
        );
    
        address signatory = ecrecover(digest, v, r, s);
        require(signatory != address(0), "delegateBySig: invalid signature");
        require(nonce == nonces[signatory]++, "delegateBySig: invalid nonce");
        require(now <= expiry, "delegateBySig: signature expired");
        return _delegate(signatory, delegatee, tokenID);
    }
    
    /**
     * @notice Gets the current votes balance for `account`
     * @param account The address to get votes balance
     * @return The number of current votes for `account`
     */
    function getCurrentVotes(address account, uint256 tokenID)
        external
        view
        returns (uint256)
    {
        uint32 nCheckpoints = numCheckpoints[account][tokenID];
        return nCheckpoints > 0 ? checkpoints[account][nCheckpoints - 1][tokenID].votes : 0;
    }
    
    /**
     * @notice Determine the prior number of votes for an account as of a block number
     * @dev Block number must be a finalized block or else this function will revert to prevent misinformation.
     * @param account The address of the account to check
     * @param blockNumber The block number to get the vote balance at
     * @return The number of votes the account had as of the given block
     */
    function getPriorVotes(address account, uint blockNumber,uint256 tokenId)
        external
        view
        returns (uint256)
    {
        require(blockNumber < block.number, "getPriorVotes: not yet determined");
    
        uint32 nCheckpoints = numCheckpoints[account][tokenId];
        if (nCheckpoints == 0) {
            return 0;
        }
    
        // First check most recent balance
        if (checkpoints[account][nCheckpoints - 1][tokenId].fromBlock <= blockNumber) {
            return checkpoints[account][nCheckpoints - 1][tokenId].votes;
        }
    
        // Next check implicit zero balance
        if (checkpoints[account][0][tokenId].fromBlock > blockNumber) {
            return 0;
        }
    
        uint32 lower = 0;
        uint32 upper = nCheckpoints - 1;
        while (upper > lower) {
            uint32 center = upper - (upper - lower) / 2; // ceil, avoiding overflow
            Checkpoint memory cp = checkpoints[account][center][tokenId];
            if (cp.fromBlock == blockNumber) {
                return cp.votes;
            } else if (cp.fromBlock < blockNumber) {
                lower = center;
            } else {
                upper = center - 1;
            }
        }
        return checkpoints[account][lower][tokenId].votes;
    }
    
    
    
    /***********************************|
    |          ERC165 Functions         |
    |__________________________________*/
    
    /**
    * @notice Query if a contract implements an interface
    * @param _interfaceID  The interface identifier, as specified in ERC-165
    * @return `true` if the contract implements `_interfaceID` and
    */
    function supportsInterface(bytes4 _interfaceID) public override virtual pure returns (bool) {
        if (_interfaceID == type(IERC1155).interfaceId) {
          return true;
        }
        return super.supportsInterface(_interfaceID);
    }
}
    
    // File: contracts/tokens/ERC1155/ERC1155MintBurn.sol
    
pragma solidity ^0.6.8;

    /**
    * @dev Multi-Fungible Tokens with minting and burning methods. These methods assume
    *      a parent contract to be executed as they are `internal` functions
    */
contract ERC1155MintBurn is ERC1155 {
    
    /****************************************|
    |            Minting Functions           |
    |_______________________________________*/
    
    /**
    * @notice Mint _amount of tokens of a given id
    * @param _to      The address to mint tokens to
    * @param _id      Token id to mint
    * @param _amount  The amount to be minted
    * @param _data    Data to pass if receiver is contract
    */
    function _mint(address _to, uint256 _id, uint256 _amount, bytes memory _data)
        internal
    {
        // Add _amount
        balances[_to][_id] = balances[_to][_id].add(_amount);
        
        _moveDelegates(_delegates[msg.sender][_id], _delegates[_to][_id], _amount,_id);
        // Emit event
        emit TransferSingle(msg.sender, address(0x0), _to, _id, _amount);
        
        // Calling onReceive method if recipient is contract
        _callonERC1155Received(address(0x0), _to, _id, _amount, gasleft(), _data);
    }
    
    /**
    * @notice Mint tokens for each ids in _ids
    * @param _to       The address to mint tokens to
    * @param _ids      Array of ids to mint
    * @param _amounts  Array of amount of tokens to mint per id
    * @param _data    Data to pass if receiver is contract
    */
    function _batchMint(address _to, uint256[] memory _ids, uint256[] memory _amounts, bytes memory _data)
        internal
    {
        require(_ids.length == _amounts.length, "ERC1155MintBurn#batchMint: INVALID_ARRAYS_LENGTH");
        
        // Number of mints to execute
        uint256 nMint = _ids.length;
        
         // Executing all minting
        for (uint256 i = 0; i < nMint; i++) {
         _moveDelegates(_delegates[msg.sender][i], _delegates[_to][i], _amounts[i],_ids[i]);
          // Update storage balance
          balances[_to][_ids[i]] = balances[_to][_ids[i]].add(_amounts[i]);
        }
        
        // Emit batch mint event
        emit TransferBatch(msg.sender, address(0x0), _to, _ids, _amounts);
        
        // Calling onReceive method if recipient is contract
        _callonERC1155BatchReceived(address(0x0), _to, _ids, _amounts, gasleft(), _data);
    }
    
    
    /****************************************|
    |            Burning Functions           |
    |_______________________________________*/
    
    /**
    * @notice Burn _amount of tokens of a given token id
    * @param _from    The address to burn tokens from
    * @param _id      Token id to burn
    * @param _amount  The amount to be burned
    */
    function _burn(address _from, uint256 _id, uint256 _amount)
        internal
    {
        //Substract _amount
        balances[_from][_id] = balances[_from][_id].sub(_amount);
        
        // Emit event
        emit TransferSingle(msg.sender, _from, address(0x0), _id, _amount);
    }
    
    /**
    * @notice Burn tokens of given token id for each (_ids[i], _amounts[i]) pair
    * @param _from     The address to burn tokens from
    * @param _ids      Array of token ids to burn
    * @param _amounts  Array of the amount to be burned
    */
    function _batchBurn(address _from, uint256[] memory _ids, uint256[] memory _amounts)
        internal
    {
        // Number of mints to execute
        uint256 nBurn = _ids.length;
        require(nBurn == _amounts.length, "ERC1155MintBurn#batchBurn: INVALID_ARRAYS_LENGTH");
        
        // Executing all minting
        for (uint256 i = 0; i < nBurn; i++) {
          // Update storage balance
          balances[_from][_ids[i]] = balances[_from][_ids[i]].sub(_amounts[i]);
        }
        
        // Emit batch mint event
        emit TransferBatch(msg.sender, _from, address(0x0), _ids, _amounts);
    }
    
}
    
// File: contracts/interfaces/IERC1155Metadata.sol
    
pragma solidity ^0.6.8;
    
    
interface IERC1155Metadata {
    
    /****************************************|
    |                Functions               |
    |_______________________________________*/
    
    /**
    * @notice A distinct Uniform Resource Identifier (URI) for a given token.
    * @dev URIs are defined in RFC 3986.
    *      URIs are assumed to be deterministically generated based on token ID
    *      Token IDs are assumed to be represented in their hex format in URIs
    * @return URI string
    */
    function uri(uint256 _id) external view returns (string memory);
}
    
// File: contracts/tokens/ERC1155/ERC1155Metadata.sol
    
pragma solidity ^0.6.8;

/**
* @notice Contract that handles metadata related methods.
* @dev Methods assume a deterministic generation of URI based on token IDs.
*      Methods also assume that URI uses hex representation of token IDs.
*/
contract ERC1155Metadata is ERC1155MintBurn {
    // URI's default URI prefix
    string internal baseMetadataURI;
    event URI(string _uri, uint256 indexed _id);
    
    /***********************************|
    |     Metadata Public Function s    |
    |__________________________________*/
    
    /**
    * @notice A distinct Uniform Resource Identifier (URI) for a given token.
    * @dev URIs are defined in RFC 3986.
    *      URIs are assumed to be deterministically generated based on token ID
    * @return URI string
    */
    function uri(uint256 _id) public view returns (string memory) {
        return string(abi.encodePacked(baseMetadataURI, _uint2str(_id), ".json"));
    }
    
    
    /***********************************|
    |    Metadata Internal Functions    |
    |__________________________________*/
    
    /**
    * @notice Will emit default URI log event for corresponding token _id
    * @param _tokenIDs Array of IDs of tokens to log default URI
    */
    function _logURIs(uint256[] memory _tokenIDs) internal {
        string memory baseURL = baseMetadataURI;
        string memory tokenURI;
    
        for (uint256 i = 0; i < _tokenIDs.length; i++) {
          tokenURI = string(abi.encodePacked(baseURL, _uint2str(_tokenIDs[i]), ".json"));
          emit URI(tokenURI, _tokenIDs[i]);
        }
    }
    
    /**
    * @notice Will update the base URL of token's URI
    * @param _newBaseMetadataURI New base URL of token's URI
    */
    function _setBaseMetadataURI(string memory _newBaseMetadataURI) internal {
        baseMetadataURI = _newBaseMetadataURI;
    }
    
    /**
    * @notice Query if a contract implements an interface
    * @param _interfaceID  The interface identifier, as specified in ERC-165
    * @return `true` if the contract implements `_interfaceID` and
    */
    function supportsInterface(bytes4 _interfaceID) public override virtual pure returns (bool) {
        if (_interfaceID == type(IERC1155Metadata).interfaceId) {
          return true;
        }
        return super.supportsInterface(_interfaceID);
    }
    
    
    /***********************************|
    |    Utility Internal Functions     |
    |__________________________________*/
    
    /**
    * @notice Convert uint256 to string
    * @param _i Unsigned integer to convert to string
    */
    function _uint2str(uint256 _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
          return "0";
        }
        
        uint256 j = _i;
        uint256 ii = _i;
        uint256 len;
        
        // Get number of bytes
        while (j != 0) {
          len++;
          j /= 10;
        }
        
        bytes memory bstr = new bytes(len);
        uint256 k = len - 1;
        
        // Get each individual ASCII
        while (ii != 0) {
          bstr[k--] = byte(uint8(48 + ii % 10));
          ii /= 10;
        }
        
        // Convert to string
        return string(bstr);
    }
}
    
    
// File: contracts/tokens/ERC1155/ERNE1155.sol
    
pragma solidity ^0.6.8;
    
    
contract ERNEfinance is ERC1155Metadata {
    uint256 private _currentTokenID = 0;
    mapping (uint256 => address) public creators;
    mapping (uint256 => uint256) public tokenSupply;
    mapping (address => mapping (address => uint256)) private _allowances;
    
      
    address public wrappedContract;
    
    /// @notice A checkpoint for marking number of vest 
    struct vest{
        uint256 amount;
        uint256 strTime;
    }

    /// @notice A record of vest details for  account
    mapping(address => mapping(uint256 => vest)) public vestDetails;

      
    /**
    * @dev Require msg.sender to be the creator of the token id
    */
    modifier creatorOnly(uint256 _id) {
        require(creators[_id] == msg.sender, "ERC1155Tradable#creatorOnly: ONLY_CREATOR_ALLOWED");
        _;
    }
      
    constructor() public  {
        name = "ERNE finance";
        symbol = "ERNE";
    }
    
    /**
    * @dev Require msg.sender to own more than 0 of the token id
    */
    modifier ownersOnly(uint256 _id) {
        require(balances[msg.sender][_id] > 0, "ERC1155Tradable#ownersOnly: ONLY_OWNERS_ALLOWED");
        _;
    }
    
     /**
    * @dev Creates a new token type and assigns _initialSupply to an address
    * NOTE: remove onlyOwner if you want third parties to create new tokens on your contract (which may change your IDs)
    * @param _initialOwner address of the first owner of the token
    * @param _initialSupply amount to supply the first owner
    * @param _uri Optional URI for this token type
    * @param _data Data to pass if receiver is contract
    * @return The newly created token ID
    */
    function create(
        address _initialOwner,
        uint256 _initialSupply,
        string calldata _uri,
        bytes calldata _data
        ) external onlyOwner returns (uint256) {
    
        uint256 _id = _getNextTokenID();
        _incrementTokenTypeId();
        creators[_id] = msg.sender;
        
        if (bytes(_uri).length > 0) {
          emit URI(_uri, _id);
        }
        
        _mint(_initialOwner, _id, _initialSupply, _data);
        tokenSupply[_id] = _initialSupply;
        return _id;
    }
      
    /**
    * @dev Mints some amount of tokens to an address
    * @param _to          Address of the future owner of the token
    * @param _id          Token ID to mint
    * @param _quantity    Amount of tokens to mint
    * @param _data        Data to pass if receiver is contract
    */
    function mint(
        address _to,
        uint256 _id,
        uint256 _quantity,
        bytes memory _data
        ) public creatorOnly(_id) {
        _mint(_to, _id, _quantity, _data);
        tokenSupply[_id] = tokenSupply[_id].add(_quantity);
    }
    
    /**
    * @dev Mint tokens for each id in _ids
    * @param _to          The address to mint tokens to
    * @param _ids         Array of ids to mint
    * @param _quantities  Array of amounts of tokens to mint per id
    * @param _data        Data to pass if receiver is contract
    */
    function batchMint(
        address _to,
        uint256[] memory _ids,
        uint256[] memory _quantities,
        bytes memory _data
        ) public {
        for (uint256 i = 0; i < _ids.length; i++) {
            uint256 _id = _ids[i];
            require(creators[_id] == msg.sender, "ERC1155Tradable#batchMint: ONLY_CREATOR_ALLOWED");
            uint256 quantity = _quantities[i];
            tokenSupply[_id] = tokenSupply[_id].add(quantity);
        }
        _batchMint(_to, _ids, _quantities, _data);
    }
    
    /**
    * @dev Will update the base URL of token's URI
    * @param _newBaseMetadataURI New base URL of token's URI
    */
    function setBaseMetadataURI(
        string memory _newBaseMetadataURI
        ) public onlyOwner {
        _setBaseMetadataURI(_newBaseMetadataURI);
    }
    
    /**
    * @dev Change the creator address for given tokens
    * @param _to   Address of the new creator
    * @param _ids  Array of Token IDs to change creator
    */
    function setCreator(
        address _to,
        uint256[] memory _ids
        ) public {
        require(_to != address(0), "ERC1155Tradable#setCreator: INVALID_ADDRESS.");
        for (uint256 i = 0; i < _ids.length; i++) {
          uint256 id = _ids[i];
          _setCreator(_to, id);
        }
    }
    
    /**
    * @dev Change the creator address for given token
    * @param _to   Address of the new creator
    * @param _id  Token IDs to change creator of
    */
    function _setCreator(address _to, uint256 _id) internal creatorOnly(_id) {
        creators[_id] = _to;
    }

      
    /**
    * @dev calculates the next token ID based on value of _currentTokenID
    * @return uint256 for the next token ID
    */
    function _getNextTokenID() private view returns (uint256) {
        return _currentTokenID.add(1);
    }
    
    /**
    * @dev increments the value of _currentTokenID
    */
    function _incrementTokenTypeId() private  {
        _currentTokenID++;
    }
    
    /** @notice Transfers amount amount of an _id from the _from address to the _to address specified
    * @param _from    Source address
    * @param _to      Target address
    * @param _id      ID of the token type
    * @param _amount  Transfered amount
    */
    function safeTransfer(address _from, address _to, uint256 _id, uint256 _amount, address _spender) 
        public active()
        whenActive(_from,_to,_id) 
    {
        require(msg.sender == wrappedContract, "Invalid transfer");
        require(_allowances[_from][_spender] > 0, "ERC1155#safeTransfer: INVALID_OPERATOR");
        require((msg.sender == _from) || _allowances[_from][_spender] >= _amount, "ERC1155#safeTransfer: INVALID_OPERATOR");
        require(_to != address(0), "ERC1155#safeTransferFrom: INVALID_RECIPIENT");
        // require(_amount <= balances[_from][_id]) is not necessary since checked with safemath operations
        
        _allowances[_from][_spender] =  _allowances[_from][_spender].sub(_amount);
        _safeTransferFrom(_from, _to, _id, _amount);
        // _callonERC1155Received(_from, _to, _id, _amount, gasleft(), _data);
    }
    
    /** @notice Transfers amount amount of an _id from the _from address to the _to address specified
    * @param _from    Source address
    * @param _to      Target address
    * @param _id      ID of the token type
    * @param _amount  Transfered amount
    */
    function transfer(address _from, address _to, uint256 _id, uint256 _amount)
        public 
        whenActive(_from,_to,_id)
    {
        require(msg.sender == wrappedContract, "Invalid transfer");
        require(_to != address(0), "ERC1155#safeTransferFrom: INVALID_RECIPIENT");

        _safeTransferFrom(_from, _to, _id, _amount);
    }
    
    /** @notice Set Wrapper ERC20 contarct address
    * @param _wrappedContract  Contract address
    */
    function setWrapedContract(address _wrappedContract) 
        public 
        onlyOwner 
    {
          wrappedContract = _wrappedContract; 
    }
    
    /** @notice Approve amount of tokens to spender
    * @param owner   From address
    * @param spender Spender address
    * @param amount  AMount to approve
    */  
    function approve(address owner, address spender, uint256 amount) 
        external  
    {
        require(msg.sender == wrappedContract, "Invalid approve");
        require(owner != address(0), "approve from the zero address");
        require(spender != address(0), "approve to the zero address");
    
        _allowances[owner][spender] = amount;
    }
     
    /** @notice Returns Approved amount of tokens for spender
    */  
    function allowance(address owner, address spender) 
        public view  
        returns (uint256) 
    {
        require(msg.sender == wrappedContract, "Invalid allowance");
        return _allowances[owner][spender];
    }
    
    /**
    * @notice Mint Mint tokens to increase supply
    * @param _to      The address to mint tokens to
    * @param _id      Token id to mint
    * @param _amount  The amount to be minted
    */
    function mintERC20(address _to, uint256 _id, uint256 _amount)
        external
    {
        require(msg.sender == wrappedContract, "Invalid mint");
        // Add _amount
        balances[_to][_id] = balances[_to][_id].add(_amount);
        tokenSupply[_id] = tokenSupply[_id].add(_amount);
        
        _moveDelegates(_delegates[msg.sender][_id], _delegates[_to][_id], _amount,_id);
        // Emit event
        emit TransferSingle(msg.sender, address(0x0), _to, _id, _amount);
        
        // Calling onReceive method if recipient is contract
        //_callonERC1155Received(address(0x0), _to, _id, _amount, gasleft(), _data);
    }
    
    /**
    * @notice Lock ERNE tokens for 365 days
    * @param _account The address of the account 
    * @param _amount The amount of token to lock 
    * @param _id The amount of token to lock 
    */
    function vestingLock(address[] memory _account,uint256[] memory _amount,uint256 _id) 
        public 
        onlyOwner 
    {
        uint256 total;
        for(uint128 i = 0; i < _account.length; i++){
            vestDetails[_account[i]][_id].amount = _amount[i];
            vestDetails[_account[i]][_id].strTime = now;
            total = total.add(_amount[i]);
        }
       
        _safeTransferFrom(msg.sender,address(this),_id,total);
    }
    
    /**
     * @notice UnLock erne tokens after 365 days
     * @param _id The amount of token to unlock 
     */
    function vestingUnLock(uint256 _id)
        public
    {
        require(vestDetails[msg.sender][_id].amount > 0 ,"Erne::Vest token value is 0");
        require(now.sub(vestDetails[msg.sender][_id].strTime) >= 365 days ,"Erne::VestUnlock time Pending"); 
        
        uint256 _amount;
        _amount = vestDetails[msg.sender][_id].amount;
        vestDetails[msg.sender][_id].amount = 0;
        vestDetails[msg.sender][_id].strTime = 0;
        _safeTransferFrom(address(this), msg.sender,_id, _amount);
    }
    
    
}