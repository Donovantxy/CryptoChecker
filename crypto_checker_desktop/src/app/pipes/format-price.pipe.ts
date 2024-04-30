import { CurrencyPipe } from '@angular/common';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'formatPrice',
  standalone: true,
})
export class FormatPricePipe implements PipeTransform {
  
  transform(value: number, ...args: unknown[]): string {
    const currencyPipe = new CurrencyPipe('en-US');
    if (value === 0) return '$0.00';
    let nZeros = 0;
    let priceUnderOne = value;
    while (priceUnderOne < 1) {
      priceUnderOne *= 10;
      nZeros++;
    }
    return currencyPipe.transform(value, '$', 'symbol', `1.${2 + nZeros}`)!;
  }
}
