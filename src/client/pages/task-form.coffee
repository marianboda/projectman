React = require 'react/addons'
R = React.DOM
Reflux = require 'reflux'
ProjectStore = require '../stores/project-store'

TaskForm = React.createClass
  displayName: 'task-form'
  mixins: [Reflux.ListenerMixin]
  updateState: (up) ->
    @setState React.addons.update(@state, up)

  getDefaultProps: ->
    id: 0

  getInitialState: ->
    defProjects = [{id: 0, name: '-'}]
    projects: ProjectStore?.projects ? defProjects
    task: {}
  componentDidMount: ->
    @listenTo ProjectStore, => @setState({projects: ProjectStore.projects})

  componentWillReceiveProps: (nextProps) ->
    if nextProps.id? and nextProps.id isnt @props.id
      @updateState {task: {$set: ProjectStore.getTaskById(nextProps.id)}}

  onSaveClick: (e) ->
    @props.onSave?(@state.task)
    e.preventDefault()
  onProjectChange: (e) -> @updateState {task: {projectId: {$set: parseInt(e.currentTarget.value)}}}
  onNameChange: (e) -> @updateState({task: {name: {$set: e.target.value}}})
  onDescChange: (e) -> @updateState({task: {description: {$set: e.target.value}}})

  render: ->
    R.div {},
      R.h2 {}, 'EDIT'
      R.form {},
        R.table {},
          R.tr {},
            R.td {}, R.label({}, 'ID')
            R.td {}, @state.task?.id
          R.tr {},
            R.td {}, R.label({}, 'PROJECT')
            R.td {}, R.select({onChange: @onProjectChange},
              [R.option {value: 0}, '-'].concat
                @state.projects.map (i,v) -> R.option {value: i.get('id')}, i.get('name'))
          R.tr {},
            R.td {}, R.label({}, 'NAME')
            R.td {}, R.input({type: 'text', onChange: @onNameChange, value: @state.task?.name})
          R.tr {},
            R.td {}, R.label({}, 'DESCRIPTION')
            R.td {}, R.textarea({onChange: @onDescChange, value: @state.task?.description})
        R.button {onClick: @onSaveClick}, 'SAVE'



module.exports = React.createFactory TaskForm
