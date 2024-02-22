package ca.fubi.player.models;

import java.util.ArrayList;
import java.util.List;

import ca.fubi.player.models.relations.PlaylistSong;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "tb_playlists")
public class Playlist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_playlist")
    private Long id;

    @NotBlank
    @Size(max = 100)
    @Column(name = "playlist_name")
    private String name;

    @ManyToOne
    @JoinColumn(name = "fk_user")
    private User user;

    @OneToMany(mappedBy = "playlist")
    private List<PlaylistSong> songs = new ArrayList<>(); // Changed to PlaylistSong association

    public Playlist() {}
    
    public Playlist(String name, User user) {
    	this.setName(name);
    	this.setUser(user);
    }
    
    public Long getId() {
		return id;
	}
    
    public void setId(Long id) {
		this.id = id;
	}
    
    public String getName() {
		return name;
	}
    
    public void setName(String name) {
		this.name = name;
	}
    
    public User getUser() {
		return user;
	}
    
    public void setUser(User user) {
		this.user = user;
	}
    
    public List<PlaylistSong> getPlaylistSongs() {
        return songs;
    }

    public void addPlaylistSong(PlaylistSong playlistSong) {
    	playlistSong.setPlaylist(this); 
    	songs.add(playlistSong);
    }
    
    public void setPlaylistSongs(List<PlaylistSong> playlistSongs) {
		this.songs = playlistSongs;
	}
}
