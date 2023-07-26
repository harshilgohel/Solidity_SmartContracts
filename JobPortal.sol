/*
The purpose of this contract is to make a job portal where applicant can create their 
profile, we can fetch applicant’s data, create a new job, applying for new job, etc.
*/


pragma solidity ^0.8.0;

contract JobPortal{
//Applicant Details
      struct Applicant {
        address Applicant_Add;
        string ApplicantName;
        string ApplicantEducation;
        string ApplicantDomain;
        string ApplicantType;
    }
//Mapping Applicant details to ID
    mapping(uint => Applicant) Applicants_;
    uint ApplicantID;

    event yourID(uint ApplicantID, string ApplicantName);
//Adding applicants
    function addApplicant(address _Applicant_Add,string memory _ApplicantName, string memory _ApplicantEducation, string memory _ApplicantDomain, string memory _ApplicantType) public {
        ApplicantID++;
        Applicants_[ApplicantID] = Applicant(_Applicant_Add,_ApplicantName,_ApplicantEducation,_ApplicantDomain,_ApplicantType);
        emit yourID(ApplicantID, _ApplicantName);
        
    }
//getting Applicant Details
    function getApplicantDetails(uint ID) public view returns(Applicant memory){
            
            require(ID<=ApplicantID, "Please enter the valid ID");
            return(Applicants_[ID]);
    }
//getting applicant type
    function getApplicantType(uint ID) public view returns(string memory){
        require(ID<=ApplicantID, "Please enter the valid Applicant ID");
        return(Applicants_[ID].ApplicantType);
    }

//Creating new job

struct Job {
        uint id;
        address employer;
        string title;
        string description;
        uint salary;
    }

    mapping(uint => Job) jobs;
    uint totalJobs;
    
    event JobCreated(uint  id, address employer, string title, uint salary);

    function createJob(string memory _title, address _employer,string memory _description, uint _salary) external {
        totalJobs++;
        jobs[totalJobs]  = Job(totalJobs, _employer, _title, _description, _salary);
        emit JobCreated(totalJobs, _employer, _title, _salary);
    }

//get job details

 function getJobDetails(uint JobID) public view returns(Job memory){
            require(JobID<=totalJobs, "Please enter the valid Job ID");
            return(jobs[JobID]);
    }
//Apply for job

struct link{

    uint ApplicantID_L;
    uint JobID_L;

}
mapping (uint =>link) JobApply;
uint ApplicationNum;

event JobApplication(uint  ApplicationNum, uint ApplicantID, uint JobID);

function ApplyForJob(uint _ApplicantID, uint _JobID) public{
require(_ApplicantID<=ApplicantID, "Please enter the valid Applicant ID");
require(_JobID<=totalJobs, "Please enter the valid Job ID");
ApplicationNum++;
JobApply[ApplicationNum]=link(_ApplicantID,_JobID);
emit JobApplication(ApplicationNum, _ApplicantID, _JobID);

}


//Rating Applicants

    struct Rating{

        string ApplicantName;
        uint ApplicantRating;

    }
mapping (uint=>Rating) Rate;

event yourRating(uint _AppliID, string _ApplicantName, uint _ApplicantRating);
function RateApplicant(uint _AppliID,uint _ApplicantRating) public{

require(_ApplicantRating<=10, "Not Allowed, Applicant's Rating must be between 0 to 10");
require(_ApplicantRating>=0, "Not Allowed, Applicant's Rating must be between 0 to 10");
Rate[_AppliID]=Rating(Applicants_[_AppliID].ApplicantName, _ApplicantRating);

emit yourRating(_AppliID, Applicants_[_AppliID].ApplicantName, _ApplicantRating);
}

//Fetching the rating of applicant
 function getApplicantRating(uint ApliID) public view returns(Rating memory){
            return(Rate[ApliID]);
    }
}
