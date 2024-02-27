<script>
    /** @type {import('./$types').PageData} */
	export let data;
    import { onMount } from "svelte";
    import { env } from '$env/dynamic/public';
    import '@fortawesome/fontawesome-free/css/all.min.css';

    let artist = null;
    let editingArtist = null;;

    // Load artist details on component mount
    onMount(async () => {
        const response = await fetch(`${env.PUBLIC_BACKEND_URL}/api/artists/${data.id}`);
        if (response.ok) {
            artist = await response.json();
            // Clone artist object for editing
            editingArtist = { ...artist };
        }
    });

    async function updateArtist() {
        const response = await fetch(`${env.PUBLIC_BACKEND_URL}/api/artists/${data.id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(editingArtist)
        });
        if (response.ok) {
            // Update artist object if successful
            artist = editingArtist;
        }
    }
</script>

{#if artist}
    <div>
        <h1>Edit Artist: {artist.name}</h1>
        <div>
            <label>Name:</label>
            <input type="text" bind:value={editingArtist.name} />
        </div>
        <div>
            <label>Description:</label>
            <input type="text" bind:value={editingArtist.description} />
        </div>
        <div>
            <label>Country Code:</label>
            <input type="text" bind:value={editingArtist.countryCode} />
        </div>
        <button on:click={updateArtist}>Save</button>
    </div>
{:else}
    <p>{ data.id }</p>
{/if}
