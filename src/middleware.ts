app.use((req, res, next) => {
  if (req.path.startsWith('/auth')) return next();

  const auth = req.headers.authorization;
  if (!auth) return res.status(401).json({ error: 'Missing token' });

  next();
});
