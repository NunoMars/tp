import os
from pathlib import Path

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = Path(__file__).resolve(strict=True).parent.parent
# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = "\\\ta(xZQ;xUIly1X@IGT:4re$"
# SECURITY WARNING: don't run with debug turned on in production!

DB_HOST = os.environ.get("DB_HOST")
DB_PORT = os.environ.get("DB_PORT")
DB_PASSWORD = os.environ.get("POSTGRES_PASSWORD")
DB_USER = os.environ.get("POSTGRES_USER")
ENV = os.environ.get("ENVIROMENT")
REDIS_HOST = os.environ.get("REDIS_HOST", "localhost")
REDIS_PORT = os.environ.get("REDIS_PORT", 6379)
REDIS_BD_PASSWORD = os.environ.get("POSTGRES_PASSWORD")
DEBUG = True  # if ENV == "dev" else False


ALLOWED_HOSTS = ["*"]


# Application definition

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "ball8.apps.Ball8Config",
    "clairvoyance.apps.ClairvoyanceConfig",
    "accounts.apps.AccountsConfig",
    "import_export",
    "responses.apps.ResponsesConfig",
    "health_check",
    "django_prometheus",
]


######################AUTH#########################
AUTH_USER_MODEL = "accounts.CustomUser"
AUTHENTIFICATION_BACKENDS = "accounts.backends.CustomUserAuth"
LOGOUT_REDIRECT_URL = "home"
LOGIN_REDIRECT_URL = "history"
LOGIN_URL = "login"
###################################################


########################EMAIL######################
EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
EMAIL_HOST = "smtp.gmail.com"
EMAIL_USE_TLS = True
# EMAIL_USE_SSL = True
EMAIL_PORT = 587
# EMAIL_PORT_SSL = 465
EMAIL_HOST_USER = "patricia.nunes.tarot@gmail.com"  # os.environ.get("EMAIL_HOST_USER")
EMAIL_HOST_PASSWORD = "Ruben1Mara2"  # os.environ.get("EMAIL_HOST_PASSWORD")

###################################################

MIDDLEWARE = [
    "django_prometheus.middleware.PrometheusBeforeMiddleware",
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.locale.LocaleMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
    "whitenoise.middleware.WhiteNoiseMiddleware",
    "django_prometheus.middleware.PrometheusAfterMiddleware",
]

ROOT_URLCONF = "siteVoyanceconfig.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [os.path.join(BASE_DIR, "templates")],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
                "django.template.context_processors.i18n",
            ],
        },
    },
]

WSGI_APPLICATION = "siteVoyanceconfig.wsgi.application"


# Database
# https://docs.djangoproject.com/en/3.0/ref/settings/#databases


SESSION_ENGINE = "redis_sessions.session"
SESSION_REDIS = {
    "host": REDIS_HOST,
    "port": REDIS_PORT,
    "db": 0,
    "password": REDIS_BD_PASSWORD,
    "prefix": "session",
    "socket_timeout": 1,
    "retry_on_timeout": False,
}

DATABASES = (
    {
        "default": {
            "ENGINE": "django_prometheus.db.backends.postgresql",
            "NAME": "VoyanceDB",
            "USER": DB_USER,
            "PASSWORD": DB_PASSWORD,
            "HOST": DB_HOST,
            "PORT": DB_PORT,
            "CHARDSET": "utf8",
        }
    }
    if ENV == "prod"
    else {
        "default": {
            "ENGINE": "django_prometheus.db.backends.postgresql",
            "NAME": "VoyanceDB",
            "USER": "nuno",
            "PASSWORD": "Bcxau9p^^123.",
            "HOST": "localhost",
            "PORT": "5432",
            "CHARDSET": "utf8",
        }
    }
)

# Password validation
# https://docs.djangoproject.com/en/3.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        "NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.MinimumLengthValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.CommonPasswordValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.NumericPasswordValidator",
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.0/topics/i18n/

LANGUAGE_CODE = "en-US"

TIME_ZONE = "UTC"

USE_I18N = True

USE_L10N = True

USE_TZ = True

#############################################################
MEDIA_ROOT = os.path.join(BASE_DIR, "media")
MEDIA_URL = "/media/"
STATIC_ROOT = os.path.join(BASE_DIR, "staticfiles")
STATIC_URL = "/static/"
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, "static"),
]
STATICFILES_STORAGE = "whitenoise.storage.CompressedManifestStaticFilesStorage"

#############################################################

PROMETHEUS_LATENCY_BUCKETS = (
    0.01,
    0.025,
    0.05,
    0.075,
    0.1,
    0.25,
    0.5,
    0.75,
    1.0,
    2.5,
    5.0,
    7.5,
    10.0,
    25.0,
    50.0,
    75.0,
    float("inf"),
)
