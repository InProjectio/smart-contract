// SPDX-License-Identifier: MIT
// Copyright © 2021 InProject

pragma solidity ^0.8.6;
pragma experimental ABIEncoderV2;

contract SuperAdmin {
    address private superAdmin;
    address private previousAdmin;

    event SuperAdminTransferred(address indexed previousAdmin, address indexed newAdmin);

    constructor () {
        address msgSender = msg.sender;
        superAdmin = msgSender;
        emit SuperAdminTransferred(address(0), msgSender);
    }

    function adminAddress() public view returns (address) {
        return superAdmin;
    }

    modifier onlySuperAdmin() {
        require(msg.sender == superAdmin, "Ownable: caller is not the superAdmin");
        _;
    }

    function transferAdmin(address newAdmin) public virtual onlySuperAdmin {
        require(newAdmin != address(0), "Ownable: new superAdmin is the zero address");
        emit SuperAdminTransferred(superAdmin, newAdmin);
        superAdmin = newAdmin;
    }
}