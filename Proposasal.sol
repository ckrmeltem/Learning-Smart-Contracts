// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Ornek {

    address Owner;

    struct Counter {
        uint number;
        string description;
    }

    Sayici sayac;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can increment or decrement the counter");
        _;
    }

    constructor(uint initial_value, string memory description) {
        owner = msg.sender;
        counter = Counter(initial_value, description);
    }

    // Sayacı artırmak için kullanılan fonksiyon, sadece owner tarafından çağrılabilir
    function increment_counter() external onlyOwner {
        counter.number += 1;
    }

    // Sayacı azaltmak için kullanılan fonksiyon, sadece Owner tarafından çağrılabilir
    function decrement_counter() external onlyOwner {
        sayac.sayi -= 1;
    }

    // Sayacın mevcut değerini almak için kullanılan fonksiyon
    function get_counter_value() external view returns(uint) {
        return sayac.sayi;
    }

    // Sayacın açıklama bilgisini almak için kullanılan fonksiyon
    function get_description() external view returns (string memory) {
        return counter.description;
    }
}
