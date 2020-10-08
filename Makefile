
.PHONY: dist

up:
	@docker-compose up -d

vendor:
	@docker-compose run --rm vtiger bash -c "cd modules/Composer && rm -fr vendor composer.lock"
	@docker-compose run --rm vtiger bash -c "cd modules/Composer && composer install"

dist:
	@zip -qq -r dist/Composer.zip manifest.xml languages LICENSE modules

import: dist up
	@docker-compose run --rm vtiger bash -c "rm logs/composer.log || true"
	@echo "\n====[ IMPORT ]===="
	@docker-compose exec vtiger php -f /var/www/html/vtlib/tools/console.php -- --import=/app/dist/Composer.zip
	@#@docker-compose exec vtiger cat /var/www/html/composer.json

update: dist up
	@docker-compose run --rm vtiger bash -c "rm logs/composer.log || true"
	@echo "\n====[ UPDATE ]===="
	@docker-compose exec vtiger php -f /var/www/html/vtlib/tools/console.php -- --update=/app/dist/Composer.zip
	@#@docker-compose exec vtiger cat /var/www/html/composer.json

##
## Testing
##
test-import: dist up
	@docker-compose exec vtiger bash -c "rm -fr /app/logs/composer.log || true"
	@docker-compose exec vtiger bash -c "rm -fr /var/www/html/composer.json || true"
	@docker-compose exec vtiger bash -c "rm -fr /var/www/html/composer.lock || true"
	@docker-compose exec vtiger bash -c "rm -fr /var/www/html/vendor || true"
	@docker-compose exec vtiger bash -c "rm -fr /var/www/html/test/composer || true"
	@docker-compose exec vtiger php -f /var/www/html/vtlib/tools/console.php -- --remove=Composer
	@echo ""
	@echo "====[ IMPORT ]===="
	@docker-compose exec vtiger php -f /var/www/html/vtlib/tools/console.php -- --import=/app/dist/Composer.zip
	@#@docker-compose exec vtiger cat /var/www/html/composer.json

