// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Twitter {

    uint16 public MAX_TWEET_LENGTH = 280;

    struct Tweet {
        uint256 id; 
        address author;
        string tweet;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[] ) public tweets;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of this contract!!!");
        _;
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function createTweet(string memory _tweet) public {

        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long bro");

        // Tweet memory newTweet = Tweet({
        //     id: tweets[msg.sender].length,
        //     author: msg.sender,
        //     tweet: _tweet,
        //     timestamp: block.timestamp,
        //     likes: 0
        // });

        // BELOW AND ABOVE BOTH ARE SAME

        Tweet memory newTweet;
        newTweet.id = tweets[msg.sender].length;
        newTweet.author = msg.sender;
        newTweet.tweet = _tweet;
        newTweet.timestamp = block.timestamp;
        newTweet.likes = 0;

        tweets[msg.sender].push(newTweet);
    }

    function likeTweet(uint256 id, address author) external {
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST!");
        tweets[author][id].likes++;
    }

    function unlikeTweet(uint256 id, address author) external {
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST!");
        require(tweets[author][id].likes > 0, "There are no likes");
        tweets[author][id].likes--;
    }

    // below function returns only a single struct containing the tweet info of one specific owner only that is why it is TWEET only
    function getTweet(uint _i) public view returns (Tweet memory){
        return tweets[msg.sender][_i];
    }

    // below function return an array as it returns all tweet meaning all structs inside that array that is why it's TWEET[]
    function getAllTweet(address _owner) public view returns (Tweet[] memory){
        return tweets[_owner];
    }

    
}





