Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521744BFE21
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 17:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiBVQJh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 11:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiBVQJg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 11:09:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1473E164D26
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 08:09:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMXiv-00042z-BU; Tue, 22 Feb 2022 17:09:09 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AB28F3AA25;
        Tue, 22 Feb 2022 16:09:08 +0000 (UTC)
Date:   Tue, 22 Feb 2022 17:09:08 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Message-ID: <874k4qvq77.fsf@hardanger.blackshift.org>
References: <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
 <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
 <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
 <20220222150619.sqyagvuspbipywxl@pengutronix.de>
 <1c9764e5-dd8b-853a-08e2-547acf7e9e76@photo-meter.com>
 <20220222154314.y4scgsssl4mx5z2n@pengutronix.de>
 <00d47d39-7f93-6151-5e1a-572e75768eec@photo-meter.com>
 <20220222155135.xgzxddoz372zdsv4@pengutronix.de>
 <b946db8c-ac32-afb0-95aa-8658d1176a89@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dlk5c73rnlazkc7a"
Content-Disposition: inline
In-Reply-To: <b946db8c-ac32-afb0-95aa-8658d1176a89@photo-meter.com>
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


--dlk5c73rnlazkc7a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.02.2022 17:02:14, Michael Anochin wrote:
> > Still any error messages?
> No BUG-Message with  <0x0 0 0 16 0 0 1 1>. At least that is positive.
>=20
> But no other Messages in in kbuf. Simply no netif_wake_queue fires. After
> that no TX possible. But RX is working.

This is good. \o/

| [  763.651277] tcan4x5x spi6.0 can2: m_can_isr: netif_wake_queue done
| [  763.651295] tcan4x5x spi6.0 can2: m_can_start_xmit netif_stop_queue do=
ne
| [  763.651462] tcan4x5x spi6.0 can2: m_can_tx_handler m_can_tx_fifo_full
| [  763.652163] tcan4x5x spi6.0 can2: m_can_isr: netif_wake_queue done
| [  763.652182] tcan4x5x spi6.0 can2: m_can_start_xmit netif_stop_queue do=
ne
| [  763.652352] tcan4x5x spi6.0 can2: m_can_tx_handler m_can_tx_fifo_full

You're missing a "netif_wake_queue done" here. There's probably an
interrupt associated with this event. Add a print if that IRQ is active
right after reading the IRQ status register.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dlk5c73rnlazkc7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIVCqEACgkQrX5LkNig
011bEQf/UZ/QyreOkJbpXKGpjvIJSPA2NAA6XuIBFLghH32z9vD75y7Uiu4ZlKJV
YU7NQ9+AUE6dafJAmG3KKD4nRIpvFDlx/vnyzWWCBiHjpZs3KTdkmRefso3MCI97
4/5Lk2MAVlkCRc3Xpcq5T7LIGUmGbEjGwuPlgmQ0qyXds3f2VZSd6TwOJREHZWXl
VsD7bJ23rz6f+LoZoCByM6EPzb+wWYkLnxfI7yf9vxswrMfHui1IgAOreZXJ8zyp
9ckVNIxDHxbRbiF9KIbFySdU34QtKfuq4YpYGiY/JBRHQT7rfr/orUAt6iArFyrc
NxCjJUFF0H/NhB/L9MJLAHIB9jeRUQ==
=jhyk
-----END PGP SIGNATURE-----

--dlk5c73rnlazkc7a--
