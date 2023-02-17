import MyFunNFT from "../contracts/MyFunNFT.cdc"
import MetadataViews from "../contracts/MetadataViews.cdc"
import NonFungibleToken from "../contracts/NonFungibleToken.cdc"

transaction(
    editionID: UInt64,
) {
    let MyFunNFTCollection: &MyFunNFT.Collection{MyFunNFT.MyFunNFTCollectionPublic,NonFungibleToken.CollectionPublic,NonFungibleToken.Receiver,MetadataViews.ResolverCollection}

    prepare(signer: AuthAccount) {
        if signer.borrow<&MyFunNFT.Collection>(from: MyFunNFT.CollectionStoragePath) == nil {
            // Create a new empty collection
            let collection <- MyFunNFT.createEmptyCollection()

            // save it to the account
            signer.save(<-collection, to: MyFunNFT.CollectionStoragePath)

            // create a public capability for the collection
            signer.link<&{NonFungibleToken.CollectionPublic, MyFunNFT.MyFunNFTCollectionPublic, MetadataViews.ResolverCollection}>(
                MyFunNFT.CollectionPublicPath,
                target: MyFunNFT.CollectionStoragePath
            )
        }
        self.MyFunNFTCollection = signer.borrow<&MyFunNFT.Collection{MyFunNFT.MyFunNFTCollectionPublic,NonFungibleToken.CollectionPublic,NonFungibleToken.Receiver,MetadataViews.ResolverCollection}>(from: MyFunNFT.CollectionStoragePath)!
    }

    execute {        
        let item <- MyFunNFT.mintNFT(editionID: editionID)
        self.MyFunNFTCollection.deposit(token: <-item)
    }
}