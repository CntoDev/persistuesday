// creates unique ID within the mission
counter = 0;

{
  counter = counter + 1;
  private _init = _x get3DENAttribute "init";
  _x set3DENAttribute ["init", (_init select 0) + "this setVariable ['id'," + str counter + "];"];
} forEach entities "AllVehicles";

{
  counter = counter + 1;
  private _init = _x get3DENAttribute "init";
  _x set3DENAttribute ["init", (_init select 0) + "this setVariable ['id'," + str counter + "];"];
} forEach entities "ReammoBox_F";

// clear all init

{
  counter = counter + 1;
  private _init = _x get3DENAttribute "init";
  _x set3DENAttribute ["init", ""];
} forEach entities "All";