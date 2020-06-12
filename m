Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9973E1F7676
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2020 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFLKDb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Jun 2020 06:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgFLKDb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Jun 2020 06:03:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15FAC03E96F
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2020 03:03:30 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jjgWv-0002YY-Sb; Fri, 12 Jun 2020 12:03:21 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jjgWv-0006qT-0F; Fri, 12 Jun 2020 12:03:21 +0200
Date:   Fri, 12 Jun 2020 12:03:20 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        robin@protonic.nl, linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de
Subject: j1939: root requirements for messages with the priorities 0 & 1
Message-ID: <20200612100320.u7tixjjcb2dxmo4d@pengutronix.de>
References: <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
 <20190625173137.GB8923@x1.vandijck-laurijssen.be>
 <20190626091524.40410c4b@erd988>
 <20190626130012.GC8923@x1.vandijck-laurijssen.be>
 <20190626160238.5d62fc15@erd988>
 <20190627093353.GA693@x1.vandijck-laurijssen.be>
 <20190627105901.GA24805@pengutronix.de>
 <20190627140849.39916a65@erd988>
 <20190722091328.GA24349@pengutronix.de>
 <20190722133723.GA17189@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fuz3fzgw2doyzymw"
Content-Disposition: inline
In-Reply-To: <20190722133723.GA17189@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:55:17 up 210 days,  1:13, 208 users,  load average: 0.24, 0.14,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--fuz3fzgw2doyzymw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

We have following issues reported on can-utils:
https://github.com/linux-can/can-utils/issues/217
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
This is a follow-up of the issue #159 .

When testing the priorities, I noticed, that for the priorities 0 and 1,
the message occurs, that setting the priority is not permitted:

  ./testj1939 -B -s -p3 vcan0:0x80 :,0x0200

Works ok.

  ./testj1939 -B -s -p1 vcan0:0x80 :,0x0200
  testj1939: set priority 1: Operation not permitted

  ./testj1939 -B -s -p0 vcan0:0x80 :,0x0200
   testj1939: set priority 0: Operation not permitted

I am not aware that the priorities 0 & 1 are not permitted.

> Originally posted by @marckleinebudde in #159 (comment):
> Priorities 0 and 1 are only permitted for root or users with
> capable(CAP_NET_ADMIN), see:

> https://elixir.bootlin.com/linux/latest/source/net/can/j1939/socket.c#L705

> I think this limit is arbitrary and we can discuss if
> this makes sense at all or add this to the
> documentation.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Since I currently have no opinion on, I put it here for the discussion.

Comments and suggestions are welcome.

Regards,
Oleksij
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--fuz3fzgw2doyzymw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl7jUuQACgkQ4omh9DUa
UbOsORAAr4Q9MI16KL2uYcAFeYU8OAnZXoJFmDwf/EacztjEhkNvi9b2KS47P3Tn
dIITvBUgtBjrhtylIpz7UdK0qf4GYgY3ejL/z+dXkGusHNegsQSChG+LeZD8o3rY
67xVbLCfXv/0hcQXc2B6PiGR+zTdpspMMIgscpeqQw2ZC2VradNFX76KQBtLETLY
0zsMtVvDugbxmssZ+CPEKXC5FbT60XzP+jgFbBmeS+7f7/Sl5FDJIVai8wbBjj75
zlslGwoNcLBCQ+K03M7Hg4cUdCfbiYIHuTnILAXgj8dqkJ7SneIgMYmC1K3+H0hl
eR5deIxz3L9PWPpAqICqDaVGnEV9E1ACCWdlhbFUtPalKZo5pnwUt0KdLqrw+QWo
+0onF9MUcEEQjmvTrC2wVkwKlKz6gS5abGefsdxoYPVJhChLqZPep5wgTI16m46b
z48iSO7MhmIhH+Qiz0M2JU95m/JIKYEDDZEYQ36dGCEXIt4NVRWRF17cC/QmFiCl
pcDXOVFATBEPTP/+TrR0iNhTO1QkIdi7aLvqjUnNVlgOAUhRjaHzThE8EF2URwlW
tJHIUG11Wom5Pgkz4uTwJoCrJsrg977yX/78/2HXQphTvK/M5cxSLfWj1MEMpjo8
iaoRPDq+z0EcT8qKarHQREkjMILYr43IKWtN6+rZSZw48n8W7JQ=
=tqub
-----END PGP SIGNATURE-----

--fuz3fzgw2doyzymw--
