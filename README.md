# elm-form-study

An experiment with declarative, succinct, composable forms in Elm using as many 3rd party libraries as possible.

- `dillonkearns/elm-form` for a composable Form Api.
- `tesk9/accessible-html` for accessibility.
- [Pico CSS](https://picocss.com/) for low level CSS reset / styling.
- [miniBill/elm-codec](https://package.elm-lang.org/packages/miniBill/elm-codec/2.2.0/) for succinct declaration of symmetrical Json (en/de)coders.


## Conventions

- Modules with `Extra` suffix are candidates for an application agnostic library.
- Modules with `App` suffix are application specific extensions to external library concepts.

## Action Items

### Done

- Reorganized the example form code from the `elm-form` package to separate concerns and highlight the amount of code needed to fill each concern.
- Thin wrapper around Pico CSS for the styling.
- Implemented a pattern for `Select` controls defaulting to blank.

### TO-DO

- Hydrate form with `Maybe` input (saving data to local storage).
- Demonstrate conditional visibility.
- Pattern for handling sum types.
- Vite project integration
- Elm Review integration
- ...more
