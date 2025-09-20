import React from "react";
import PropTypes from "prop-types";
export default function PropTypeComponent({ name, usn }) {
  return <div></div>;
}

PropTypeComponent.propTypes = {
  name: PropTypes.string.isRequired,
  usn: PropTypes.number.isRequired,
};
