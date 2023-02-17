import MyFunNFT from "../contracts/MyFunNFT.cdc"

transaction(
    name: String,
    description: String,
) {

    prepare(signer: AuthAccount) {
    }

    execute {        
        MyFunNFT.createEdition(name: name, description: description)
    }
}