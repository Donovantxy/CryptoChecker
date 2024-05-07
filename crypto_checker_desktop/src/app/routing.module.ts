import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { WalletListComponent } from './components/views/wallet-list/wallet-list.component';
import { AvailableTokensComponent } from './components/views/available-tokens/available-tokens.component';

export const routes: Routes = [
  { path: 'wallet', title: 'Wallet', component: WalletListComponent },
  { path: 'token-list', title: 'Tokens List', component: AvailableTokensComponent },
  { path: '', redirectTo: '/wallet', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class RoutingModule { }