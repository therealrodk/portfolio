# Tailwind

## Watching for Changes
> While you're developing your application, you want to run Tailwind in "watch" mode, so changes are automatically reflected in the generated CSS output. You can do this by:
> - running `rails tailwindcss:watch` as a separate process,
> - or by running `./bin/dev` which uses foreman to start both the Tailwind watch process and the rails server in development mode.

## Manually Applying Tailwind Styles
`rails tailwindcss:build`

---

# Devise
> 1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

     * Required for all applications. *

> 2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

     * Not required for API-only Applications *

> 3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

     * Not required for API-only Applications *

> 4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

     * Not required *

---

# Logging In
Manually navigate to `/users/sign_in`.
