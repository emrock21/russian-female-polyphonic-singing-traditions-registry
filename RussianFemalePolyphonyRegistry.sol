// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract RussianFemalePolyphonyRegistry {

    struct PolyphonyTradition {
        string styleName;           // Belgorod white voice, Bryansk dense polyphony, Don Cossack style
        string region;              // Belgorod, Bryansk, Kursk, Don, etc.
        string vocalTechnique;      // white voice, open throat, dense harmony, drone-based
        string musicalFeatures;     // modal scales, dissonance, parallel intervals
        string performanceContext;  // weddings, harvest, funerals, seasonal rituals
        string linguisticFeatures;  // dialect, phonetics, archaic vocabulary
        string uniqueness;          // regional identity, rare techniques
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct PolyphonyInput {
        string styleName;
        string region;
        string vocalTechnique;
        string musicalFeatures;
        string performanceContext;
        string linguisticFeatures;
        string uniqueness;
    }

    PolyphonyTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event PolyphonyRecorded(uint256 indexed id, string styleName, address indexed creator);
    event PolyphonyVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            PolyphonyTradition({
                styleName: "Example (replace manually)",
                region: "example",
                vocalTechnique: "example",
                musicalFeatures: "example",
                performanceContext: "example",
                linguisticFeatures: "example",
                uniqueness: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordPolyphony(PolyphonyInput calldata p) external {
        traditions.push(
            PolyphonyTradition({
                styleName: p.styleName,
                region: p.region,
                vocalTechnique: p.vocalTechnique,
                musicalFeatures: p.musicalFeatures,
                performanceContext: p.performanceContext,
                linguisticFeatures: p.linguisticFeatures,
                uniqueness: p.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit PolyphonyRecorded(traditions.length - 1, p.styleName, msg.sender);
    }

    function votePolyphony(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        PolyphonyTradition storage p = traditions[id];

        if (like) p.likes++;
        else p.dislikes++;

        emit PolyphonyVoted(id, like, p.likes, p.dislikes);
    }

    function totalPolyphony() external view returns (uint256) {
        return traditions.length;
    }
}
