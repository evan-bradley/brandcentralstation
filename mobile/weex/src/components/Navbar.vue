<template>
  <div>
    <nav class="navbar has-shadow" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <div class="navbar-start navbar-item" style="width: 52px;">
          <a @click="GoBackAChannel">
            <i class="fa fa-chevron-circle-left" aria-hidden="true" style="font-size: 25px; color: #EF233C;"></i>
          </a>
        </div>
        <div class="navbar-item center-div is-hidden-tablet">{{ this.channelName }}</div>
        <div class="navbar-burger burger" style="margin: 0;" @click="toggleBurger"
            :class="{ 'is-active': burgerActive }">
          <!-- Note: these spans generate the burger lines -->
          <span></span>
          <span></span>
          <span></span>
        </div>
      </div>
      <div class="navbar-item center-div is-hidden-mobile ">{{ this.channelName }}</div>

      <div class="navbar-end navbar-item has-dropdown is-hidden-mobile " :class="{ 'is-active': burgerActive }">
        <a class="navbar-item" @click="toggleBurger">
          <i class="fa" :class="{'fa-bars' : !burgerActive, 'fa-times' : burgerActive }"></i>
        </a>
        <div class="navbar-dropdown is-right">
            <div class="dropdown-item" style="display:block;">
              <b>{{ user.FirstName ? user.FirstName : "" }} {{ user.LastName ? user.LastName : "" }}</b>
              <br> @{{ user.UserName ? user.UserName : ""  }}
            </div>
          <hr class="navbar-divider">
          <a class="dropdown-item" @click="signOut">Sign out</a>
        </div>
      </div>

      <div class="navbar-menu is-hidden-tablet" :class="{ 'is-active': burgerActive }">
        <div class="navbar-end">
          <div class="navbar-item has-dropdown">
            <div class="navbar-dropdown is-right">
              <div class="dropdown-item" style="display:block;">
                <b>{{ user.FirstName ? user.FirstName : "" }} {{ user.LastName ? user.LastName : "" }}</b>
                <br> @{{ user.UserName ? user.UserName : ""  }}
              </div>
              <hr class="navbar-divider">
              <a class="dropdown-item" @click="signOut">Sign out</a>
            </div>
          </div>
        </div>
      </div>
    </nav>
    </div>
</template>

<script>
  var Classes = require('../TypeScriptFolder/Compliled/Classes').Classes
  var axios = require("axios");
  var instance = axios.create({
    baseURL: "https://cors-anywhere.herokuapp.com/https://brandcentral.xyz",
    timeout: 1000
  });

  export default {
    name: 'Navbar',
    data () {
      return {
        burgerActive: false
      }
    },
    props: {
      user: {
        type: Classes.User,
        default: new Classes.User() 
      },
      channelName: {
        default: "" 
      }
    },
    methods: {
      signOut () {
        instance.get('/api/logout')
          .then(response => {
            this.burgerActive = false
            this.$emit('LogOut')
          }, response => {
            console.log(response)
          })
      },
      toggleBurger () {
        this.burgerActive = !this.burgerActive
      },
      GoBackAChannel () {
        this.$emit('GoBackAChannel')
      }
    }
  }
</script>
