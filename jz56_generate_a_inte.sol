// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Generate a Interactive IoT Device Dashboard
 * @author Your Name
 * @notice A solidity contract to create an interactive IoT device dashboard
 */

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract IoTDeviceDashboard {
    // Mapping of IoT devices to their respective data
    mapping (address => Device) public devices;

    // Structure to hold device data
    struct Device {
        string name;
        string model;
        string location;
        uint256 temperature;
        uint256 humidity;
        bool isOnline;
    }

    // Event emitted when a new device is added
    event NewDeviceAdded(address indexed deviceAddress, string name, string model, string location);

    // Event emitted when device data is updated
    event DeviceDataUpdated(address indexed deviceAddress, uint256 temperature, uint256 humidity);

    /**
     * @dev Constructor function
     */
    constructor() public {
        // Initialize the contract owner
        OWNABLE_CONSTRUCTOR();
    }

    /**
     * @dev Add a new IoT device to the dashboard
     * @param _name Device name
     * @param _model Device model
     * @param _location Device location
     */
    function addDevice(string memory _name, string memory _model, string memory _location) public onlyOwner {
        // Create a new device
        Device storage newDevice = devices[msg.sender];
        newDevice.name = _name;
        newDevice.model = _model;
        newDevice.location = _location;
        newDevice.temperature = 0;
        newDevice.humidity = 0;
        newDevice.isOnline = false;

        // Emit event
        emit NewDeviceAdded(msg.sender, _name, _model, _location);
    }

    /**
     * @dev Update device data
     * @param _temperature New temperature value
     * @param _humidity New humidity value
     */
    function updateDeviceData(uint256 _temperature, uint256 _humidity) public {
        // Get the device
        Device storage device = devices[msg.sender];

        // Update device data
        device.temperature = _temperature;
        device.humidity = _humidity;

        // Emit event
        emit DeviceDataUpdated(msg.sender, _temperature, _humidity);
    }

    /**
     * @dev Get device data
     * @return Device data
     */
    function getDeviceData() public view returns (string memory, string memory, string memory, uint256, uint256, bool) {
        // Get the device
        Device storage device = devices[msg.sender];

        // Return device data
        return (device.name, device.model, device.location, device.temperature, device.humidity, device.isOnline);
    }
}