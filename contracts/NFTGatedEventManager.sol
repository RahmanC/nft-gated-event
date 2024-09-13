// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTGatedEventManager is ERC721, Ownable(msg.sender) {
    struct Event {
        string eventName;
        uint eventDate;
        uint capacity;
        uint nftId;  // NFT required for access
        mapping(address => bool) attendees;
    }

    // Events
    mapping(uint => Event) public events;
    uint public eventCount;

    constructor() ERC721("EventTicket", "ETK") {}

    // Create a new event
    function createEvent(string memory _eventName, uint _eventDate, uint _capacity, uint _nftId) public onlyOwner {
        eventCount++;
        Event storage newEvent = events[eventCount];
        newEvent.eventName = _eventName;
        newEvent.eventDate = _eventDate;
        newEvent.capacity = _capacity;
        newEvent.nftId = _nftId;
    }

    // Update NFT requirement for an event
    function updateEventNFT(uint eventId, uint _nftId) public onlyOwner {
        Event storage eventDetail = events[eventId];
        eventDetail.nftId = _nftId;
    }

    // Register attendee with NFT ownership for a specific event
    function registerAttendee(uint eventId, address attendee, uint _nftId) public {
        Event storage eventDetail = events[eventId];
        require(eventDetail.nftId == _nftId, "Invalid NFT for this event");
        require(!eventDetail.attendees[attendee], "Already registered");
        require(eventDetail.capacity > 0, "Event full");

        eventDetail.attendees[attendee] = true;
        eventDetail.capacity--;
    }

    // Verify attendee NFT ownership for a specific event
    function verifyAttendee(uint eventId, address attendee) public view returns (bool) {
        return events[eventId].attendees[attendee];
    }

   
}
