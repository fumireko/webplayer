export function saveCookie(cookie: string): void {
    localStorage.setItem('cookie', cookie);
}

export function getCookie(): string | null {
    return localStorage.getItem('cookie');
}

export function removeCookie(): void {
    localStorage.removeItem('cookie');
}
