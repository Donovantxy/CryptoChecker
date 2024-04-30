import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { WalletListComponent } from './components/wallet-list/wallet-list.component';


export const routes: Routes = [
  { path: 'home', component: WalletListComponent },
  { path: '', redirectTo: '/home', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class RoutingModule { }