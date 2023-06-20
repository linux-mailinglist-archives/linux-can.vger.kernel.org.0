Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD64C736D51
	for <lists+linux-can@lfdr.de>; Tue, 20 Jun 2023 15:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjFTN10 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Jun 2023 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjFTN1X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Jun 2023 09:27:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9BD1A4
        for <linux-can@vger.kernel.org>; Tue, 20 Jun 2023 06:27:19 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qBbO0-0001kM-Kn; Tue, 20 Jun 2023 15:27:08 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 125FB1DDB46;
        Tue, 20 Jun 2023 13:27:07 +0000 (UTC)
Date:   Tue, 20 Jun 2023 15:27:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Sylvain Girard <sylvain.girard@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?utf-8?B?SsOpcsOpbWll?= Dautheribes 
        <jeremie.dautheribes@bootlin.com>
Subject: Re: [PATCH net-next 1/2] can: sja1000: Prepare the use of a threaded
 handler
Message-ID: <20230620-unicycle-wifi-fbc8d73e51fb-mkl@pengutronix.de>
References: <20230616134553.2786391-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twvrtwtwm6ooxttw"
Content-Disposition: inline
In-Reply-To: <20230616134553.2786391-1-miquel.raynal@bootlin.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--twvrtwtwm6ooxttw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.06.2023 15:45:52, Miquel Raynal wrote:
> In order to support a flavor of the sja1000 which sometimes freezes, it
> will be needed upon certain interrupts to perform a soft reset. The soft
> reset operation takes a bit of time, so better not do it within the hard
> interrupt handler but rather in a threaded handler. Let's prepare the
> possibility for sja1000_err() to request "interrupting" the current flow
> and request the threaded handler to be run while keeping the interrupt
> line low.
>=20
> There is no functional change.

Applied both to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--twvrtwtwm6ooxttw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSRqScACgkQvlAcSiqK
BOixTQf/ZM+1W1w4QwaNlbaDdf6BotsAN1/sdJzb+iBdzdsp74JSePsBsOue9OGi
pe/xto0QMzqd8Xed0Y1OYH52XJfRoCrEHWd/hQJT09SpX2tnvvG2FpH9n6F8LWdY
AM54VixYtEipWEg+f7l1gnCqfKudzfaflu5XsRunAfpGKRXJNBKUnKgUZcRe36F9
3gLyRqBcqDjRrKedzTdUHQ9orlFmUVxFr+WIGvQX6W7R5Z6nC+FAZj1gQlsNyLR4
qnP+c8c7obcKhSy54DSTIC2psrO4oR7NVdnfkVXDxlLeC3eXdk2ODMpv1VyWOAUS
zbSHzhshoLh7E0rHCrJkvB46sAWIew==
=95zw
-----END PGP SIGNATURE-----

--twvrtwtwm6ooxttw--
