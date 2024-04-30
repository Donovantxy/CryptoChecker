import { Component, DoCheck, Input, OnChanges, OnInit, SimpleChanges, ViewChild } from '@angular/core';
import { MatCard } from '@angular/material/card';
import { Token } from '../../store/token.model';
import { CommonModule } from '@angular/common';
import { FormatPricePipe } from '../../pipes/format-price.pipe';
import { FormsModule } from '@angular/forms';
import { MatInputModule } from '@angular/material/input';
import { InputBagSizeDirective } from '../../directives/input-bag-size.directive';
import { Store } from '@ngxs/store';
import { SetTokenBagSizeAction } from '../../store/crypto.actions';

@Component({
  selector: 'app-token-list-item',
  standalone: true,
  imports: [CommonModule, MatCard, FormatPricePipe, FormsModule, InputBagSizeDirective],
  templateUrl: './token-list-item.component.html',
  styleUrl: './token-list-item.component.scss',
})
export class TokenListItemComponent implements OnInit {
  
  @Input({ required: true }) token!: Token;
  @ViewChild('bagSizeInput') input?: HTMLInputElement;
  bagSize: number = 0;
  isBagSizeInputVisible = false;

  constructor(private _store: Store) {}

  ngOnInit(): void {
    this.bagSize = this.token.bagSize;
  }

  showBagSizeField() {
    this.isBagSizeInputVisible = !this.isBagSizeInputVisible;
    this.bagSize = this.token.bagSize;
  }

  dispatchNewBagSize(newBagSize: number) {
    this._store.dispatch(new SetTokenBagSizeAction(this.token.id, newBagSize));
    this.isBagSizeInputVisible = false;
  }

}
