
pragma solidity ^0.8.0;

contract CertificateRegistry {
    

    address public owner;

    mapping(address => string) public certificates;

  
    event CertificateIssued(address indexed student, string certificateDetails);

  
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Samo administrator moze izvrsiti ovu akciju!");
        _;
    }

   
    function issueCertificate(address _student, string calldata _details) external onlyOwner {
       
        require(_student != address(0), "Nevazeca adresa studenta!");
        require(bytes(_details).length > 0, "Detalji sertifikata ne smeju biti prazni!");

        certificates[_student] = _details;

      
        emit CertificateIssued(_student, _details);
    }

    
    function getCertificate(address _student) public view returns (string memory) {
        string memory cert = certificates[_student];
        
        
        if (bytes(cert).length == 0) {
            return "Sertifikat nije pronadjen za ovu adresu.";
        }
        
        return cert;
    }
}