Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012874BFBEB
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 16:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiBVPGr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 10:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiBVPGr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:06:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE0610E07C
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:06:21 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMWk8-0001wL-3p; Tue, 22 Feb 2022 16:06:20 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 899903A8F0;
        Tue, 22 Feb 2022 15:06:19 +0000 (UTC)
Date:   Tue, 22 Feb 2022 16:06:19 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Message-ID: <20220222150619.sqyagvuspbipywxl@pengutronix.de>
References: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
 <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
 <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
 <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
 <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3osmulwwn6kphnlt"
Content-Disposition: inline
In-Reply-To: <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
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


--3osmulwwn6kphnlt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.02.2022 15:54:32, Michael Anochin wrote:
> >=20
> > This should not happen. Especially with the tcan driver. In a previous
> > mail you stated that you are using the following mram config:
> >=20
> > | bosch,mram-cfg =3D  <0x0 0 0 16 0 0 1 1>;
> >=20
> > is this still the case? This is inconsistent with the above error
> > message.

My question is, which mram-cfg were you using when the above error
message hit.

> I have tried many bosch,mram-cfg. This makes almost no difference
>=20
> bosch,mram-cfg =3D  <0x0 0 0 16 0 0 1 1> is from Mainstream
> bosch,mram-cfg =3D  <0x0 0 0 10 0 0 16 16> is from Mainstream
> bosch,mram-cfg =3D  <0x0 0 0 16 0 0 8 8> is from Mainstream

What is Mainstream?

> I recognized, that no RXFIFO_1 is used, only RXFIFO_0.  On TXFIFO/TXEFIFO
> may be only one element is used by driver. I am not sure.

ACK, as documented in the DT bindings:

| bosch,mram-cfg =3D <0x0 0 0 16 0 0 1 1>;

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bin=
dings/net/can/tcan4x5x.txt#L34

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3osmulwwn6kphnlt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIU++YACgkQrX5LkNig
013K9wgAmdXrjDFNAZN9Ex3nhSLR8AL08699NlZ7RHV2f6UbB/c1+VylTsYZJHpH
wMZ4FMx/B3UwSGkb409Jh5hRIucNIz13iZU5BcScby4FcmgJF2iejYf0XFU0sXst
DLjXbHwDxyJrNiGiYLoCJRD2mmpmHOoNHAhXF/cg4j3GrXiwyLlg2kOEgmVodKVf
/N7PiCDMoRvmMXeXxG/9TWxpIalZevlkTmjJfExuM8vMxoVTisQJCZqIwwn7ILx1
IqCmSLurMVL7n7/EwCzKGCkxTVgU5GW6fsS58y1TEERIdptYa3AucSGsfzOdBm2v
qDWE/5VzaXg6ikTBLJqxw2OnEnpyDw==
=PKrN
-----END PGP SIGNATURE-----

--3osmulwwn6kphnlt--
