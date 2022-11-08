// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;

    struct farmer{
        uint f_id;
        string f_name;
        string f_email;
        uint f_phone;
        string f_password;
        string f_location;
    }

    struct distributor{
        uint d_id;
        string d_name;
        string d_email;
        uint d_phone;
        string d_password;
        string d_location;
    }

    struct retailer{
        uint r_id;
        string r_name;
        string r_email;
        uint r_phone;
        string r_password;
        string r_location;
    }

    struct product{
        uint batch_id;
        string productName;
        string desc;
        string productType;
        string farmer;
        string distributor;
        string retailer;
    }

contract main{


    farmer public f;
    distributor public d;
    retailer public r;
    product public p;

// ---------------------------------------Farmer Section-----------------------------------//

    constructor(uint fid, string memory fname, string memory femail,string memory flocation, uint fphone, string memory fpass){
        f.f_id = fid;
        f.f_name = fname;
        f.f_email = femail;
        f.f_location = flocation;
        f.f_phone = fphone;
        f.f_password = fpass;

    }
    enum State{allowed,not_allowed,wait}

    State public farmerState = State.allowed;
    State public DistributorState = State.not_allowed;
    State public RetailerState = State.not_allowed;


    string public product_name;
    string public product_type;
    string public description;

    function cropRegistration(
        string memory productname,
        string memory producttype, 
        string memory descript
        ) public returns(
            string memory, 
            uint, 
            string memory, 
            string memory,
            string memory, 
            string memory)
            {

            string memory farmername = f.f_name;
            uint farmerphone = f.f_phone;   
            string memory farmerlocation = f.f_location;
            product_name = productname;
            product_type = producttype;
            description = descript; 
             
            // if(farmerState == State.not_allowed){
            //     farmerState = State.allowed;
            // }
            return (farmername, farmerphone, farmerlocation, product_name, product_type, description);        
    }

    function addFarmertoProduct() public returns(string memory){
        if(farmerState == State.allowed){
            p.productName = product_name;
            p.productType = product_type;
            p.desc = description;
            p.farmer = f.f_name;
            
            return("Farmer Details are Updated Successfully!!!");
        }
        else{
            revert("Something went wrong in Farmer's state");
        }
    }

    function soldtoDistrubutor() public returns(string memory){
        if(farmerState == State.allowed){
            p.distributor = d.d_name;
            DistributorState = State.allowed;
            return("Farmer Sold product to Distributor Successfully!!!!"); 
        }
        else{
            revert("Transaction between farmer and distributor not happened");
        }
    }


//-------------------------------Distributer Section------------------------//

    function distributorDetails(uint did, string memory dname, string memory demail, string memory dlocation, uint dphone, string memory dpassword) public{
        uint d_id = did;
        string memory d_name = dname;
        string memory d_email = demail;
        string memory d_location = dlocation;
        uint d_phone = dphone;
        string memory d_password = dpassword;
        d.d_id = d_id;
        d.d_name = d_name;
        d.d_email = d_email;
        d.d_location = d_location;
        d.d_phone = d_phone;
        d.d_password = d_password;

    }

    function distributorBatch(uint batchId) public returns(string memory){
        if(DistributorState == State.allowed && farmerState == State.allowed ){
            p.batch_id = batchId;
            DistributorState = State.wait;
            return("Batch Id is assigned to the product");    
        }
        else{
            revert("Not Assigned Batch ID");
        }
    }

    function selltoRetailer() public returns(string memory){
        if(DistributorState == State.wait && farmerState == State.allowed){
            p.retailer = r.r_name;
            RetailerState = State.allowed;
            return("Distributor sold product to retailer");
        }
        else{
            revert("Transaction between distributor and retailer not happened");
        }
    }
    

//---------------------------------------------------retailerDetails--------------------------------------//

    function retailerDetails(uint rid, string memory rname, string memory remail, string memory rlocation, uint rphone, string memory rpassword) public{
        uint r_id = rid;
        string memory r_name = rname;
        string memory r_email = remail;
        string memory r_location = rlocation;
        uint r_phone = rphone;
        string memory r_password = rpassword;
        r.r_id = r_id;
        r.r_name = r_name;
        r.r_email = r_email;
        r.r_location = r_location;
        r.r_phone = r_phone;
        r.r_password = r_password;

    }
    
    // function transactionBetweenFarmertoDistributor() public pure {
       
    // }
    function productResult() public view returns(uint, string memory, string memory, string memory, string memory, string memory, string memory){
        return(
            p.batch_id,
            p.productName,
            p.desc,
            p.productType,
            p.farmer,
            p.distributor,
            p.retailer
        );
    }

}