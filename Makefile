clean:
	flutter clean

rebuild:
	@make clean
	flutter pub get

gen:
	@make rebuild
	dart run build_runner build --delete-conflicting-outputs

