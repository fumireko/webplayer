<script>
    import { onMount } from "svelte";
    import { env } from '$env/dynamic/public';
    import '@fortawesome/fontawesome-free/css/all.min.css';

    let albums = [];
    let newAlbum = { title: '', releaseDate: '', imageUrl: '', artistId: '' };
    let editingId = null;
    let showAddInput = false;
    let artists = [];

    async function fetchArtists() {
        const response = await fetch(`${env.PUBLIC_BACKEND_URL}/api/artists/`);
        if (response.ok) {
            artists = await response.json();
        }
    }

    function fetchAlbums() {
        fetch(`${env.PUBLIC_BACKEND_URL}/api/albums/`)
            .then(response => response.json())
            .then(data => {
                albums = data;
            })
            .catch(error => console.error(error));
    }

    function removeAlbum(albumId) {
        const path = `${env.PUBLIC_BACKEND_URL}/api/albums/${albumId}`;
        fetch(path, { method: 'DELETE' })
            .then(() => {
                albums = albums.filter(album => album.id !== albumId);
            })
            .catch(error => {
                console.error(error);
            });
    }

    function addAlbum() {
        fetchArtists().then(() => {
            const selectedArtistId = newAlbum.artistId;
            const selectedArtist = artists.find(artist => artist.id === selectedArtistId);

            if (!selectedArtist) {
                console.error('Selected artist not found');
                return;
            }

            const albumData = {
                title: newAlbum.title,
                releaseDate: newAlbum.releaseDate,
                imageUrl: newAlbum.imageUrl,
                artistId: selectedArtistId
            };

            fetch(`${env.PUBLIC_BACKEND_URL}/api/albums/new/artist/${selectedArtistId}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(albumData)
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('Failed to add album');
                }
            })
            .then(data => {
                albums = [...albums, data];
                newAlbum = { title: '', releaseDate: '', imageUrl: '', artistId: '' };
                showAddInput = false;
            })
            .catch(error => {
                console.error(error);
            });
        });
    }

    function updateAlbum(albumId, album) {
        fetchArtists().then(() => {
            const selectedArtistId = album.artistId;
            const selectedArtist = artists.find(artist => artist.id === selectedArtistId);

            album.artist = selectedArtist;

            fetch(`${env.PUBLIC_BACKEND_URL}/api/albums/${albumId}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(album)
            })
            .then(response => {
                if (response.ok) {
                    const index = albums.findIndex(a => a.id === albumId);
                    if (index !== -1) {
                        albums[index] = album;
                        editingId = null;
                    }
                } else {
                    console.error('Failed to update album:', response.statusText);
                }
            })
            .catch(error => {
                console.error('Error updating album:', error);
            });
        });
    }


    onMount(fetchArtists);
    onMount(fetchAlbums);
</script>
<div class="mx-md-5 px-md-5">
    <p class="fs-1 mt-5">
        Albums
    </p>
    <hr>

    <div class="row table-container">
        <div class="col-2"></div>
        <table class="col-8 bg-dark text-light table-sm rounded round-3">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Release Date</th>
                    <th>Image URL</th>
                    <th>Artist</th>
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
                            <input type="text" class="form-control" bind:value={newAlbum.title} placeholder="Title" />
                        </td>
                        <td>
                            <input type="date" class="form-control" bind:value={newAlbum.releaseDate} />
                        </td>
                        <td>
                            <input type="text" class="form-control" bind:value={newAlbum.imageUrl} placeholder="Image URL" />
                        </td>
                        <td>
                            <select class="form-select" bind:value={newAlbum.artistId}>
                                {#each artists as artist}
                                    <option value={artist.id}>{artist.name}</option>
                                {/each}
                            </select>
                        </td>
                        <td>
                            <span style="float: right;">
                                <button class="btn btn-success" on:click={addAlbum}>
                                    <i class="fa fa-save"></i>
                                </button>
                                <button class="btn btn-danger" on:click={() => showAddInput = false}>
                                    <i class="fa fa-times"></i>
                                </button>
                            </span>
                        </td>
                    </tr>
                {/if}
                {#each albums as album, index}
                    <tr>
                        <td>
                            {#if editingId === album.id}
                                <input type="text" bind:value={album.title} />
                            {:else}
                                {album.title}
                            {/if}
                        </td>
                        <td>
                            {#if editingId === album.id}
                                <input type="date" bind:value={album.releaseDate} />
                            {:else}
                                {new Date(album.releaseDate).toLocaleDateString(undefined, { day: 'numeric', month: 'long', year: 'numeric' })}
                            {/if}
                        </td>
                                                
                        <td>
                            {#if editingId === album.id}
                                <input type="text" bind:value={album.imageUrl} />
                            {:else}
                                {album.imageUrl}
                            {/if}
                        </td>
                        <td>
                            {#if editingId === album.id}
                                <select bind:value={album.artistId}>
                                    {#each artists as artist}
                                        <option value={artist.id}>{artist.name}</option>
                                    {/each}
                                </select>
                            {:else}
                                {album.artist.name}
                            {/if}
                        </td>
                        <td>
                            {#if album.title}
                                <span style="float: right;">
                                    {#if editingId === album.id}
                                        <button class="btn btn-success" on:click={() => updateAlbum(album.id, album)}>
                                            <i class="fa fa-save"></i>
                                        </button>
                                    {:else}
                                        <button class="btn btn-primary" on:click={() => editingId = album.id}>
                                            <i class="fa fa-edit"></i>
                                        </button>
                                    {/if}
                                    <button class="btn btn-danger" on:click={() => removeAlbum(album.id)}>
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
