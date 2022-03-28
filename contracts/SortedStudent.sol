// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 参考：https://medium.com/bandprotocol/solidity-102-3-maintaining-sorted-list-1edd0a228d83

contract SortedStudent{

    mapping(address => uint256) public scores; // 保存每个学生的成绩
    mapping(address => address) _nextStudents; // 这个地方，以map作为链表，维护一个有序链表，学生地址作为链表的元素，上一个学生指向下一个学生
    uint256 public listSize;
    address constant GUARD = address(1);

    constructor() {
        _nextStudents[GUARD] = GUARD;
    }

    function addStudent(address student, uint256 score) public {
        require(_nextStudents[student] == address(0));
        address index = _findIndex(score);
        scores[student] = score;
        _nextStudents[student] = _nextStudents[index];
        _nextStudents[index] = student;
        listSize++;
    }

    function increaseScore(address student, uint256 score) public {
        updateScore(student, scores[student] + score);
    }

    function reduceScore(address student, uint256 score) public {
        updateScore(student, scores[student] - score);
    }

    function updateScore(address student, uint256 newScore) public {
        require(_nextStudents[student] != address(0));
        address prevStudent = _findPrevStudent(student);
        address nextStudent = _nextStudents[student];
        if(_verifyIndex(prevStudent, newScore, nextStudent)){
            scores[student] = newScore;
        } else {
            removeStudent(student);
            addStudent(student, newScore);
        }
    }

    function removeStudent(address student) public {
        require(_nextStudents[student] != address(0));
        address prevStudent = _findPrevStudent(student);
        _nextStudents[prevStudent] = _nextStudents[student];
        _nextStudents[student] = address(0);
        scores[student] = 0;
        listSize--;
    }

    function getTop(uint256 k) public view returns(address[] memory) {
        require(k <= listSize);
        address[] memory studentLists = new address[](k);
        address currentAddress = _nextStudents[GUARD];
        for(uint256 i = 0; i < k; ++i) {
            studentLists[i] = currentAddress;
            currentAddress = _nextStudents[currentAddress];
        }
        return studentLists;
    }


    function _verifyIndex(address prevStudent, uint256 newValue, address nextStudent)
    internal
    view
    returns(bool)
    {
        return (prevStudent == GUARD || scores[prevStudent] >= newValue) &&
        (nextStudent == GUARD || newValue > scores[nextStudent]);
    }

    function _findIndex(uint256 newValue) internal view returns(address) {
        address candidateAddress = GUARD;
        while(true) {
            if(_verifyIndex(candidateAddress, newValue, _nextStudents[candidateAddress]))
                return candidateAddress;
            candidateAddress = _nextStudents[candidateAddress];
        }
        return candidateAddress;
    }

    function _isPrevStudent(address student, address prevStudent) internal view returns(bool) {
        return _nextStudents[prevStudent] == student;
    }

    function _findPrevStudent(address student) internal view returns(address) {
        address currentAddress = GUARD;
        while(_nextStudents[currentAddress] != GUARD) {
            if(_isPrevStudent(student, currentAddress))
                return currentAddress;
            currentAddress = _nextStudents[currentAddress];
        }
        return address(0);
    }
}

