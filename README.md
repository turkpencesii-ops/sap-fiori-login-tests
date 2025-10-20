# SAP Fiori Login Tests (Robot Framework + Browser Library)

This repo demonstrates a clean, CI-ready **login automation** with Robot Framework.
It ships with a **working demo** against a public site so your CI passes out-of-the-box,
and can be **switched to SAP Fiori Launchpad** by changing variables/selectors.

## Tech
- Robot Framework
- robotframework-browser (Playwright)
- GitHub Actions CI

## Structure
```
.
├── tests/
│   └── login.robot
├── resources/
│   └── keywords.robot
├── variables/
│   └── credentials.example.yaml
├── .github/workflows/ci.yml
├── requirements.txt
├── .env.example
└── README.md
```

## Local Run
```bash
pip install -r requirements.txt
rfbrowser init
cp variables/credentials.example.yaml variables/credentials.yaml

# Demo (immediate green run)
robot -v PROFILE:demo tests

# SAP (update selectors + credentials)
robot -v PROFILE:sap tests
```
