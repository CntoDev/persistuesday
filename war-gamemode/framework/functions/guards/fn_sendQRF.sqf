/*
 * Author: Highway
 * Sends QRF to defend the objective that was seized.
 *
 * Arguments:
 * 0: objective to attack <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_objective] call war_guards_fnc_sendQRF;
 *
 * Public: Yes
 */

params [["_objective", [], [[]]]];
_objective params ["_markerName", "_side", "_type"];

_qrfGroup = if (_side == west) then { qrf_east } else { qrf_west };

_wp = _qrfGroup addWaypoint [getMarkerPos _markerName, 50];
_wp setWaypointBehaviour "AWARE";
_wp setWaypointSpeed "FULL";
_wp setWaypointType "SAD"; 