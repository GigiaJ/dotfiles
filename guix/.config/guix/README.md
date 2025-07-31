At some point a notebook for this would be cool? I don't know if Jupyter supports Scheme and Guile though...

Anyway,
guix system image -L /home/jaggar/dotfiles/guix/.config/guix/firmware-packages -t efi-raw system.scm
Is how we generate a Macbook image.
The -L flag prepends the directory you specify to the front of Guile's existing module load path.



Wild issue but if you're missing a package then:
zsh: floating point exception  <package-command>
is what will be thrown. Really odd, but just install whatever is missing.


Caddy CA so we can access code-server via floorp will be generated 
/home/jaggar/.config/caddy/data/caddy/pki/authorities/local/root.crt
can copy that to home and chmod 777 it then just go to the certs setting in Floorp and import it