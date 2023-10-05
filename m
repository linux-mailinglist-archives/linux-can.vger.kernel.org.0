Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1802C7BAA4F
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjJETkg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjJETkf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:40:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD6EA
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:40:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUD2-0000OL-7v; Thu, 05 Oct 2023 21:40:32 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUD1-00BLAV-RE; Thu, 05 Oct 2023 21:40:31 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 89F5922FF53;
        Thu,  5 Oct 2023 19:40:31 +0000 (UTC)
Date:   Thu, 5 Oct 2023 21:40:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 27/27] can: at91_can: switch to rx-offload implementation
Message-ID: <20231005-huntress-urban-6d4b7bba5031-mkl@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
 <20231004-at91_can-rx_offload-v1-27-c32bf99097db@pengutronix.de>
 <CAMZ6RqLoyCOsTuYCryr++yZw036cF2VyEbxawQSKvM-54aaHuA@mail.gmail.com>
 <20231005-overfull-chirping-9900063427f4-mkl@pengutronix.de>
 <CAMZ6Rq+v=DqZ1+T+tyN0n5hQRd0Av2APW8OWpEFbKXQsS8itpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hw6wtk4qmxzdc2l"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+v=DqZ1+T+tyN0n5hQRd0Av2APW8OWpEFbKXQsS8itpQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2hw6wtk4qmxzdc2l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.10.2023 01:29:38, Vincent Mailhol wrote:
> > Yes. I have proof-of-concept patches for it laying around, but I want to
> > get this mainline first. One limitation of the hardware is that the
> > timer is only 16 bits wide and runs on CAN clock, which means a maximum
> > of 1MHz. This causes the timer to overflow every 64ms, which in turn
> > requires a worker every 30ms or so.
>=20
> ACK.
>=20
> > For this reason, I want hardware TS
> > to be configurable and this is not yet implemented. Also $CUSTOMER
> > doesn't need HW timestamps :)
>=20
> Actually, this is already available in the kernel. You just need to
> implement the SIOCSHWTSTAMP and SIOCGHWTSTAMP ioctl in
> net_device_ops->ndo_eth_ioctl().
>=20
> More details in:
>=20
>   https://git.kernel.org/torvalds/c/90f942c5a6d7

Oh nice, thanks for the pointer. I was talking about the implementation
in the driver, though.

> The caveat is in the userland: the can-utils currently do not follow
> the conventions. It does not send those ioctls and instead expects
> hardware timestamps to be unconditionally always on.
> But at least, it should work with tcpdump or any other generic packet
> capture utilities which follow the kernel conventions.

IIRC tcpdump has a command line option to switch on HW timestamping. And
there is the command line tool hwstamp_ctl that you can use.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2hw6wtk4qmxzdc2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUfESwACgkQvlAcSiqK
BOi7Cgf/TCO4qAZc6ZbxflLf/dwR+dVZ4Ijb8BwRy3XjTsVCoquGdu6M2GVp2vWM
2PMMk0F1pODZTT8RgEWhnZPpQmErGK2kjvtF6CNjRGYhcvmPAmgoyCmShi1nD8I7
2flEUgYV70xsAjfZI8WDooM4EZUZL1J4Rf54kBLCMM2fBEsinRuiigtyjU7V+Bao
BtRaMZwNrLcPPXr9Lu46h2teXm4sv31BI3P3uwWjjVPndHWcD+3EprzlyHBJ9VZY
UqhqAgXWN2OJg0mcI06maDkLmygtGVmfky74Dlu8N4E2E4FTeEkX2WEdVB0PhMey
PrezXaMrIuWpqzbDndWJ5FJjB9dyNg==
=VR7c
-----END PGP SIGNATURE-----

--2hw6wtk4qmxzdc2l--
