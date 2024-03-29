package ca.fubi.player.song;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import ca.fubi.player.album.Album;
import ca.fubi.player.file.FileInfo;
import ca.fubi.player.playlist.Playlist;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "tb_songs")
public class Song {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_song")
	private Long id;
	
	@NotBlank
	@Size(max = 512)
	@Column(name = "song_title")
	private String title;
	
	@Column(name = "song_length")
	private int length;
	
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_file", referencedColumnName = "id_file")
    private FileInfo file;
	
	@ManyToOne
	@JsonIgnoreProperties("songs")
	@JoinColumn(name = "fk_album")
	private Album album;

	@JsonIgnore
	@ManyToMany(mappedBy = "songs")
	private List<Playlist> playlists = new ArrayList<>();
	
	public Song() {}
	
	public Song(String title, int length, Album album) {
		this.setTitle(title);
		this.setLength(length);
		this.setAlbum(album);
	}
	
	//Getters and setters
	
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public int getLength() {
		return length;
	}
	
	public void setLength(int length) {
		this.length = length;
	}
	
	public FileInfo getFile() {
		return file;
	}
	
	public void setFile(FileInfo file) {
		this.file = file;
	}
	
	public Album getAlbum() {
		return album;
	}
	
	public void setAlbum(Album album) {
		this.album = album;
	}
	
	public List<Playlist> getPlaylists() {
		return playlists;
	}
	
	public void setPlaylists(List<Playlist> playlists) {
		this.playlists = playlists;
	}
}
