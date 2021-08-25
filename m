Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470EE3F7838
	for <lists+linux-can@lfdr.de>; Wed, 25 Aug 2021 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbhHYP1F (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Aug 2021 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbhHYP1E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Aug 2021 11:27:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA41C061757
        for <linux-can@vger.kernel.org>; Wed, 25 Aug 2021 08:26:17 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mIunA-0007cV-8d; Wed, 25 Aug 2021 17:26:16 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-c8d1-09c2-d573-6e5f.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:c8d1:9c2:d573:6e5f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5E6EF66F950;
        Wed, 25 Aug 2021 15:26:15 +0000 (UTC)
Date:   Wed, 25 Aug 2021 17:26:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: TR: pull-request: can-next 2021-07-25
Message-ID: <20210825152613.mbtrnujlpb7635xi@pengutronix.de>
References: <20210726141144.862529-1-mkl@pengutronix.de>
 <162733441301.18684.10819552730140170023.git-patchwork-notify@kernel.org>
 <PA4PR03MB6797385C06D695452B79513BD6C69@PA4PR03MB6797.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7xeu5x5szksoieie"
Content-Disposition: inline
In-Reply-To: <PA4PR03MB6797385C06D695452B79513BD6C69@PA4PR03MB6797.eurprd03.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7xeu5x5szksoieie
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.08.2021 13:55:08, St=C3=A9phane Grosjean wrote:
> AFAIK I don't see any of the peak_* patches below appearing in linux
> for all this time... Any idea?

You mean these patches?

>   - [net-next,31/46] can: peak_pci: convert comments to network style com=
ments
>     https://git.kernel.org/netdev/net-next/c/9b69aff9fd1a
>   - [net-next,32/46] can: peak_pci: fix checkpatch warnings
>     https://git.kernel.org/netdev/net-next/c/fe1fa1387a15
>   - [net-next,33/46] can: peak_pci: Add name and FW version of the card i=
n kernel buffer
>     https://git.kernel.org/netdev/net-next/c/805ff68c8e7f
>   - [net-next,34/46] can: peak_usb: pcan_usb_get_device_id(): read value =
only in case of success
>     https://git.kernel.org/netdev/net-next/c/1d0214a0f5db
>   - [net-next,35/46] can: peak_usb: PCAN-USB: add support of loopback and=
 one-shot mode
>     https://git.kernel.org/netdev/net-next/c/3a7939495ce8
>   - [net-next,36/46] can: peak_usb: pcan_usb_encode_msg(): add information
>     https://git.kernel.org/netdev/net-next/c/1763c547648d
>   - [net-next,37/46] can: peak_usb: pcan_usb_decode_error(): upgrade hand=
ling of bus state changes
>     https://git.kernel.org/netdev/net-next/c/c11dcee75830

These were parts of this pull request to net-next, which will hit
mainline in the v5.15 release cycle. They should be in Linus' tree with
v5.15-rc1.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7xeu5x5szksoieie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEmYRMACgkQqclaivrt
76lwGAf/ex+JI5jjU9CGu2/Kb7yQzgRZlevA/CTrTEiEtlFV9P4sTj5hNPAs3iqy
Cuk/0Z/z1zj2J7XSLW/S4ejhyyuzH6saHpfJfaDPzffIuzyBFhDgw2OcNRkqfsTu
ya+K8dpTfGDbsgcII+5XHyCbr/+QgzKfrvwwH6xm3XsoL47JrzAs/0m8A8oQz/zq
aUyh45izjhh89tmB8RAkd6+4YqKROzzYPjy/e3KRYg6ffC8TFnCsKIswHKbIo14t
UP+gxjffS++oTfJxM0ObigKMtKaHhwhklmhCfjihkfT2UYQ02m3XSXn4072ngX2h
l5eNf3fgudGleu7GXq7CXQSEeeLr3Q==
=H46r
-----END PGP SIGNATURE-----

--7xeu5x5szksoieie--
