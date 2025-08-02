Ideally this will be one of the last plainly written docs like this
That said Jupyter itself is straightforward to add

The kernel however can be a bit more odd.
For Typescript's tslab for example there is some nuance to each step.
We have set our environment variables to do this already, but the default behavior of global installs will try placing the packages in the store which is obviously read only.
So instead we update those to point to our local users .local and place them there. That way we can globally install packages and reference them where needed.
A bit against the paradigm for Guix, but NPM is a pain to package otherwise. Unfortunately, sometimes you need certain packages globally if you want to keep your project dependencies clean. So the best you can do is keep your npm installs to a minimum globally.

Now as for installing the kernel to jupyter that is a bit strange itself. We can use a shell to create a clean environment and direct everything appropriately as tslab expects
guix shell python jupyter python-ipykernel nodejs -- tslab install

After that it is all good to go.