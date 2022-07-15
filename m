Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3519575C79
	for <lists+linux-can@lfdr.de>; Fri, 15 Jul 2022 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiGOHhe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jul 2022 03:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGOHhd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jul 2022 03:37:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6D7BE3F
        for <linux-can@vger.kernel.org>; Fri, 15 Jul 2022 00:37:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oCFtB-00061d-TR; Fri, 15 Jul 2022 09:37:29 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 18EE3B15BD;
        Fri, 15 Jul 2022 07:37:29 +0000 (UTC)
Date:   Fri, 15 Jul 2022 09:37:28 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/5] can: dev: add CAN XL support
Message-ID: <20220715073728.csp4hgbrgr2q62zu@pengutronix.de>
References: <20220714160541.2071-1-socketcan@hartkopp.net>
 <20220714160541.2071-4-socketcan@hartkopp.net>
 <20220714200601.mklari3b6uvb7b2e@pengutronix.de>
 <c731143e-f476-b2f8-c08c-df66339d98f8@hartkopp.net>
 <CAMZ6RqJ0=PhrJUHaZR6QNWkv2vx690AiwPF2RLv1ou_JGX1qxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2j2q2jxhqpbajpce"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJ0=PhrJUHaZR6QNWkv2vx690AiwPF2RLv1ou_JGX1qxg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2j2q2jxhqpbajpce
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.07.2022 12:53:14, Vincent Mailhol wrote:
> On Fri. 15 Jul. 2022 at 06:14, Oliver Hartkopp <socketcan@hartkopp.net> w=
rote:
> > On 14.07.22 22:06, Marc Kleine-Budde wrote:
> > > On 14.07.2022 18:05:39, Oliver Hartkopp wrote:
> >
> > (..)
> >
> > >> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
> > >> +                            struct canxl_frame **cfx,
> > >> +                            unsigned int datalen)
> > >> +{
> > >> +    struct sk_buff *skb;
> > >> +
> > >> +    if (datalen < CANXL_MIN_DLEN || datalen > CANXL_MAX_DLEN)
> > >> +            goto out_error;
> > >> +
> > >> +    skb =3D netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> > >> +                           CANXL_HEAD_SZ + datalen);
>=20
> If usings the flexible array member, this would become:
>=20
>         skb =3D netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
>                                sizeof(struct canxl_frame) + datalen);
>=20
> or even:
>=20
>         skb =3D netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
>                                struct_size(*cxl, data, datalen));

ACK. I was thinking of the 2nd option with the struct_size().

> This is an illustration of my point that flexible data arrays are more
> idiomatic. I find it weird to have to mix sizeof(struct can_skb_priv)
> and CANXL_HEAD_SZ in the same expression...

> > >> +    if (unlikely(!skb))
> > >> +            goto out_error;
> > >> +
> > >> +    skb->protocol =3D htons(ETH_P_CANXL);
> > >> +    skb->pkt_type =3D PACKET_BROADCAST;
> > >> +    skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > >> +
> > >> +    skb_reset_mac_header(skb);
> > >> +    skb_reset_network_header(skb);
> > >> +    skb_reset_transport_header(skb);
> > >> +
> > >> +    can_skb_reserve(skb);
> > >> +    can_skb_prv(skb)->ifindex =3D dev->ifindex;
> > >> +    can_skb_prv(skb)->skbcnt =3D 0;
> > >> +
> > >> +    *cfx =3D skb_put_zero(skb, CANXL_HEAD_SZ + datalen);
> > >
> > > Should the CANXL_XLF be set here?
> >
> > Yes, we can set that bit here directly - for convenience reasons ;-)
> >
> > > I have a bad feeling if we have a struct canxl_frame with a fixed siz=
e,
> > > but it might not completely be backed by data.....
>=20
> I tried to think hard of what could go wrong with the
> data[CANXL_MAX_DLEN] declaration.
>=20
> The worst I could think of would be some:
>         int datalen =3D 64; /* or anything less than CANXL_MAX_DLEN */
>         struct canxl_frame *cxl1 =3D malloc(CANXL_HEAD_SZ + datalen);
>         struct canxl_frame *cxl2 =3D malloc(CANXL_HEAD_SZ + datalen);
>=20
>         memcpy(cxl1, cxl2, sizeof(*cxl1));
>=20
> But that example is a bit convoluted. That's why I wrote in my
> previous message that I saw no killer arguments against it.

It just feels wrong to have a pointer to a struct canxl_frame that's
only backed half by memory. I haven't followed the flex array discussion
in great detail, but it opens a whole class of errors if arbitrary
kernel memory can be accessed with struct canxl_frame::data using
seemingly valid array indices.

> > > For example, I've updated the gs_usb driver to work with flexible arr=
ays
> > > to accommodate the different USB frame length:
> > >
> > > https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs=
_usb.c#L216
> > >
> > > Maybe we should talk to Kees Cook what's best to use here.
> >
> > I see this struct canxl_frame with 2048 byte of data more as a user
> > space thing.
> >
> > You can simply read() from the CAN_RAW socket into this struct (as you
> > know it from CAN/CANFD) and it works safely.
> >
> > That we optimize the length to the really needed length inside the skb
> > and for CAN XL socket read/write operations is on another page for me.
> >
> > If we *only* had the canxl data structure inside the kernel I would be
> > definitely ok with flexible arrays.

We don't have to use the same data structure in user space and in the
kernel.

> > The current implementation indeed never allocates space with the
> > sizeof(struct canxl_frame) ...
> >
> > But I tend to maintain the pattern we introduced for CAN and CAN FD for
> > the user space visible data structures. That is clearer and safe to use
> > by default instead of reading documentation about flexible arrays and
> > how to build some data structure on your own.
>=20
> Here, you are making the assumption that the end user will only be
> familiar with the CAN(-FD) and not with other concepts.
>=20
> Building data structures on your own is fairly common, the best
> example being the struct iphdr or the struct tcphdr for TCP/IP:
>   * https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ip.=
h#L86
>   * https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/tcp=
=2Eh#L25
> (in those examples, it is not a flexible array member but the concept
> is basically the same).

struct_size() is not exported to user space, but I think this could be
changed.

> I think it is fair to expect from a developer using Berkeley sockets
> (what SocketCAN is) to be familiar with this.
>=20
> In the worst case, the developper who still completely ignore the
> documentation and just do sed "s/canfd/canxl/g" on their existing code
> base will eventually do this:
>         write(sock, &cxl, sizeof(canxl));
> And that would fail immediately (because sizeof(canxl) <
> CANXL_MIN_TU). So I think it is still safe. The real foot gun is when
> you can write incorrect code that still works (e.g. buffer overflow).
> If it directly fails, people will copy/paste the accepted answer on
> stackoverflow and will eventually do the correct:
>         write(sock, &cxl, sizeof(cxl) + cxl.len);
>=20
> Finally, for both solutions, user can not do this anymore:
>         assert(read(sock, &cxl, sizeof(cxl)) =3D=3D sizeof(cxl));
> But instead should do:
>         assert(read(sock, &cxl, sizeof(cxl)) >=3D CANXL_MINTU);
> So regardless of the solution we use, the developer needs to be aware
> to some extent of the variable size (and ignoring the return value of
> read() is a bad practice so I won't accept this as a counterargument).
>=20
> The debate is really on "reusing CAN(-FD) patterns" vs. "doing
> idiomatic C". I will not veto the data[CANXL_MAX_DLEN], but I vote for
> the flexible array member for the reasons listed here.

How are raw Ethernet frames handled in user space?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2j2q2jxhqpbajpce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLRGTUACgkQrX5LkNig
012Mygf+KOF+S6iUZEamGYqdhKChDreEjpTg8611AB6yyAqXj98hzcQ9bZUplKhE
Qgc9s5GUlDlQAw/l4E0N1/PaEyXdUEhiC/5Lj0UJZokXSF4DIU7EhSw607M0CmfG
9D/HTQgT3vZ4dQO28aG1eroj2SFYeNWf6LbQGWED/x8gH3K23odYzi+Me1MjIX9I
jukdOuWC+126v6KegBuO/6P8EkpkYrHYTS48/k/eVxipv+EoMiA7rFzoYDKCE0XN
fbsktt1bVR6JK1A1Qt4uPIoEyVpc0vpkz3ZNJrAtuxem21z2tUR4u1Kaver8+I+3
L8acD/RkOIowOX8cF5L+CjW4vdS6cA==
=jpOS
-----END PGP SIGNATURE-----

--2j2q2jxhqpbajpce--
