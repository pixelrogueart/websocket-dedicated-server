import './globals.css'
import { Oswald } from 'next/font/google'

const inter = Oswald({ subsets: ['latin'] })

export const metadata = {
  title: 'PIXELROGUEART',
  description: 'Pixel Art, Animations and Game Dev.',
  icons: {
    icon:'/icons/favicon.svg',
  },
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  )
}
