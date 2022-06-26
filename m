Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A4C55B15A
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 12:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiFZKze (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 06:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiFZKzd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 06:55:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EBFE00E
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 03:55:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5PvO-00025O-FZ; Sun, 26 Jun 2022 12:55:30 +0200
Received: from pengutronix.de (p200300ea0f229100c1f120485ffcf4df.dip0.t-ipconnect.de [IPv6:2003:ea:f22:9100:c1f1:2048:5ffc:f4df])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3E1B29F85D;
        Sun, 26 Jun 2022 10:55:26 +0000 (UTC)
Date:   Sun, 26 Jun 2022 12:55:25 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Rhett Aultman <rhett.aultman@samsara.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can-roundtrip-stats: a tool to benchmark
 transmission time
Message-ID: <20220626105525.va44sseksk3xej7j@pengutronix.de>
References: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr>
 <20220626090744.pycu3katdt6vir2l@pengutronix.de>
 <CAMZ6RqLVKMznm_n4j079rcYLjhj8QjmeM3=bYUeXm_rozmQNVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j4femelj4z7ywgj2"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLVKMznm_n4j079rcYLjhj8QjmeM3=bYUeXm_rozmQNVg@mail.gmail.com>
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


--j4femelj4z7ywgj2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.06.2022 18:54:05, Vincent MAILHOL wrote:
> On Sun. 26 juin 2022 =C3=A0 18:10, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
> > On 26.06.2022 16:53:17, Vincent Mailhol wrote:
> > > This is a simple tool I wrote in the past. It will report the time
> > > need for a packet to travel from:
> > >   * application TX path to kernel TX path
> > >   * kernel TX path to kernel RX path (i.e. kernel round trip)
> > >   * kernel RX path to application RX path
> > >   * application TX path to application RX path (i.e application round
> > >     trip)
> >
> > I'm currently playing around with hardware timestmaps in the mcp251xfd
> > driver and the other day I stumbled over commit 741b91f1b0ea ("can: dev:
> > can_put_echo_skb(): add software tx timestamps") and I was thinking
> > which tool you're using to test this. :)
> >
> > Once the hardware timestamps are running stable, this is exactly the
> > tool I need! Thanks for sharing this.
>=20
> Does the mcp251xfd use the host clock to do its hardware timestamp?

It uses an external 40 MHz oscillator, usually each device has it's own.

> (Not sure how SPI hardware works and if they have their own quartz or
> if they share it with the host system). If it is indeed the same clock
> you can have even more precise statistics.

No, the device clock is not shared with the host system and thus drift
apart. But you can synchronize the device's clock against the system
clock with phc2sys of linuxptp. As soon as the code is stable I'll send
the patches around.

[...]

> > > My ultimate goal was to add the TX timestamp feature to candump from
> > > can-utils [3], however, I faced a blocker: the TX timestamps are sent
> > > to the error queue of the sender's socket meaning that a listener
> > > (such as candump) will not see those TX timestamp on his error queue
> > > because this is a different socket as the sender. If anyone knows a
> > > method to access the error queue of another process's socket, let me
> > > know (I guess that you need to be root, but did not find how to do
> > > it).
> >
> > I don't think there's an official way to read the TX timestamps (i.e.
> > error queue) of a socket that's outside of your process.
>=20
> What I was thinking is that tools such as tcpdump are able to get TX

Oh, I completely forgot the packet socket and tcpdump....

> packets of ethernet interfaces even if not normally visible (because
> contrary to CAN, there is no default loopback). I was wondering if the
> same could be done with error queues, but as you can guess my research
> did lead anywhere.

What does tcpdump show on a Ethernet if you enable TX timestamps?

> I also guess there is no official support but then,
> I am wondering how hard it would be to hack the error queues to expose
> them to the privileged processes.

Maybe there's general interest of pushing error queue data via packet
socket, too. As this is not a CAN specific issue.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--j4femelj4z7ywgj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmK4OxkACgkQrX5LkNig
012L7Qf/UXwfRVQqPqcAVOrkBWz2XQ52P0tTUyMyBbUuAMPRPnDCNevUa9a6x1JZ
b1vCtbUkv8tLuoBD6kiNpBeMRWQbDIr5h5SthzsxGCL9Csh6BrYL99zWy9sLwXkp
m3pU3KAN8YhigJrvQ4Xbmp3U41k4X1JMcvz1w8UJ6Uo3I0DnwAi2eoYNf3Z0gRHW
hy67qlJouWOyfb7RpWfpLQkPep479LI8CS5jotg8euy13EaYIdYXPoSyMxZd4dI5
AVsArMDw45UPeFtrqqS7/ZZbNjYbkiVJR6yoZIoN7luhuQ/f0yTedwqC7C09q9u8
CyJdALml7UaYCGKy3tGkqiOihneOvA==
=AAi/
-----END PGP SIGNATURE-----

--j4femelj4z7ywgj2--
