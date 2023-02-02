Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742A0687E4D
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 14:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBBNKb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 08:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjBBNKa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 08:10:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6746A8C1C3
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 05:10:29 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNZMB-0000bf-RH; Thu, 02 Feb 2023 14:10:27 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fff9:bfd9:c514:9ad9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 419E016D55D;
        Thu,  2 Feb 2023 13:10:27 +0000 (UTC)
Date:   Thu, 2 Feb 2023 14:10:21 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH net 2/5] can: raw: fix CAN FD frame transmissions over
 CAN XL devices
Message-ID: <20230202131021.4xffrriiggebuzqf@pengutronix.de>
References: <20230202094135.2293939-1-mkl@pengutronix.de>
 <20230202094135.2293939-3-mkl@pengutronix.de>
 <b71b8544-7e55-b86e-a32c-7ebdc0e4ea78@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7vkpidtppkdo3hd2"
Content-Disposition: inline
In-Reply-To: <b71b8544-7e55-b86e-a32c-7ebdc0e4ea78@hartkopp.net>
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


--7vkpidtppkdo3hd2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.02.2023 13:43:07, Oliver Hartkopp wrote:
> you asked me to introduce a new variable instead of rolling back the
> ro->fd_frames setting in setsockopt.
>=20
> I just wondered why you didn't pick the V4 patch then:

Doh - that was not intentional!

> https://lore.kernel.org/linux-can/20230131112657.59247-1-socketcan@hartko=
pp.net/T/#u
>=20
> It has no functional drawback but I was able to add an error return code =
in
> V4. I just wanted to know.

Please send a follow up patch against net-next/main once the net/main
has been merged in net-next/main.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7vkpidtppkdo3hd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPbtjoACgkQvlAcSiqK
BOgJ2Af/eIlxW6/rNPcyZ041WOK0roQegpNHT6W5MZxocXHrYuv0ocIPxE7Rbolv
QNad1gx296hBt7dy9hUGPoSryM08w5kfDfPG21MuLxQ79RchwIUggj2MDF+4oxSW
MTNor4CJ7zIXGqlUBdi20IwwnPyGBpp7U+Xh5R0kp/MwkmfAcJYInrHGFy+t2F3p
62X6lTI+6AA2efHxSWpMqX868ccH27vDM7XkVCLBYK6qZLgoM5AoKkrBtU/kvMme
zVE/KUmIUdMHsC15du0x3k4YwWbS4MoZG2ghtl84CnIFmDe7qQ3LzM1B98djGQRp
GC3lBI/TjZjkthBZYY9MFbjHipH7zg==
=45MV
-----END PGP SIGNATURE-----

--7vkpidtppkdo3hd2--
