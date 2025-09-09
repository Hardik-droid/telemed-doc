// Custom logger middleware
function logger(req, res, next) {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.originalUrl}`);
  next();
}

// Authentication middleware (dummy example)
function authenticate(req, res, next) {
  // Example: check for a header token
  const token = req.headers['authorization'];
  if (token === 'Bearer mysecrettoken') {
    next();
  } else {
    res.status(401).json({ success: false, message: 'Unauthorized' });
  }
}

// Error handler middleware
function errorHandler(err, req, res, next) {
  console.error(err.stack);
  res.status(500).json({ success: false, message: 'Internal Server Error' });
}

module.exports = {
  logger,
  authenticate,
  errorHandler