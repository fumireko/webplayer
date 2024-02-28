package ca.fubi.player.repository;

import java.util.Optional;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ca.fubi.player.models.Artist;
import ca.fubi.player.models.Genre;

import java.util.List;
import ca.fubi.player.models.enums.EnumCountry;

@Repository
public interface ArtistRepository extends JpaRepository<Artist, Long>{
	Optional<Artist> findById(Long id);
	Optional<Artist> findByName(String name);
	List<Artist> findByCountryCode(EnumCountry countryCode);
	List<Artist> findByGenres(Genre genres);
}
