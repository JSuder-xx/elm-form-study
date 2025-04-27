module Form.Validation.Extra exposing (..)

import Form.Validation as Validation


join :
    Validation.Validation error (Validation.Validation error mapped named1 constraints1) named2 constraints2
    -> Validation.Validation error mapped Never constraintsAny
join =
    Validation.andThen identity
