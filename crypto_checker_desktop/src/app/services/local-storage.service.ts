import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class LocalStorageService {
  get<T>(key: string): T | null {
    const result = localStorage.getItem(key);
    if (result !== null && result !== '') {
      return JSON.parse(result);
    }
    return null;
  }

  set<T>(key: string, body: T) {
    localStorage.setItem(key, JSON.stringify(body));
  }

  remove(key: string) {
    localStorage.removeItem(key);
  }
}