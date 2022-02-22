Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBEC4BFB0D
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 15:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiBVOpt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 09:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiBVOps (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 09:45:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3324765427
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 06:45:22 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMWPo-0007k6-JQ; Tue, 22 Feb 2022 15:45:20 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E67C43A8C6;
        Tue, 22 Feb 2022 14:45:19 +0000 (UTC)
Date:   Tue, 22 Feb 2022 15:45:18 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Message-ID: <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
References: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
 <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
 <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5fnsgswmsbevi6ed"
Content-Disposition: inline
In-Reply-To: <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
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


--5fnsgswmsbevi6ed
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please don't forget to keep the mailing list on Cc!

On 22.02.2022 15:30:33, Michael Anochin wrote:
>=20
> > You can add a netdev_error() to report the error if
> Done, m_can_rx_peripheral(dev) returns each time normally with 0.
> I added netdev_err also after out_fail in m_can_isr, but it fires no error
> in dmesg after NOBUFS.
>=20
> The curious thing is that it fails in the other place.
>=20
> Sometimes I see
> [ 9945.908861] tcan4x5x spi4.0 can1: can_put_echo_skb: BUG! echo_skb 11 is
> occupied!
>=20
> But I think, it is not my problem.

This should not happen. Especially with the tcan driver. In a previous
mail you stated that you are using the following mram config:

| bosch,mram-cfg =3D  <0x0 0 0 16 0 0 1 1>;

is this still the case? This is inconsistent with the above error
message.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5fnsgswmsbevi6ed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIU9vsACgkQrX5LkNig
010n9Af+K8USX/+5DfFZjEASICP0+Ls07/CgG11Xz4R+5t25iJ/9H1js/NJGpH9Q
yeVYAaJYeyg4qP3c5E7uprJmW9NWNvGe7sv9VEl02ZCqFFXxJ/3sdgk2m3FKQ6Zg
m4INBTiX8NfO1WuLI3xsElDoMdNzMvHIOXSPD6xDW6MyczDaqBHh/On+6zdd8NAy
Oz2tGpvTxdwWnm49dCTpGCxJu0J81rEz2RWI6TwUHly0c545yV7apvxifR5rHLYG
mEBpHBSQILHmc0zPxHW6d/j4LamCdlv7lXTIsSnXo3NOaKBHr4wE3xmlfNArnDKG
xEvlZInQozPYjZ/N4quF5oM8ZEoexQ==
=lErs
-----END PGP SIGNATURE-----

--5fnsgswmsbevi6ed--
