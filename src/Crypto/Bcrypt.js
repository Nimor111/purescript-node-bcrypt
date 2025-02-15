const bcryptjs = require("bcryptjs");

exports._hash = function(saltRounds) {
  return function(password) {
    return function(onError, onSuccess) {
      bcryptjs.hash(password, saltRounds, function(error, hash) {
        if (error) {
          onError(error);
        } else {
          onSuccess(hash);
        }
      });

      return function(cancelError, onCancelerError, onCancelerSuccess) {
        // TODO: This cannot be cancelled. Should we error here instead?
        onCancelerSuccess();
      };
    };
  };
};

exports._compare = function(hash) {
  return function(password) {
    return function(onError, onSuccess) {
      bcryptjs.compare(password, hash, function(error, doesMatch) {
        if (error) {
          onError(error);
        } else {
          onSuccess(doesMatch);
        }
      });

      return function(cancelError, onCancelerError, onCancelerSuccess) {
        // TODO: This cannot be cancelled. Should we error here instead?
        onCancelerSuccess();
      };
    };
  };
};
