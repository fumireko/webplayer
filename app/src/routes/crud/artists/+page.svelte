<script>
    import { onMount } from "svelte";
    import { env } from '$env/dynamic/public';
	import '@fortawesome/fontawesome-free/css/all.min.css';
    import { goto } from '$app/navigation';

    let artists = [];
    let newArtist = { name: '', description: '', countryCode: '' };
    let editingId = null;
    let showAddInput = false;
    let regionNames = new Intl.DisplayNames(['en'], {type: 'region'});

    function getArtists() {
        fetch(`${env.PUBLIC_BACKEND_URL}/api/artists/`)
            .then(response => response.json())
            .then(data => {
                artists = data;
            })
            .catch(error => console.error(error));
    }

    function removeArtist(artistID) {
        const path = `${env.PUBLIC_BACKEND_URL}/api/artists/${artistID}`;
        fetch(path, { method: 'DELETE' })
            .then(() => {
                artists = artists.filter(artist => artist.id !== artistID);
            })
            .catch(error => {
                console.error(error);
            });
    }

    function addArtist() {
        fetch(`${env.PUBLIC_BACKEND_URL}/api/artists/`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(newArtist)
        })
        .then(response => response.json())
        .then(data => {
            artists = [...artists, data];
            newArtist = { name: '', description: '', countryCode: '' };
            showAddInput = false;
        })
        .catch(error => {
            console.error(error);
        });
    }

    function updateArtist(artistID, artist) {
        fetch(`${env.PUBLIC_BACKEND_URL}/api/artists/${artistID}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(artist)
        })
        .then(() => {
            const index = artists.findIndex(artist => artist.id === artistID);
            if (index !== -1) {
                artists[index] = artist;
                editingId = null;
            }
        })
        .catch(error => {
            console.error(error);
        });
    }

    function editArtist(id) {
        goto(`/artists/${id}`);
    }

    onMount(getArtists);
</script>

<div class="mx-md-5 px-md-5">
    <p class="fs-1 mt-5">
        Artists
    </p>
    <hr>

    <div class="row table-container">
        <div class="col-2"></div>
        <table class="col-8 bg-dark text-light table-sm rounded round-3">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Country Code</th>
                    <th class="text-end">
                        Actions
                        <button class="btn btn-success" on:click={() => showAddInput = true}>
                            <i class="fa fa-plus"></i>
                        </button>
                    </th>
                </tr>
            </thead>
            <tbody>
                {#if showAddInput}
                    <tr>
                        <td>
                            <input type="text" class="form-control" bind:value={newArtist.name} placeholder="Name" />
                        </td>
                        <td>
                            <input type="text" class="form-control" bind:value={newArtist.description} placeholder="Description" />
                        </td>
                        <td>
                            <input type="text" class="form-control" bind:value={newArtist.countryCode} placeholder="Country Code" />
                        </td>
                        <td>
                            <span style="float: right;">
                                <button class="btn btn-success" on:click={addArtist}>
                                    <i class="fa fa-save"></i>
                                </button>
                                <button class="btn btn-danger" on:click={() => showAddInput = false}>
                                    <i class="fa fa-times"></i>
                                </button>
                            </span>
                        </td>
                    </tr>
                {/if}
                {#each artists as artist, index}
                    <tr>
                        <td>
                            {#if editingId === artist.id}
                                <input type="text" bind:value={artist.name} />
                            {:else}
                                {artist.name}
                            {/if}
                        </td>
                        <td>
                            {#if editingId === artist.id}
                                <input type="text" bind:value={artist.description} />
                            {:else}
                                {artist.description}
                            {/if}
                        </td>
                        <td>
                            {#if editingId === artist.id}
                                <input type="text" bind:value={artist.countryCode} />
                            {:else}
                                {regionNames.of(artist.countryCode)}
                            {/if}
                        </td>
                        <td>
                            {#if artist.name}
                                <span style="float: right;">
                                    {#if editingId === artist.id}
                                        <button class="btn btn-success" on:click={() => updateArtist(artist.id, artist)}>
                                            <i class="fa fa-save"></i>
                                        </button>
                                    {:else}
                                        <button class="btn btn-secondary" on:click={() => editingId = artist.id}>
                                            <i class="fa fa-edit"></i>
                                        </button>    
                                        <button on:click={() => editArtist(artist.id)} class="btn btn-primary">
                                            <i class="fa fa-external-link"></i>
                                        </button>
                                    {/if}
                                    <button class="btn btn-danger" on:click={() => removeArtist(artist.id)}>
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </span>
                            {/if}
                        </td>
                    </tr>
                {/each}
            </tbody>
        </table>    
        <div class="col-2"></div>
    </div>
</div>
