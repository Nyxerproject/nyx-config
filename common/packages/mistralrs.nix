{
  pkgs,
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  # nativeBuildInputs
  pkg-config,
  python3,
  autoPatchelfHook,
  autoAddDriverRunpath,
  # buildInputs
  oniguruma,
  openssl,
  mkl,
  # env
  fetchurl,
  versionCheckHook,
  testers,
  mistral-rs,
  nix-update-script,
  cudaPackages,
  cudaCapability ? null,
  config,
  # one of `[ null false "cuda" "mkl" "metal" ]`
  acceleration ? null,
  ...
}: let
  inherit (stdenv) hostPlatform;

  accelIsValid = builtins.elem acceleration [
    null
    false
    "cuda"
  ];

  cudaSupport = assert accelIsValid;
  (acceleration == "cuda") || (config.cudaSupport && acceleration == null);

  minRequiredCudaCapability = "6.1"; # build fails with 6.0
  inherit (cudaPackages.flags) cudaCapabilities;
  cudaCapabilityString =
    if cudaCapability == null
    then
      (builtins.head (
        (builtins.filter (cap: lib.versionAtLeast cap minRequiredCudaCapability) cudaCapabilities)
        ++ [ (lib.warn "mistral-rs doesn't support ${lib.concatStringsSep " " cudaCapabilities}" minRequiredCudaCapability) ]
      ))
    else cudaCapability;
  cudaCapability' = lib.toInt (cudaPackages.flags.dropDot cudaCapabilityString);

in {
  commonArgs = {
    # strictDeps = true;
    nativeBuildInputs =
      [
        pkg-config
        python3
        autoPatchelfHook
        autoAddDriverRunpath
        cudaPackages.cuda_nvcc
      ];

    buildInputs =
      [
        oniguruma
        openssl
        cudaPackages.cuda_cccl
        cudaPackages.cuda_cudart
        cudaPackages.cuda_nvrtc
        cudaPackages.libcublas
        cudaPackages.libcurand
      ]

    src = craneLib.fetchFromGitHub {
      owner = "EricLBuehler";
      repo = "mistral.rs";
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    patches = [./no-native-cpu.patch];

    useFetchCargoVendor = true;
    cargoHash = "sha256-YGGtS8gJJQKIgXxMWjO05ikSVdfVNs+cORbJ+Wf88y4=";

    buildFeatures = lib.optionals cudaSupport ["cuda"];

    env =
      {
        SWAGGER_UI_DOWNLOAD_URL = let
          swaggerUiVersion = "5.17.12";
          swaggerUi = fetchurl {
            url = "https://github.com/swagger-api/swagger-ui/archive/refs/tags/v${swaggerUiVersion}.zip";
            hash = "sha256-HK4z/JI+1yq8BTBJveYXv9bpN/sXru7bn/8g5mf2B/I=";
          };
        in "file://${swaggerUi}";

        RUSTONIG_SYSTEM_LIBONIG = true;
      }
      // {
        CUDA_COMPUTE_CAP = cudaCapability';
        CUDA_TOOLKIT_ROOT_DIR = lib.getDev cudaPackages.cuda_cudart;
      };

    appendRunpaths = [
      (lib.makeLibraryPath [
        cudaPackages.libcublas
        cudaPackages.libcurand
      ])
    ];

    preCheck = ''
      rm -rf target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/build/
    '';

    # Prevent checkFeatures from inheriting buildFeatures because
    # - `cargo check ... --features=cuda` requires access to a real GPU
    # - `cargo check ... --features=metal` (on darwin) requires the sandbox to be completely disabled
    checkFeatures = [];

    # Try to access internet
    checkFlags = [
      "--skip=gguf::gguf_tokenizer::tests::test_encode_decode_gpt2"
      "--skip=gguf::gguf_tokenizer::tests::test_encode_decode_llama"
      "--skip=util::tests::test_parse_image_url"
    ];

    nativeInstallCheckInputs = [
      versionCheckHook
    ];
    versionCheckProgram = "${placeholder "out"}/bin/mistralrs-server";
    versionCheckProgramArg = "--version";
    doInstallCheck = true;

    passthru = {
      tests = {
        version = testers.testVersion {package = mistral-rs;};

        withMkl = lib.optionalAttrs (hostPlatform.isLinux && hostPlatform.isx86_64) (
          mistral-rs.override {acceleration = "mkl";}
        );
        withCuda = lib.optionalAttrs hostPlatform.isLinux (mistral-rs.override {acceleration = "cuda";});
        withMetal = lib.optionalAttrs (hostPlatform.isDarwin && hostPlatform.isAarch64) (
          mistral-rs.override {acceleration = "metal";}
        );
      };
      updateScript = nix-update-script {};
    };
  };
  mistral-rs-updated = craneLib.cargoNextest commonArgs;
}
