SHELL=/bin/bash
FL= flutter

.PHONY: fmt
fmt:
	$(FL) format --dry-run --set-exit-if-changed .

.PHONY: fmt-analyze
fmt-analyze:fmt
	$(FL) analyze

.PHONY: fa
fa: fmt-analyze

.PHONY: build-runner
build-runner:
	$(FL) packages pub run build_runner build --delete-conflicting-outputs

.PHONY: br
br: build-runner

.PHONY: brp
brp:
	$(FL) packages pub run build_runner build

.PHONY: l10n-gen
l10n-gen:
	@$(FL) pub run intl_utils:generate
.PHONY: l10n
l10n: l10n-gen

.PHONY: clean
clean:
	@$(FL) clean && $(FL) pub get
