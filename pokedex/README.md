# Pokedex: An Introduction to the React Router

**Gotta Fetch 'em All**

In this project, we'll write an app to manage your `Pokemon` and their
`Toy`s. We've already setup migrations/models/controllers/views for you to
start with in a skeleton that we will email to you at the beginning of
the day.  **Set things up with a `bundle install`, then `rake db:setup` (this is
equivalent to `rake
db:create db:migrate db:seed`)**.

Take a look at the schema, the routes file, and the jbuilder views to get
yourself oriented. Navigate
to the api routes to see the json that's sent up.

**Note the `defaults: {format: :json}`**. This means that HTTP
requests that Rails handles for the `pokemon` resource should be
assumed to be asking for a JSON response instead of HTML. When we
render a template, instead of looking for `template.html.erb`, Rails
will look for `template.json.jbuilder`.

**Also**: the root url `localhost:3000` will be the home of
our JS application. We have provided this controller and view
for you.

## Phase 1: NPM and Webpack

### `Node Package Manager`

As before, you will need to set up a `package.json` and `webpack.config.js` file
to configure your application to use NPM and Webpack. First, run `npm init -f`
to initialize `package.json` to the default settings. Normally you could now
proceed to run `npm install --save 'package-name'` to install the dependencies
of your project. In this case however, we want to use specific versions of each
package to ensure that none of the syntax has changed since these instructions
were written. To that end, add (or replace if it already exists) a
"dependencies" key in the `package.json` file with these contents:

```json
"dependencies": {
  "babel-core": "^6.1.4",
  "babel-loader": "^6.1.0",
  "babel-preset-react": "^6.1.4",
  "flux": "^2.1.1",
  "history": "^1.13.0",
  "react": "^0.14.2",
  "react-addons-linked-state-mixin": "^0.14.2",
  "react-dom": "^0.14.2",
  "react-router": "^1.0.0",
  "webpack": "^1.12.4"
}
```

Now run `npm install` to generate your `node_modules` folder!

### `Webpack`

Next we need to configure Webpack to compile our `bundle.js` file. Create a new
file called `webpack.config.js` in the root of your project and add the
following content:

```js
var path = require("path");

module.exports = {
  context: __dirname,
  entry: "./frontend/pokedex.jsx",
  output: {
    path: path.join(__dirname, 'app', 'assets', 'javascripts'),
    filename: "bundle.js"
  },
  resolve: {
    extensions: ["", ".js", ".jsx"]
  },
  module: {
    loaders: [
      {
        test: /\.jsx?$/,
        exclude: /(node_modules|bower_components)/,
        loader: 'babel',
        query: {
          presets: ['react']
        }
      },
      {
        test: /\.node$/,
        loader: "node-loader"
      }
    ]
  }
};
```

Now that Webpack knows to create `bundle.js`, we need to require it in our
`application.js`:

```js
//= require bundle
```

Notice that the `entry` key in `webpack.config.js` expects a file called
`./frontend/pokedex.jsx` to exist. Make the `frontend` folder in the root of
your project and add a file called `pokedex.jsx`. This is going to be the
starting point for the rest of your app. Make sure to require both the `'react'`
and `'react-dom'` packages, and then add an event listener for the
`DOMContentLoaded` event. This event will be fired once the static root page is
fully loaded. In the callback to this listener, try rendering a simple React
element to test out everything you've written so far. Don't forget to run
`webpack --watch` to generate your `app/assets/javascripts/bundle.js`!

Next, add more structure to your `frontend` directory. You should have actions,
components, constants, dispatcher, stores, and util folders.

Finally, create the `frontend/dispatcher/dispatcher.js` file. This should export
one **instance** of the `Dispatcher` object from the `'flux'` library.

## Phase 2: Pokemon Index

### `ApiUtil`

We'd like to render a list of pokemon. Let's start by setting up a way to fetch
them from the back end. Make an `apiUtil.js` file inside your util folder.
Inside this file, we'll make ajax requests that fetch information served by our
rails controllers, and on success call a front end action creator.

Set the export of the file to be an object with a key fetchAllPokemons
pointing to a function. The function should make an ajax request with url
`api/pokemon`. The success callback of the request will be passed the fetched
pokemons. For now, print the pokemons to the console and test that everything is
working.

**Hint:** You will need to temporarily require `'apiUtil.js'` in the starting
point of your app to call the `fetchAllPokemons` function

Once you can print the pokemons, change the success callback to instead pass
them to
`ApiActions.receiveAllPokemons`, which we have yet to write.
`receiveAllPokemons` will dispatch actions to our stores.

### `ApiActions` and `PokemonConstants`

Now let's write that action dispatcher. Create a file `pokemonActions.js`
in the actions folder. This will need to make use of the dispatcher we created
in Phase I. Once again, export an object from this file and create a
`receiveAllPokemons` function. This will need to call
`Dispatcher.dispatch` and pass it an object with a property `actionType` whose
value is `PokemonConstants.POKEMONS_RECEIVED`, and
a property `pokemons` that passes along the argument to the function.

In the constants folder, create a `pokemonConstants.js` file that exports an
object with a key `POKEMONS_RECEIVED` pointing to the string
"POKEMONS_RECEIVED".

### `PokemonStore`

We need a way to keep track of the pokemons on the front end. In
`stores/pokemon.js`, export an object that will represent our pokemon store. We
will need to make use of the `Store` object from the 'flux/utils' npm package.
The file should have a local variable `_pokemons` that's initially set to an
empty POJO. This will store all our pokemon indexed by id. Write an `all` function on the pokemon store that returns an array of all the values in `_pokemons`.
In the file, we also want a `resetPokemons` function that resets `_pokemons` and
creates new properties for each of the pokemons passed in as an argument. Now we're able to keep track of the pokemons that we've fetched.

We want to call `resetPokemons` when `PokemonConstants.POKEMONS_RECEIVED` is
dispatched. Make it so.

Check that calling `ApiUtil.fetchAllPokemons` and `PokemonStore.all` in the
browser works as expected.

### React Components

#### PokemonsIndex

Make a react component in `frontend/components/pokemons/pokemonsIndex.jsx` to 
display the pokemons we've fetched. The state of 
`PokemonsIndex` should keep track of all the `pokemons` in the store. `getInitialState`
will start us out right, but we also need to set the state whenever the store changes.

To do the latter we need to add a change listener to our store. Since the object
exported by `stores/pokemon.js` is an instance of the `Store` object from the
'flux/utils' library, it will respond to the `#addListener` method.

`PokemonStore` should invoke the `__emitChange` function when it registers 
a `PokemonConstants.POKEMON_RECEIVED` dispatcher action. To accomplish that, we will need to
overwrite the default `__onDispatch` function on the PokemonStore.

Next, register an event listener in the pokemon index component. Write an
`_onChange` function on `PokemonsIndex` that sets the state, and in the `componentDidMount` 
function add `_onChange` to the callbacks for the store's listener. Make sure
to remove it in `componentWillUnmount`.

We're almost done. The only thing left is to fetch the pokemons when the component
mounts. On success, that fetch will call `ApiActions.receiveAllPokemons`, which will 
dispatch an action. That action will cause the store to reset its pokemon and emit an
event. The event will trigger the store's listener, which will reset the 
state of our pokemon index. 

For now, to test that the `PokemonsIndex` component is working, just have `render` return a 
div containing `this.state.pokemons`. In `pokedex.jsx` on document ready, render a
`PokemonsIndex` component into the DOM element with id `pokedex` that we've provided. 
It will overlap the background for now, but you should be able to see the info.

Now that that's working, let's change `PokemonsIndex.render` to render an unordered
list of `PokemonIndexItem` components. Each index item should be passed a `pokemon` prop,
and a unique key.

#### PokemonIndexItem

Create this class in a different file. It just needs a render method for now. Give
the pokemon list items a class name of "poke-list-item" so the css file we've
provided can do its magic. Each list item should show its name and poke type.

Make sure this works. The list is still overlapping the background. We're about 
to fix that.

## Phase 3: Router

We would like to be able to render different elements depending on our url.
Eventually we want to be able to click on an item in our pokemon index and see
a detailed view of that pokemon. We'll use the **react router** to render a root
component that will in turn render our index and detail components. Then, by
navigating to different urls, we'll be able to change which pokemon detail is
displayed. 

### Getting the React Router

We'll start by refactoring the logic we already have. In `pokedex.jsx`, we will
need to use the 'react-router' library to access the Router and Route
components:

```js
var Router = require('react-router').Router;
var Route = require('react-router').Route;
```

Instead of rendering a `PokemonIndex`, render the `Router`. It should have a single
route with path "/" that will render an `App` component.

Now we have to write the `App` component. This should render a div, that
for now just contains a nested div inside it that contains a `PokemonsIndex`
component. The div containing the index 
should have a class "pokemon-index", for styling purposes. With the styling, you 
should now be able to see the index clearly.

## Phase 4: Pokemon Detail

We will soon write a `PokemonDetail` component to display more info about individual
pokemons. First we need to add a new `Route`.
It should be nested under the existing route, and have path "pokemon/:pokemonId".
This `Route`'s component should be the `PokemonDetail` component. Change `App` to render all of the child components given to it from the Router by using `this.props.children` inside `render`.

`PokemonDetail` needs to have pokemon info. Right now it only has `this.props.params.pokemonId`.
Write a `getStateFromStore` function on the component that returns an object with a 
pokemon property. You'll need to write a `find` function on the pokemon store to return a pokemon
given an id. `find` should take an integer argument. In `PokemonDetail`, `this.props.params.pokemonId` 
is stored as a string. Deal with this discrepency using `parseInt`. Set the initial state of the component to `this.getStateFromStore()`.
In render, return a div containing a "div.detail" that shows the properties of the 
pokemon. Make sure to use the `image_url` property to display an image of the pokemon. 

There will be no pokemon when there is no `pokemonId` - that is, before the fetch of
pokemons comes back - so first check if `this.state.pokemon`
is defined and return an empty div if it isn't.

## Phase 5: OnClick

We want to be able to click on a pokemon index item and navigate to that pokemon's
url. `PokemonIndexItem` will need an `onClick` property of its rendered `li` to
call a `showDetail` function. In order to navigate to a different url in this 
function, we'll add the `History` object from the 'react-router' npm package as a mixin to this component. Then we can use `this.history.pushState`
to navigate to the appropriate url.

You should now be able to click on different pokemon and see the url change.
The pokemon detail, however, is still blank. That's because the 
component doesn't update when its `this.props.params` change... unless we tell it
to. Add a `componentWillReceiveProps` function to the detail. This is passed
the new props. In it, call an ApiUtil function (that we haven't written yet) to 
fetch the appropriate pokemon.
Using the flux pattern, we're going to set it up so that the fetch will cause the 
component's state to change. Fetching a pokemon individually from the back end when 
we navigate to its url will also allow us to get its toys, which we don't have access
to when we fetch all the pokemons together.

Write the fetch for a single pokemon, and also modify actions, constants, and the 
store appropriately. You'll need
an ajax request to fetch a single pokemon. This should call a `receiveSinglePokemon`
action, which should dispatch an action that triggers the store to reset the
information of a single pokemon. You might want to write a function in the file
with the store to do this. After the single pokemon has been updated, the store should emit a change event. In `PokemonDetail`, register a listener that resets state.

Now, if we fetch a single pokemon when the detail mounts and when its props change, the pokemon in state
should be updated appropriately. Make sure you can explain to your partner how this
works.

You should now be able to refresh the page and still see a pokemon detail view.

## Phase 6: Toys

The pokemon detail should render a `ToysIndex` component. A toys index will have
toys passed in as a property, and should render a `ToyIndexItem` for each toy.
The index's toys will be undefined before an individual pokemon is fetched, so 
account for that in render. 

Index items should have a toy as a property, and render a "li.toy-list-item"
with its name, happiness, and price.

When we click on a toy index item, we'd like to see its detail. Give the index
item class an onClick that navigates to a "/pokemon/:pokemonId/toys/:toyId" url.

Create a new `Route` nested under the one that renders the `App`, but adjacent to the one that renders the `PokemonDetail`. These two components are 'siblings' so we don't want to nest either of them under the other. In order to make sure that `App` recieves both the `PokemonDetail` component and the `ToyDetail` component as children we need to make this `Route` have multiple components.
```js
<Route path="coolSiteHere" components={{nameA: ComponentClassA, nameB: ComponentClassB}}/>
``` 

This will pass all the components specified into `this.props` in the parent component when this `Route`'s path is matched. Change the `render` function of `App` to render both components individually instead of `this.props.children`.

**NB**: Don't forget *both* sets of curly braces when you specify multiple components in a route using `components=` instead of `component=`. It is using a POJO inside JSX.

However, now if we tried to go to a path like `/pokemon/:pokemonId`, our pokemon
would not show up since we are not rendering `this.props.children` anymore.
Change the first Route you wrote to also pass an object with one property as
`components`.

I wrote the following functions for the toy detail:
  * `getStateFromStore`
    - When might you not have access to a pokemon, and its toys? What simple 
      checks can you do to not cause errors in those situations?
  * `_onChange`
  * `getInitialState`
  * `componentDidMount`
    - We already have a way to register a listener for a fetch of a pokemon
    - Since we're always rendering a pokemon detail whenever we render a toy
      detail, we don't need to fetch a pokemon here
  * `componentWillUnmount`
  * `componentWillReceiveProps`
  * `render`
    - Return a "div.detail"

## Phase 7: PokemonForm

We'd like to be able to create new pokemon. Let's make a `PokemonForm` component. 
This will be rendered above the pokemon index in the same div. `PokemonForm`
should render a form with a class name "new-pokemon".

We want the form to have controlled inputs. The easiest way to do this is with
the LinkedStateMixin from the `'react-addons-linked-state-mixin'` library. Now we can add a `valueLink` attribute to the inputs we
want to control: `valueLink={this.linkState("name")}`, for example, where "name"
is part of the component's state. This replaces the need to reset state in an 
`onChange` handler. Use a `select` input for the poke-type – if you look in your
`application.html.erb` layout file, you'll see that we're defining the possible
Poke Types on `window` when the page loads.

Write an `onSubmit` that calls a function `ApiUtil.createPokemon`. It would be
nice to be able to navigate to the newly created pokemon's url after creation. 
However, we don't have its id until it's saved to the database. To navigate once
we have the id, let `createPokemon` take a callback.

The index should update immediately when we create a new pokemon. You'll need to add a listener to the index to do this.

## Bonus: Reassigning Toys

Add a `select` to the toy detail that has an option for each pokemon. Choosing a
different pokemon should change the ownership of the toy.
