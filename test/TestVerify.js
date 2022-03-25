const {
    shouldFail,
    constants,
    expectEvent,
    BN
} = require('openzeppelin-test-helpers');

const chai = require('chai');
chai.use(require('chai-as-promised'));
chai.should();

const Verify_Factory = artifacts.require('Verify');


contract('Verify', accounts => {
    const [owner, alice, bob, eve, ...others] = accounts;
    console.log("owner address: ",owner);

    beforeEach(async () => {
        VerifyInst = await Verify_Factory.new();

    });


    // 命令： truffle test ./test/TestVerify.js
    describe('#verify', () => {
        it('VerifyMessage', async () => {

            let hashMessage="0x1c8aff950685c2ed4bc3174f3472287b56d9517b9c948127319a09a7a36deac8";
            let r ="0x81a650be2d7eb06ef01a8fd13743d1dad55a1a391ebacbb2f4316b65f9031e1a";
            let s ="0x4c6b117756015bf51160e090d2036ba130d33c3ed17945bf4749194a9be4d1db"
            let v =27;

            let foo=await VerifyInst.VerifyMessage(hashMessage,v,r,s);
            console.log("pub address:",foo.toString());  // 得到的地址就是原来签名该信息的地址

            const events = await VerifyInst.getPastEvents();
            //console.log(events);
            events.forEach((e,i)=>{
                console.log(`event index[${i}]: ${e.args.message}`)
            })
        });


    });





});
