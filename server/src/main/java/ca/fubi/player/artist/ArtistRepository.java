package ca.fubi.player.artist;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

import ca.fubi.player.genre.Genre;

@Repository
public interface ArtistRepository extends JpaRepository<Artist, Long>{
	Optional<Artist> findById(Long id);
	Optional<Artist> findByName(String name);
	List<Artist> findByCountryCode(EnumCountry countryCode);
	List<Artist> findByGenres(Genre genres);
}
