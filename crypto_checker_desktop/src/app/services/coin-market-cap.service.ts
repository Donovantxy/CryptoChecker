import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';

export class MappedQuotesLatest {
  id!: number;
  name!: string;
  symbol!: string;
  usd!: number;
  percDay!: number;

  constructor(quote: QuotesLatest) {
    this.id =  quote.id;
    this.name =  quote.name;
    this.symbol =  quote.symbol;
    this.usd =  quote.quote.USD.price;
    this.percDay =  quote.quote.USD.percent_change_24h;
  }
}

interface QuotesLatest {
  id: number;
  name: string;
  symbol: string;
  slug: string;
  num_market_pairs: number;
  date_added: string;
  tags: {
    slug: string,
    name: string,
    category: string,
  }[]
  max_supply: number;
  circulating_supply: number;
  total_supply: number;
  is_active: number;
  infinite_supply: boolean;
  platform: any;
  cmc_rank: number;
  is_fiat: number;
  self_reported_circulating_supply: number | null;
  self_reported_market_cap: number | null;
  tvl_ratio: number | null;
  last_updated: string;
  quote: {
    USD: {
      price: number,
      volume_24h: number,
      volume_change_24h: number,
      percent_change_1h: number,
      percent_change_24h: number,
      percent_change_7d: number,
      percent_change_30d: number,
      percent_change_60d: number,
      percent_change_90d: number,
      market_cap: number,
      market_cap_dominance: number,
      fully_diluted_market_cap: number,
      tvl: any,
      last_updated: string
    };
  };
}

@Injectable({
  providedIn: 'root',
})
export class CoinMarketCapService {
  private readonly COIN_MARKET_CAP_API_KEY ='****';

  constructor(private _httpClient: HttpClient) {}

  getTokenQuotes(ids: number[]): Observable<{[id: number]: MappedQuotesLatest}> {
    let quotes: {[id: number]: MappedQuotesLatest} = {};
    return this._httpClient
      .get<{ status: any; data: { [id: number]: QuotesLatest } }>(
        `https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?id=${ids.join(
          ','
        )}`,
        {
          headers: {
            'X-CMC_PRO_API_KEY': this.COIN_MARKET_CAP_API_KEY,
            Accept: 'application/json',
          },
        }
      )
      .pipe(
        map((res) => {
          if (res.data) {
            Object
            .values(res.data)
            .forEach(entry => {
              quotes[entry.id] = new MappedQuotesLatest(entry);
            });
            return quotes;
          }
          return {};
        })
      );
  }
}
