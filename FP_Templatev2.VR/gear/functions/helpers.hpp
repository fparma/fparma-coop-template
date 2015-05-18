// Helpers for gear functions

#define IS_ARRAY(X) (typeName (X)  == typeName [])
#define IS_STRING(X) (typeName (X) == typeName "")
#define IS_NUMBER(X) (typeName (X) == typeName 0)

// Check if given item can be added to unit. canAdd does not work for weapons it seems
#define ADD_CHECK(X, Y) if (!(X canAdd Y)) exitWith {if (!isNil "FP_gear_errs") then {FP_gear_errs pushBack format ["%1 - Could not add %2", str X, Y]}}
#define ERR_LOG(X, Y) if (!isNil "FP_gear_errs") then {FP_gear_errs pushBack format ["%1 - Could not add %2", str X, Y]}
