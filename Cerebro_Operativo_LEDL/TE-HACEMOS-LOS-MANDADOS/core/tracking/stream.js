const activeDrivers = new Map();

function updateDriverLocation(driverId, location) {
  activeDrivers.set(driverId, {
    ...location,
    timestamp: Date.now()
  });
}

function getDriverLocation(driverId) {
  return activeDrivers.get(driverId);
}

module.exports = { updateDriverLocation, getDriverLocation };
