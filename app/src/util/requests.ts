import { env } from "$env/dynamic/public";

export async function login(username: string, email: string, password: string, saveToLocalStorage: boolean = true): Promise<{ userData: any, cookie: string } | null> {
    const response = await fetch(env.PUBLIC_BACKEND_URL + '/api/auth/signin', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ username, email, password })
    });

    if (response.ok) {
        const userData = await response.json();
        const cookie = response.headers.get('Set-Cookie');
        if (saveToLocalStorage) {
            localStorage.setItem('userData', JSON.stringify(userData));
        }
        return { userData, cookie };
    } else {
        console.error('Login failed');
        return null;
    }
}

export async function register(username: string, email: string, password: string): Promise<{ success: boolean, message?: string, cookie?: string }> {
    const response = await fetch(env.PUBLIC_BACKEND_URL + '/api/auth/signup', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ username, email, password })
    });

    if (response.ok) {
        const userData = await response.json();
        const cookie = response.headers.get('Set-Cookie');
        return { success: true, cookie };
    } else {
        const errorData = await response.json();
        console.error('Registration failed:', errorData.message);
        return { success: false, message: errorData.message };
    }
}

export async function logout(cookie: string): Promise<boolean> {
    const response = await fetch(env.PUBLIC_BACKEND_URL + '/api/auth/signout', {
        method: 'POST',
        headers: {
            'Cookie': cookie
        }
    });

    if (response.ok) {
        localStorage.removeItem('userData'); // Remove user data from localStorage on logout
        return true;
    } else {
        console.error('Logout failed');
        return false;
    }
}
