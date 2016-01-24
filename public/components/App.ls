{clone-element, create-class, create-factory, DOM:{div}}:React = require \react
{render} = require \react-dom
require! \react-router
Router = create-factory react-router.Router
Route = create-factory react-router.Route
IndexRoute = create-factory react-router.IndexRoute
Link = create-factory react-router.Link


YourExportedComponents = require \../../src/index.ls

App = create-class do

    display-name: \App

    # render :: a -> ReactElement
    render: ->
        div null,

            # MENU
            div null,
                Link to: \/?example=example1, \example1
                Link to: \/beta, \beta

            # EXAMPLES (scroll-to/focus-on example based on @props.location.query.example)
            div null,
                @props.children

render do 
    Router do 
        history: react-router.hash-history
        Route do 
            name: \app
            path: \/
            component: App
        Route do 
            name: \Beta
            path: \/beta
            component: (require './BetaRoute.ls')
    document.get-element-by-id \mount-node