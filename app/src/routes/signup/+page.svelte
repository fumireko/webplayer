<script>
  import { onMount } from 'svelte';
  import { writable } from 'svelte/store';
  import { register } from '../../util/requests';
  import { saveCookie } from '../../util/cookie';

  let username = '', email = '', password = '', confirmPassword = '';
  let errorMessage = writable('');

  async function handleRegister() {
    if (password !== confirmPassword) {
      errorMessage.set('Passwords do not match');
      return;
    }

    const result = await register(username, email, password);
    
    if (result && result.success) {
      console.log('Registration successful');
      saveCookie(result.cookie);
      window.location.href = "/signin";
    } else {
      errorMessage.set(result.message);
    }
  }

  onMount(() => {
    // Limpar a mensagem de erro ao carregar a página
    errorMessage.set('');
  });
</script>

<div>
  <h2>Register</h2>
  <form on:submit|preventDefault={handleRegister}>
    <div>
      <label for="username">Username:</label>
      <input type="text" id="username" bind:value={username} />
    </div>
    <div>
      <label for="email">Email:</label>
      <input type="email" id="email" bind:value={email} />
    </div>
    <div>
      <label for="password">Password:</label>
      <input type="password" id="password" bind:value={password} />
    </div>
    <div>
      <label for="confirmPassword">Confirm Password:</label>
      <input type="password" id="confirmPassword" bind:value={confirmPassword} />
    </div>
    <button type="submit">Register</button>
  </form>
  {#if $errorMessage}
    <p style="color: red;">{$errorMessage}</p>
  {/if}
</div>
