// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

contract AccessControl {
    event GrantRole(bytes32 indexed _role, address indexed _user);
    event RevokeRole(bytes32 indexed _role, address indexed _user);

    mapping(bytes32 => mapping(address => bool)) public roles;

    bytes32 constant public ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 constant public USER = keccak256(abi.encodePacked("USER"));

    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender] == true, "not authorised");
        _;
    }

    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes32 _role, address _user) internal {
        roles[_role][_user] = true;
        emit GrantRole(_role, _user);
    }

    function grantRole(bytes32 _role, address _user) external onlyRole(ADMIN) {
        _grantRole(_role, _user);
    }

    function _revokeRole(bytes32 _role, address _user) external onlyRole(ADMIN) {
        roles[_role][_user] = false;
        emit RevokeRole(_role, _user);
    }
}
