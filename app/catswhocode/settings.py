import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

SECRET_KEY = os.environ['DJANGO_SECRET_KEY']

DEBUG = bool(os.environ.get('DJANGO_DEBUG', False))

ALLOWED_HOSTS = ['api']

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'rest_framework',
    'rest_framework.authtoken',
    'django_filters',

    'health_check',
    'health_check.db',
    'health_check.cache',
    'health_check.storage',

    'members',
    'cats',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',

    'whitenoise.middleware.WhiteNoiseMiddleware',

    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'catswhocode.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'catswhocode.wsgi.application'

# Database
# https://docs.djangoproject.com/en/1.11/ref/settings/#databases

# TODO: Use IAM role auth https://stackoverflow.com/questions/44710284/iam-database-authentication-how-to-use-cli-generated-token
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.environ['DB_NAME'],
        'USER': os.environ['DB_USER'],
        'PASSWORD': os.environ['DB_PASSWORD'],
        'HOST': os.environ['DB_HOST'],
        'PORT': os.environ.get('DB_PORT', '3306'),
        'OPTIONS': {},
    }
}

# Cache
CACHES = {
    'default': {
        'BACKEND': 'redis_cache.RedisCache',
        'LOCATION': '{}:{}'.format(os.environ['CACHE_HOST'], os.environ.get('CACHE_PORT', '6379')),
        'OPTIONS': {
            'DB': 1,
        },
    },
}

# Sessions
SESSION_ENGINE = 'django.contrib.sessions.backends.cache'

# Password validation
# https://docs.djangoproject.com/en/1.11/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator'},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = False
USE_L10N = False
USE_TZ = True

S3_USE_SIGV4 = True
AWS_STORAGE_BUCKET_NAME = os.environ['S3_BUCKET_NAME']

STATICFILES_STORAGE = 'catswhocode.storage.StaticStorage'
STATICFILES_LOCATION = os.environ['STATICFILES_PATH_PREFIX']
STATIC_URL = os.environ['STATICFILES_BASE_URL']

DEFAULT_FILE_STORAGE = 'catswhocode.storage.MediaStorage'
MEDIAFILES_LOCATION = os.environ['MEDIAFILES_PATH_PREFIX']
MEDIA_URL = os.environ['MEDIAFILES_BASE_URL']

# REST Framework
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.TokenAuthentication',
    )
}

if DEBUG:
    ALLOWED_HOSTS = ['0.0.0.0', 'localhost', 'api', '*']
    INTERNAL_IPS = ['127.0.0.1']

    INSTALLED_APPS += ['django_extensions', ]

    EMAIL_HOST = 'mail'
    EMAIL_PORT = 25

    AWS_S3_SECURE_URLS = False
    AWS_S3_ENDPOINT_URL = 'http://s3:9000'
    AWS_S3_CUSTOM_DOMAIN = os.environ.get('AWS_S3_CUSTOM_DOMAIN', 'localhost:9000/cats-who-code')
    AWS_S3_URL_PROTOCOL = 'http:'
    AWS_ACCESS_KEY_ID = 'JZ2ACMY43EXTMVWVOYZD'
    AWS_SECRET_ACCESS_KEY = '7Xn9y+YKQdJ2azRR2QmKDqa9ksa4zfwGcyjq/saS'
