<script>
    import { onMount } from "svelte";
    import { env } from '$env/dynamic/public';
	import '@fortawesome/fontawesome-free/css/all.min.css';

    let genres = [];
    let newGenre = '';
    let editingId = null;
    let showAddInput = false;

    function getGenres() {
        fetch(`${env.PUBLIC_BACKEND_URL}/api/genres/`)
            .then(response => response.json())
            .then(data => {
                genres = data;
            })
            .catch(error => console.error(error));
    }

    function removeGenre(genreID) {
        const path = `${env.PUBLIC_BACKEND_URL}/api/genres/${genreID}`;
        fetch(path, { method: 'DELETE' })
            .then(() => {
                genres = genres.filter(genre => genre.id !== genreID);
            })
            .catch(error => {
                console.error(error);
            });
    }

    function addGenre() {
        fetch(`${env.PUBLIC_BACKEND_URL}/api/genres/`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ description: newGenre })
        })
        .then(response => response.json())
        .then(data => {
            genres = [...genres, data];
            newGenre = '';
            showAddInput = false; // Hide the input field after adding the new genre
        })
        .catch(error => {
            console.error(error);
        });
    }

    function updateGenre(genreID, description) {
        fetch(`${env.PUBLIC_BACKEND_URL}/api/genres/${genreID}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ description })
        })
        .then(() => {
            const index = genres.findIndex(genre => genre.id === genreID);
            if (index !== -1) {
                genres[index].description = description;
                editingId = null;
            }
        })
        .catch(error => {
            console.error(error);
        });
    }

    onMount(getGenres);
</script>

<div class="mx-md-5 px-md-5">
    <p class="fs-1 mt-5">
        Genres
    </p>
    <hr>

    <div class="row table-container">
        <div class="col-2"></div>
        <table class="col-8 bg-dark text-light table-sm rounded round-3">
            <thead>
                <tr>
                    <th>Description</th>
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
                            <input type="text" class="form-control" bind:value={newGenre} placeholder="New Genre" />
                        </td>
                        <td>
                            <span style="float: right;">
                                <button class="btn btn-success" on:click={addGenre}>
                                    <i class="fa fa-save"></i>
                                </button>
                                <button class="btn btn-danger" on:click={() => showAddInput = false}>
                                    <i class="fa fa-times"></i>
                                </button>
                            </span>
                        </td>
                    </tr>
                {/if}
                {#each genres as genre, index}
                    <tr>
                        <td>
                            {#if editingId === genre.id}
                                <input type="text" bind:value={genre.description} />
                            {:else}
                                {genre.description}
                            {/if}
                        </td>
                        <td>
                            {#if genre.description}
                                <span style="float: right;">
                                    {#if editingId === genre.id}
                                        <button class="btn btn-success" on:click={() => updateGenre(genre.id, genre.description)}>
                                            <i class="fa fa-save"></i>
                                        </button>
                                    {:else}
                                        <button class="btn btn-primary" on:click={() => editingId = genre.id}>
                                            <i class="fa fa-edit"></i>
                                        </button>
                                    {/if}
                                    <button class="btn btn-danger" on:click={() => removeGenre(genre.id)}>
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
