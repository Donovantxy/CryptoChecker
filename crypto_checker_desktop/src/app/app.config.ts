import { ApplicationConfig, importProvidersFrom } from '@angular/core';
import { provideRouter } from '@angular/router';
import { routes } from './routing.module';
import { NgxsModule } from '@ngxs/store';
import { NgxsReduxDevtoolsPluginModule } from '@ngxs/devtools-plugin';
import { CryptoState } from './store/crypto.state';
import { HttpClientModule } from '@angular/common/http';


export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    importProvidersFrom(
      HttpClientModule,
      NgxsModule.forRoot([CryptoState]),
      NgxsReduxDevtoolsPluginModule.forRoot()
    )
  ],
};
