<script>
  import { onMount } from 'svelte';
  import { saveCookie } from "../../util/cookie";
  import { login } from "../../util/requests";

  let username = '', email = '', password = '';

  const handleLogin = async (event) => {
    event.preventDefault(); // Prevent default form submission behavior
    
    const result = await login(username, email, password);
    if (result) {
        saveCookie(result.cookie);
        window.location.href = "/"; // Redirect to homepage after successful login
    }
  };
</script>

<div>
  <h2>Login</h2>
  <form on:submit={handleLogin}>
    <label for="username">Username:</label>
    <input type="text" id="username" bind:value={username} /><br>

    <label for="email">Email:</label>
    <input type="email" id="email" bind:value={email} /><br>

    <label for="password">Password:</label>
    <input type="password" id="password" bind:value={password} /><br>

    <button type="submit">Login</button>
  </form>
</div>
