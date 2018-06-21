import {ToonBase} from "./ToonBase";

export class ToonMinting extends ToonBase {

    constructor(instance) {
        super(instance)
    }

    /**
     * @returns {Promise<number>}
     */
    promoToonsMinted = async () => parseInt(await this.wrapped.promoToonsMinted());

    /**
     *
     * @param {number} genes - uint256
     * @param {string} owner - address that will be given a new toon
     * @param options
     * @returns {Promise<void>}
     */
    createPromoToon = async(genes, owner, options = {}) => {
        return await this.wrapped.createPromoToon(genes, owner, options);
    }
}