{pkgs, ...}: {
  services.jupyter = {
    enable = false;
    command = "jupyter notebook";
    ip = "127.0.0.1";
    port = 8888;
    user = "atp";
    group = "users";
    password = "argon2:$argon2id$v=19$m=10240,t=10,p=8$AsKAIexdBAxO5vimZYyCyA$fCN4QSJpaMAWHG7GUMIJHdxu0W9uXgEPh7jfVXoHZEQ";
    # extraPackages = [
    #   pkgs.python3.pkgs.requests
    #   pkgs.python3.pkgs.numpy
    #   pkgs.python3.pkgs.nbconvert
    #   pkgs.python3.pkgs.playwright
    # ];
    kernels = {
      python3 = let
        env = (
          pkgs.python3.withPackages (
            pythonPackages:
              with pythonPackages; [
                ipykernel
                pandas
                scikit-learn
                requests
                numpy
                matplotlib
                seaborn
                pycryptodome
              ]
          )
        );
      in {
        displayName = "Python 3 for machine learning";
        argv = [
          "${env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
        language = "python";
      };
    };
  };
}
