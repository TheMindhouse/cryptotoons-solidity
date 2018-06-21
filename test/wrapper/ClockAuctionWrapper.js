import {ClockAuctionBase} from "./ClockAuctionBase";

export class ClockAuctionWrapper extends ClockAuctionBase {

    constructor(instance) {
        super(instance)
    }

    /**
     *
     * @param {string} contractAddress
     * @param {number} tokenId
     * @param {number} startingPrice
     * @param {number} endingPrice
     * @param {number}duration
     * @param {string} seller
     * @param options
     * @returns {Promise<void>}
     */
    createAuction = async (contractAddress, tokenId, startingPrice, endingPrice,
                           duration, seller, options = {}) =>
        await this.wrapped.createAuction(contractAddress, tokenId, startingPrice, endingPrice, duration, seller, options);

    /**
     * @param {string} contractAddress
     * @param {number} tokenId
     * @param options
     * @returns {Promise<void>}
     */
    bid = async (contractAddress, tokenId, options = {}) =>
        await this.wrapped.bid(contractAddress, tokenId, options);

    /**
     * @param {string} contractAddress
     * @param {number} tokenId
     * @param options
     * @returns {Promise<void>}
     */
    cancelAuction = async (contractAddress, tokenId, options = {}) =>
        await this.wrapped.cancelAuction(contractAddress, tokenId, options);

    /**
     *
     * @param {string} contractAddress
     * @param {number} tokenId
     * @returns {Promise<{seller: string, startingPrice: BigNumber, endingPrice: BigNumber, duration: BigNumber, startedAt: BigNumber}>}
     */
    getAuction = async (contractAddress, tokenId) => {
        let result = await this.wrapped.getAuction(contractAddress, tokenId);
        return {
            seller: result[0],
            startingPrice: result[1],
            endingPrice: result[2],
            duration: result[3],
            startedAt: result[4]
        };
    };

    /**
     *
     * @param {string} contractAddress
     * @param {number} tokenId
     * @returns {Promise<BigNumber>}
     */
    getCurrentPrice = async (contractAddress, tokenId) => await this.wrapped.getCurrentPrice(contractAddress, tokenId);

}