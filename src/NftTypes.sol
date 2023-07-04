//SPDX-License-Identifier:MIT
pragma solidity ^0.8.16;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract NftTypes is ERC721 {
    error NftTypes_MaxSupplyExceeded();
    mapping(uint256 => string) private s_imageURIs;
    uint256 public constant totalSupply = 20;
    uint256 private s_currentSupply;

    constructor() ERC721("BNft", "BasicNft ") {}

    function mint(string memory image_url) public returns (uint256 tokenId) {
        tokenId = s_currentSupply + 1;
        if (tokenId > totalSupply) {
            revert NftTypes_MaxSupplyExceeded();
        }
        _mint(msg.sender, tokenId);
        s_imageURIs[tokenId] = image_url;
        s_currentSupply++;
        return tokenId;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '","description":',
                                '"This is an example NFT"',
                                ',"image":"',
                                s_imageURIs[tokenId],
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function getImageUri(uint256 tokenId) public view returns (string memory) {
        return s_imageURIs[tokenId];
    }
}
