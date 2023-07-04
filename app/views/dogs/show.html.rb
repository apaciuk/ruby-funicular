
<html>
  <%= render_partial "base/_head.html.erb" %>

  <body>
  <div>
    <h1><%= @title %></h1>
    <p>
      <a href="/dogs">Back to the list</a>
    </p>

    <p>
      Dog #n <%= @dog.id %>, name: <strong><%= @dog.name %></strong>
    </p>
  </div>
</body>
</html>