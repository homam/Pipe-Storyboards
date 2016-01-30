{Obj} = require \prelude-ls
require! \querystring
{clone-element, create-class, create-factory, DOM:{div}}:React = require \react
require! \react-router
{render} = require \react-dom
pipe-storyboard = require \pipe-storyboard
Layout = create-factory pipe-storyboard.Layout
Story = create-factory pipe-storyboard.Story
Storyboard = create-factory pipe-storyboard.Storyboard
URL = require \url

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

      # this function is invoked whenever a ui-value changes & updates the state
      on-change: (new-state) ~> 
        react-router.hash-history.replace do 
          pathname: @props.location.pathname
          query: new-state
          state: null

      # A layout component is used to position queries in a Storyboard
      Layout do 
        style: width: \100%

        # A Story component takes a query-id or branch-id and renders it
        # the values from the ui-controls (passed as controls prop above) will be mapped to parameters
        # and passed to each child query / layout
        #Story branch-id: \pABXynQ, style: width: \50%
        Story branch-id: \pAKheI0, show-links: false, style: width: \100%

# get-initial-state :: a -> UIState
get-initial-state: ->  { }

# component-will-mount :: a -> Void
component-will-mount: !->
