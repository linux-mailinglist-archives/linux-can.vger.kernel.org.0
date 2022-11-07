Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD3D620D1A
	for <lists+linux-can@lfdr.de>; Tue,  8 Nov 2022 11:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiKHKTz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Nov 2022 05:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiKHKTW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Nov 2022 05:19:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03948140E4
        for <linux-can@vger.kernel.org>; Tue,  8 Nov 2022 02:19:18 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1osLhJ-0006MP-Vs; Tue, 08 Nov 2022 11:19:14 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3A9C2115BB4;
        Mon,  7 Nov 2022 13:01:36 +0000 (UTC)
Date:   Mon, 7 Nov 2022 14:01:33 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Max Staudt <max@enpas.org>, stable@vger.kernel.org
Subject: Re: [PATCH net 4/5] can: dev: fix skb drop check
Message-ID: <20221107130133.pfgfp4ymna2ogr5s@pengutronix.de>
References: <20221104130535.732382-1-mkl@pengutronix.de>
 <20221104130535.732382-5-mkl@pengutronix.de>
 <20221104115059.429412fb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bcuckfzhnjyvck7g"
Content-Disposition: inline
In-Reply-To: <20221104115059.429412fb@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--bcuckfzhnjyvck7g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.11.2022 11:50:59, Jakub Kicinski wrote:
> On Fri,  4 Nov 2022 14:05:34 +0100 Marc Kleine-Budde wrote:
> > -	if (can_dropped_invalid_skb(ndev, skb))
> > +	if (can_dev_dropped_skb(dev, skb))
>=20
> Compiler says "Did you mean ndev"?

Sorry for the mess, in my config files the driver in question was
already disabled. :(

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bcuckfzhnjyvck7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNpAaoACgkQrX5LkNig
012Ytwf9EsPA+j9+kcubAdNYsXT2nvxukuE/5CjMprQNt+M4XkULFzjbZCKxfUXS
RZL7p1vbESTEdce1/40yUnOozaGKm/3NCp21kG2Y2cRUGWcMVl8jvQzMz3YdN3Gx
EwSehNmbaD0fZ9R8CrowHcfL96uOfbO1cCOlF/+tD7OetysTgly0loPmnrPKQJ44
8WtEVmRDKfZkVCDQnbRGZcvFcycJ91e+NUocWyjr8pibmpNAGqGYNPJWfJeyglb0
ZRPntwn6X55zQjthnaKmidbOj7fq0uHeA48IpgX+b6zs7EEasoJKs4SHm2RKM5i4
pfTJt859ckH3qxRU6g7A1vnGSr6VMw==
=9Rva
-----END PGP SIGNATURE-----

--bcuckfzhnjyvck7g--
