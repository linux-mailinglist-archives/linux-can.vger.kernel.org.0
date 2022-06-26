Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F4D55B087
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiFZJHz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiFZJHy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 05:07:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044DE120AF
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 02:07:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5OFB-0007qw-Ak; Sun, 26 Jun 2022 11:07:49 +0200
Received: from pengutronix.de (p200300ea0f229100c1f120485ffcf4df.dip0.t-ipconnect.de [IPv6:2003:ea:f22:9100:c1f1:2048:5ffc:f4df])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1AD3B9F7CD;
        Sun, 26 Jun 2022 09:07:45 +0000 (UTC)
Date:   Sun, 26 Jun 2022 11:07:44 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Rhett Aultman <rhett.aultman@samsara.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can-roundtrip-stats: a tool to benchmark
 transmission time
Message-ID: <20220626090744.pycu3katdt6vir2l@pengutronix.de>
References: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="clifluqa4pfu5eih"
Content-Disposition: inline
In-Reply-To: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr>
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


--clifluqa4pfu5eih
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.06.2022 16:53:17, Vincent Mailhol wrote:
> This is a simple tool I wrote in the past. It will report the time
> need for a packet to travel from:
>   * application TX path to kernel TX path
>   * kernel TX path to kernel RX path (i.e. kernel round trip)
>   * kernel RX path to application RX path
>   * application TX path to application RX path (i.e application round
>     trip)

I'm currently playing around with hardware timestmaps in the mcp251xfd
driver and the other day I stumbled over commit 741b91f1b0ea ("can: dev:
can_put_echo_skb(): add software tx timestamps") and I was thinking
which tool you're using to test this. :)

Once the hardware timestamps are running stable, this is exactly the
tool I need! Thanks for sharing this.

> This tool is useful to benchmark latency on software and hardware. It
> can be used to, for example:
>   * compare performances of two CAN controllers (by using the kernel
>     round trip information)
>   * compare the different CAN queue disciplines (by using the
>     application TX path to kernel TX path information)
>=20
> I am sharing it as-is. Please see this message as an FYI. I do not
> consider this mature enough and I am not expecting anyone to pick that
> patch. Everything is hard coded, I did not put effort to make it
> configurable.
>=20
> The tool requires the TX timestamps (which I previously added to the
> kernel in [1] and [2]).
>=20
> To use it:
> | $make
> | ./can-roundtrip-stats
>=20
> My ultimate goal was to add the TX timestamp feature to candump from
> can-utils [3], however, I faced a blocker: the TX timestamps are sent
> to the error queue of the sender's socket meaning that a listener
> (such as candump) will not see those TX timestamp on his error queue
> because this is a different socket as the sender. If anyone knows a
> method to access the error queue of another process's socket, let me
> know (I guess that you need to be root, but did not find how to do
> it).

I don't think there's an official way to read the TX timestamps (i.e.
error queue) of a socket that's outside of your process.

> Because I did not manage to add the feature to candump, I am sharing
> instead this standalone tool, hoping someone might find it useful.

I'm not sure which is the best tool to add this to...cangen,
cansequence. Maybe evolve these tools into some kind of CAN ping
command.

> At the moment, I am not planning to invest more time in the
> foreseeable future. If someone want to take over and make is a bit
> more sexy so that it can reach can-utils, go ahead. I think that it
> basically misses a command line interface in the same fashion of
> cangen to make is configurable.

I've added it to a branch of my can-utils:

https://github.com/marckleinebudde/can-utils/tree/can-roundtrip-stats

> Else, you can also tweak the hard coded information to easily adjust
> it to your needs.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--clifluqa4pfu5eih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmK4IdgACgkQrX5LkNig
013XGQf/ed1bJFEjqjtsFpH3u3G7BPGSl/4Mn0Mt67EflLzCkcCYxhVDAW7TVDIL
0TZwD8J+DUrI27/l5jRLSKa9PkjiUMT97zlHYZcGPxAO5CsAPggPQNGaREfvs9rG
X0hkoHcmyYigP+LMYU3z7gcyoAgd/WsaAZiBPgbivSpZ1hG5TdSTxuVc7pdduueb
JG00CUju9YTpqCrwGEbd5PsDH4QL/hPO1lKYJN3uhNvnnS87hfYyKNETRVpmbyLK
5yiOuTx7nDm0w07imBPJesYRozesV+Q84Bd2hG34Hr6yh8F7gWB8FBFch1JnF3Cx
Q58/8NOD7ic3ZslmzFM+DZPSkhTptg==
=HWSm
-----END PGP SIGNATURE-----

--clifluqa4pfu5eih--
