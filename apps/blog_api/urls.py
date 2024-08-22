from django.urls import path, include, re_path
from drf_spectacular.views import SpectacularAPIView, SpectacularRedocView, SpectacularSwaggerView

from .views import PostAPIDetail, PostAPIUpdate, PostAPIDestroy, PostAPIList
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView, TokenVerifyView


urlpatterns = [
    path('drf-auth/', include('rest_framework.urls')),
    path('post/', PostAPIList.as_view()),
    path('post/<int:pk>/', PostAPIDetail.as_view()),
    path('post_update/<int:pk>/', PostAPIUpdate.as_view()),
    path('post_delete/<int:pk>/', PostAPIDestroy.as_view()),
    path('auth/', include('djoser.urls')),
    path('auth/', include('djoser.urls.authtoken')),
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('token/verify/', TokenVerifyView.as_view(), name='token_verify'), #path('api/v1/token/', include('djoser.urls.jwt')),
    path("schema/", SpectacularAPIView.as_view(), name="schema"),
    path("schema/redoc/", SpectacularRedocView.as_view(url_name="schema"), name="redoc"),
    path("schema/swagger-ui/", SpectacularSwaggerView.as_view(url_name="schema"), name="swagger-ui")
]