{clone-element, create-class, create-factory, DOM:{div}}:React = require \react
require! \react-router
{render} = require \react-dom

pipe-storyboard = require \pipe-storyboard
Layout = create-factory pipe-storyboard.Layout
Story = create-factory pipe-storyboard.Story
Storyboard = create-factory pipe-storyboard.Storyboard

{Obj} = require \prelude-ls
require! \querystring
URL = require \url

# !pure function
# update-querystring :: String -> object -> String
update-querystring = (url, patch) -->
    url = url.replace '#/', ''
    {query, pathname} = URL.parse url
    parsed-query = (querystring.parse query)
    delete parsed-query['_k']
    new-querystring = querystring.stringify do 
        ({} <<< parsed-query <<< patch)
    "#{pathname}?#{decodeURIComponent new-querystring}"

# conversions: 1
# visitors: 400
# minX: 0.01

module.exports = create-class do

    display-name: \Beta

    # render :: a -> ReactElement
    render: ->
                
        Storyboard do 

            # the pipe-server to get queries from
            url: \http://ndemo.pipend.com

            # a list of ui controls corresponding to the parameters of the child queries
            controls: 
                * name: \conversions
                  label: \Conversions
                  type: \number
                  default-value: 1
                  client-side: true

                * name: \visitors
                  label: \Visitors
                  type: \number
                  default-value: 400
                  client-side: true

                * name: \minX
                  label: \Minimum
                  type: \number
                  default-value: 0.01
                  client-side: true  
                ...

            # this tells the Storyboard component to load the ui-values from query-string
            state: @props.location.query
            # state: @state

            # this function is invoked whenever a ui-value changes & updates the state
            on-change: (new-state) ~> 
                react-router.hash-history.replace (update-querystring window.location.href, new-state)

                #@set-state new-state

            # A layout component is used to position queries in a Storyboard
            Layout do 
                style: width: \100%

                # A Story component takes a query-id or branch-id and renders it
                # the values from the ui-controls (passed as controls prop above) will be mapped to parameters
                # and passed to each child query / layout
                #Story branch-id: \pABXynQ, style: width: \50%
                Story branch-id: \pAKheI0, style: width: \100%

    # get-initial-state :: a -> UIState
    get-initial-state: ->  { }

    # component-will-mount :: a -> Void
    component-will-mount: !->
