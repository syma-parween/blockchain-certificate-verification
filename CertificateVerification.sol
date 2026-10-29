// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CertificateVerification {
    address public admin;

    struct Certificate {
        string studentName;
        string course;
        bool exists;
    }

    mapping(string => Certificate) private certificates;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function registerCertificate(
        string memory certificateId,
        string memory studentName,
        string memory course
    ) public onlyAdmin {
        require(bytes(certificateId).length > 0, "Certificate ID required");
        require(bytes(studentName).length > 0, "Student name required");
        require(bytes(course).length > 0, "Course required");
        require(
            !certificates[certificateId].exists,
            "Certificate already exists"
        );

        certificates[certificateId] = Certificate({
            studentName: studentName,
            course: course,
            exists: true
        });
    }

    function verifyCertificate(
        string memory certificateId
    )
        public
        view
        returns (
            string memory studentName,
            string memory course,
            bool exists
        )
    {
        Certificate memory cert = certificates[certificateId];

        return (
            cert.studentName,
            cert.course,
            cert.exists
        );
    }
}