Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77E55B29A
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiFZPPQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 11:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFZPPP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 11:15:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F50EE36
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 08:15:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5Tyh-0001PU-Nm; Sun, 26 Jun 2022 17:15:11 +0200
Received: from pengutronix.de (p200300ea0f229100c1f120485ffcf4df.dip0.t-ipconnect.de [IPv6:2003:ea:f22:9100:c1f1:2048:5ffc:f4df])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 16C4F9F94F;
        Sun, 26 Jun 2022 15:15:07 +0000 (UTC)
Date:   Sun, 26 Jun 2022 17:15:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Rhett Aultman <rhett.aultman@samsara.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can-roundtrip-stats: a tool to benchmark
 transmission time
Message-ID: <20220626151506.bzg7wqua572zswag@pengutronix.de>
References: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr>
 <20220626090744.pycu3katdt6vir2l@pengutronix.de>
 <CAMZ6RqLVKMznm_n4j079rcYLjhj8QjmeM3=bYUeXm_rozmQNVg@mail.gmail.com>
 <20220626105525.va44sseksk3xej7j@pengutronix.de>
 <CAMZ6Rq+NbmOA89DjA=e_EBJXaDm0T69vbFrjKD+arZivhVqEdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4o4s2r4wmyvq5srw"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+NbmOA89DjA=e_EBJXaDm0T69vbFrjKD+arZivhVqEdA@mail.gmail.com>
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


--4o4s2r4wmyvq5srw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.06.2022 22:40:13, Vincent MAILHOL wrote:
> > > > I'm currently playing around with hardware timestmaps in the mcp251=
xfd
> > > > driver and the other day I stumbled over commit 741b91f1b0ea ("can:=
 dev:
> > > > can_put_echo_skb(): add software tx timestamps") and I was thinking
> > > > which tool you're using to test this. :)
> > > >
> > > > Once the hardware timestamps are running stable, this is exactly the
> > > > tool I need! Thanks for sharing this.
> > >
> > > Does the mcp251xfd use the host clock to do its hardware timestamp?
> >
> > It uses an external 40 MHz oscillator, usually each device has it's own.
> >
> > > (Not sure how SPI hardware works and if they have their own quartz or
> > > if they share it with the host system). If it is indeed the same clock
> > > you can have even more precise statistics.
> >
> > No, the device clock is not shared with the host system and thus drift
> > apart. But you can synchronize the device's clock against the system
> > clock with phc2sys of linuxptp. As soon as the code is stable I'll send
> > the patches around.
>=20
> This sounds really exciting. I also wanted to play with linuxptp but
> never had time to start.

I started with adding the basic callback for /dev/ptpX to show up and
"work", i.e. not crash :). What probably most CAN devices lack is the
possibility to fine tune the oscillator, but I figured out, there is a
ptp clock multiplexer in the kernel that does the fine tuning in
software. I ported that code and now I can run phc2sys on the mcp251xfd.

What does phc2sys do? It's used to synch a PTP Clock to the Linux system
clock or vice versa. The only sensible use case of this all is to sync
=66rom the Linux system clock to the mcp251xfd device clock. This way the
hardware timestamps are within =C2=B5s of the Linux system clock.

> With the device clock synchronized, you can have decent timestamping
> between different hardware (potentially of different brands).

So far I only synchronize the Linux system clock into the mcp251xfd
clock. I could synchronize a 2nd CAN adapter implementing a /dev/ptp on
the same system, too.

> The drawback is that you would lose a bit of precision: the hardware
> timestamp have an accuracy around 1 microsecond. After using PTP, I
> would expect the precision to degrade to roughly 100 microsecond
> (which is still way better than what software timestamping can offer).

Synchronizing time via CAN between different systems would be the next
logical step. But linuxptp needs code to map the PTP messages to CAN
frames. This will not work with raw CAN, as the messages are too long.
Maybe CAN-FD or ISO-TP can help. But I haven't looked into this.

> > What does tcpdump show on a Ethernet if you enable TX timestamps?
>=20
> I never went so far.
>=20
> For tcpdump, the interested flags are:
>   * -J (a.k.a. --list-time-stamp-types)
>   * -j tstamp_type (a.k.a. --time-stamp-type=3Dtstamp_type)
>=20
> But I never went so far to make them work. If you want to try it,
> first be sure that the driver of your network interface calls
> skb_tx_timestamp() in its xmit() function.

I think some interfaces on our compile cluster support PTP.

> > > I also guess there is no official support but then,
> > > I am wondering how hard it would be to hack the error queues to expose
> > > them to the privileged processes.
> >
> > Maybe there's general interest of pushing error queue data via packet
> > socket, too. As this is not a CAN specific issue.
>=20
> I think so. This is just a niche topic, so we need to find the code
> snippet which will put some light on this. I am convinced that some
> solution should exist, just do not have enough time to investigate.
> Studying the source code of tcpdump is probably one of the best idea I
> can think of right now.

sound like the right direction

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4o4s2r4wmyvq5srw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmK4d/YACgkQrX5LkNig
013SZQf8C+QzQIwocg5VI+/dRP/N3yljvwKB5puXW5x7XBDoCaZOYzlS4xgqlgSg
QN5HV0Js50jBs2vofH70PfeTxv6W9beL+iAW0lGdYYR5nxr40Xt0EsLhwzqww2W1
uTbIXIPRjFnVyJLtT5+VR/2t2MWc3RPRJMHw54SWljNgV9T35kI1yn62vMAcKPhl
fEbSIBi4/K3jYf0JXmwgVKu0MqQTWCmnD1lwI+hOd1LuXutvPgujSbyuyWTu7E3f
md8EUBsOOZevsq6FeFewllP6IZjamkwja9jLaUHWlIFl4YZvVgvw3kPy1x+1HeGb
6Uw7HSvENe1mu4FGx5n59rYuZ4uHNQ==
=rJK3
-----END PGP SIGNATURE-----

--4o4s2r4wmyvq5srw--
