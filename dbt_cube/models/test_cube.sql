version: 2

models:
    - name:  cube_measures
      description: Test Cube measures
      columns:
        - name: session
          description: sum(session)
          tests:
            - not_null
        - name: bounces
          description: sum(bounces)
          tests:
            - not_null