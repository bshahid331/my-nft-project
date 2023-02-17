
import MyFunNFT from "../contracts/MyFunNFT.cdc"

pub fun main(id: UInt64): MyFunNFT.Edition? {
    return MyFunNFT.getEdition(id: id)
}