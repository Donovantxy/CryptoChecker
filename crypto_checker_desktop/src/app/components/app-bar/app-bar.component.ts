import { CommonModule, CurrencyPipe } from '@angular/common';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Store } from '@ngxs/store';
import { Observable, map, reduce, tap } from 'rxjs';
import { CryptoState, CryptoStateModel, SortBy, Sorting } from '../../store/crypto.state';
import { Token } from '../../store/token.model';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectChange, MatSelectModule } from '@angular/material/select';
import { SetSortByAction, SetSortingAction } from '../../store/crypto.actions';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-app-bar',
  standalone: true,
  imports: [CommonModule, CurrencyPipe, MatFormFieldModule, MatSelectModule],
  templateUrl: './app-bar.component.html',
  styleUrl: './app-bar.component.scss'
})
export class AppBarComponent implements OnInit {

  @Input({required: true}) title!: string;
  @Output() menuClicked = new EventEmitter();

  capitalSelector$!: Observable<number>;
  
  sortByOptions = SortBy;
  currentSortBy!: SortBy;
  
  currentSortingOptions = Sorting;
  currentSorting!: Sorting;

  constructor(
    public readonly store: Store
  ) {}

  ngOnInit() {
    this.capitalSelector$ = this.store.select(CryptoState.tokens)
      .pipe(map((tokens: Token[]) => tokens.reduce((capital, token) => capital + token.bagSize*token.price, 0)));

    this.currentSortBy = this.store.selectSnapshot<CryptoStateModel>(CryptoState).sortBy;
    this.currentSorting = this.store.selectSnapshot<CryptoStateModel>(CryptoState).sorting;
  }

  sortByChanged(ev: MatSelectChange) {
    this.store.dispatch(new SetSortByAction(ev.value));
  }
  
  sortingChanged() {
    this.store.dispatch(new SetSortingAction(this.currentSorting === Sorting.ASC ? Sorting.DESC : Sorting.ASC))
    .subscribe(({crypto}) => {
      this.currentSorting = crypto.sorting;
    })
  }

}
