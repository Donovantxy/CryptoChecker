import { DestroyRef, Directive, ElementRef, EventEmitter, OnInit, Output, Renderer2, inject } from '@angular/core';
import { fromEvent, timer } from 'rxjs';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { DecimalPipe, formatNumber } from '@angular/common';

@Directive({
  selector: '[appInputBagSize]',
  standalone: true,
})
export class InputBagSizeDirective implements OnInit {

  @Output() newValue = new EventEmitter<number>();
  
  private readonly _destroyRef = inject(DestroyRef);
  
  constructor(private _elementRef: ElementRef, private _renderer: Renderer2) { }

  ngOnInit(): void {
    this.focusAndSelect();
    this.onTyping();
    this.emitNewValue();
  }

  onTyping() {
    fromEvent(this._elementRef.nativeElement, 'input')
    .pipe(takeUntilDestroyed(this._destroyRef))
    .subscribe(() => {
      this._elementRef.nativeElement.value = this.formatToNumber(this._elementRef.nativeElement.value);
    })
  }

  emitNewValue() {
    fromEvent<KeyboardEvent>(this._elementRef.nativeElement, 'keyup')
    .pipe(takeUntilDestroyed(this._destroyRef))
    .subscribe(ev => {
      if ( ev.key === 'Enter' ) {
        this.newValue.emit(Number(this._elementRef.nativeElement.value.replace(/,/g, '')));
      }
    });
  }

  private formatToNumber(value: string): string {
    value = value ? value.replace(/[^0-9]/g, '') : '0';
    return parseInt(value).toLocaleString();
  }
  
  private focusAndSelect() {
    const element = this._elementRef.nativeElement;
    this._renderer.selectRootElement(element).focus();
    timer(30).subscribe(() => {
      this._elementRef.nativeElement.value = this.formatToNumber(this._elementRef.nativeElement.value);
      element.select();
    });
  }

}
