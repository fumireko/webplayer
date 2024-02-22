<script>
    import { onMount } from 'svelte';
    import { getCookie, removeCookie } from '../util/cookie';
    import { logout } from '../util/requests';

    let userData = {};
    let loading = true;

    const handleLogout = async () => {
        const cookie = getCookie();
        if (cookie) {
            const success = await logout(cookie);
            if (success) {
                removeCookie();
                window.location.href = "/";
            }
        }
    };

    onMount(() => {
        userData = JSON.parse(localStorage.getItem('userData')) || {};
        loading = false;
    });
</script>

<div>
    {#if loading}
        <p></p>
    {:else if userData && userData.username}
        <h1>Welcome, {userData.username}!</h1>
        <p>Email: {userData.email}</p>
        <button on:click={handleLogout}>Logout</button>
    {:else}
        <p>No user data found. Please <a href="/signin">log in.</a></p>
    {/if}
</div>