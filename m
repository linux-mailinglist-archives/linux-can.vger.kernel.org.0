Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC978755
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2019 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfG2I1I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Jul 2019 04:27:08 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52815 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfG2I1I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Jul 2019 04:27:08 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hs0zp-0002Vk-Mq; Mon, 29 Jul 2019 10:27:05 +0200
Received: from [IPv6:2a03:f580:87bc:d400:595f:209f:a34b:fbc1] (unknown [IPv6:2a03:f580:87bc:d400:595f:209f:a34b:fbc1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DC54C43AC1D;
        Mon, 29 Jul 2019 08:27:02 +0000 (UTC)
To:     Tom Prohaszka <tprohaszka@capp-tech.com>
Cc:     linux-can@vger.kernel.org, kernel@martin.sperl.org
References: <CANRGksjUg8r5zwCpnat_UhX0EP3PDcyazApNSxqc6R_iu0Tqtg@mail.gmail.com>
 <d48e0b11-2fa7-eafe-6ec5-fe4a84e33c14@pengutronix.de>
 <CANRGksi1Wk2qoeSGTG+q4KBjRDxa_qZQCxyamr5PXOeM62witA@mail.gmail.com>
 <5cf240d7-f9bc-1cff-5ce0-bd3f5f437d9c@pengutronix.de>
 <CANRGkshiaL9QXMt8s15FydRdL9uF-zBqKw07fVn6JvJaob0umw@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: Microchip mcp25xxfd can controller driver- BUG: using
 __this_cpu_add() in preemptible
Message-ID: <f6c215d0-59c1-dcc2-7605-70198ef3f9ad@pengutronix.de>
Date:   Mon, 29 Jul 2019 10:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRGkshiaL9QXMt8s15FydRdL9uF-zBqKw07fVn6JvJaob0umw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7w01Xt2CBIQ5dAk6yFYTf6IcQj3i2JqtJ"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7w01Xt2CBIQ5dAk6yFYTf6IcQj3i2JqtJ
Content-Type: multipart/mixed; boundary="e4kgwdwcYMCXRlxtGqZxXWJclEZZJ1LKU";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tom Prohaszka <tprohaszka@capp-tech.com>
Cc: linux-can@vger.kernel.org, kernel@martin.sperl.org
Message-ID: <f6c215d0-59c1-dcc2-7605-70198ef3f9ad@pengutronix.de>
Subject: Re: Microchip mcp25xxfd can controller driver- BUG: using
 __this_cpu_add() in preemptible
References: <CANRGksjUg8r5zwCpnat_UhX0EP3PDcyazApNSxqc6R_iu0Tqtg@mail.gmail.com>
 <d48e0b11-2fa7-eafe-6ec5-fe4a84e33c14@pengutronix.de>
 <CANRGksi1Wk2qoeSGTG+q4KBjRDxa_qZQCxyamr5PXOeM62witA@mail.gmail.com>
 <5cf240d7-f9bc-1cff-5ce0-bd3f5f437d9c@pengutronix.de>
 <CANRGkshiaL9QXMt8s15FydRdL9uF-zBqKw07fVn6JvJaob0umw@mail.gmail.com>
In-Reply-To: <CANRGkshiaL9QXMt8s15FydRdL9uF-zBqKw07fVn6JvJaob0umw@mail.gmail.com>

--e4kgwdwcYMCXRlxtGqZxXWJclEZZJ1LKU
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 7/28/19 9:37 PM, Tom Prohaszka wrote:
> Hey Marc,
> I added the options below, but it doesn't look like the stack is dumpin=
g.

Thanks, that's indeed a proper stack dump, which is a different name for
backtrace.

> check_preemption_disabled: 143 callbacks suppressed
> BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp=
25xx/805
> caller is __this_cpu_preempt_check+0x1c/0x20
> CPU: 0 PID: 805 Comm: irq/194-mcp25xx Tainted: G           O
> 4.9.65-dey+gf832589 #44
> Hardware name: Freescale i.MX6 UltraLite (Device Tree)
> [<80111790>] (unwind_backtrace) from [<8010d6cc>] (show_stack+0x20/0x24=
)
> [<8010d6cc>] (show_stack) from [<804c1c94>] (dump_stack+0xa0/0xcc)
> [<804c1c94>] (dump_stack) from [<804e1ad8>]
> (check_preemption_disabled+0x130/0x134)
> [<804e1ad8>] (check_preemption_disabled) from [<804e1b1c>]
> (__this_cpu_preempt_check+0x1c/0x20)
> [<804e1b1c>] (__this_cpu_preempt_check) from [<80804284>]
> (__netif_receive_skb_core+0x118/0xa60)
> [<80804284>] (__netif_receive_skb_core) from [<80806ffc>]
> (__netif_receive_skb+0x38/0x94)
> [<80806ffc>] (__netif_receive_skb) from [<808070e8>]
> (netif_receive_skb_internal+0x90/0x21c)
> [<808070e8>] (netif_receive_skb_internal) from [<808072e4>]
> (netif_receive_skb+0x70/0x1f4)
> [<808072e4>] (netif_receive_skb) from [<8065006c>]
> (mcp25xxfd_can_int+0x8f8/0x9cc)
> [<8065006c>] (mcp25xxfd_can_int) from [<8019d2e4>] (irq_thread_fn+0x2c/=
0x64)
> [<8019d2e4>] (irq_thread_fn) from [<8019d644>] (irq_thread+0x180/0x24c)=

> [<8019d644>] (irq_thread) from [<801529f4>] (kthread+0x11c/0x134)
> [<801529f4>] (kthread) from [<80108650>] (ret_from_fork+0x14/0x24)

We see that netif_receive_skb() is called from the mcp's interrupt
handler (mcp25xxfd_can_int), which is not allowed.

I've pushed a fix to mcp25xxfd branch on linux-can-next. Please use that
patch stack, it's the newest.

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/?h=3Dmcp25xxfd

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--e4kgwdwcYMCXRlxtGqZxXWJclEZZJ1LKU--

--7w01Xt2CBIQ5dAk6yFYTf6IcQj3i2JqtJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl0+rc8ACgkQWsYho5Hk
nSDYbgf/d8wTwtKtxM6JEB+7Lf4/Ycp1dEI61tdTHzuK0qkoGwRswq5dR7CrbdfR
aR3mpXG/bx3dapYY5Fw/JjZYbHXmC87Bkf/O53UUO1EboZvbXp9BvkMX308SA8z1
3Zi+yBRZMbr23vGCJr8QSasXmkZkhEJ3gjZvpzWkgWzDCEQxJOzIZIYPrtw2jJ+2
vtngbCtosOuocejmdJ1cOGBbY082JDsXRkSXRS2/YXKHJGpVJG8m98tTleGE3RS5
F8hJ6fCly7vwbYRz+cmalDTcDGGgorm0InRhogbCjEZ+eliz/XYV9uc1avnFHluG
Eauwp+kRJLoZfUeNGWMrF9JmoSUnxw==
=BRRg
-----END PGP SIGNATURE-----

--7w01Xt2CBIQ5dAk6yFYTf6IcQj3i2JqtJ--
