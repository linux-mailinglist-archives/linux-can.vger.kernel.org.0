Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9665F107452
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2019 15:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVO4T (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Nov 2019 09:56:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49499 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVO4T (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Nov 2019 09:56:19 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iYALw-0007JM-Op; Fri, 22 Nov 2019 15:56:08 +0100
Received: from [IPv6:2a03:f580:87bc:d400:941f:8f59:5279:2337] (unknown [IPv6:2a03:f580:87bc:d400:941f:8f59:5279:2337])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B2FB94819BF;
        Fri, 22 Nov 2019 14:56:07 +0000 (UTC)
To:     Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org
Cc:     wg@grandegger.com, dmurphy@ti.com, rcsekar@samsung.com,
        pankaj.dubey@samsung.com
References: <CGME20191119102134epcas5p4d3c1b18203e2001c189b9fa7a0e3aab5@epcas5p4.samsung.com>
 <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 0/2] can: m_can_platform: Bug fix of kernel panic for
Message-ID: <24bfd497-c338-e1e2-e9c5-53d76fcc4abf@pengutronix.de>
Date:   Fri, 22 Nov 2019 15:56:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WbJi57JshuCrMT849Hnrby652bYoNf05B"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WbJi57JshuCrMT849Hnrby652bYoNf05B
Content-Type: multipart/mixed; boundary="0yKmq8RI8pX4qr3dLDqaRfcxmRSBygRYU";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Sharma <pankj.sharma@samsung.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, dmurphy@ti.com, rcsekar@samsung.com,
 pankaj.dubey@samsung.com
Message-ID: <24bfd497-c338-e1e2-e9c5-53d76fcc4abf@pengutronix.de>
Subject: Re: [PATCH 0/2] can: m_can_platform: Bug fix of kernel panic for
References: <CGME20191119102134epcas5p4d3c1b18203e2001c189b9fa7a0e3aab5@epcas5p4.samsung.com>
 <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
In-Reply-To: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>

--0yKmq8RI8pX4qr3dLDqaRfcxmRSBygRYU
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/19/19 11:20 AM, Pankaj Sharma wrote:
> The current code is failing while clock prepare enable because of not
> getting proper clock from platform device.=20
>=20
> [    0.852089] Call trace:
> [    0.854516]  0xffff0000fa22a668
> [    0.857638]  clk_prepare+0x20/0x34
> [    0.861019]  m_can_runtime_resume+0x2c/0xe4
> [    0.865180]  pm_generic_runtime_resume+0x28/0x38
> [    0.869770]  __rpm_callback+0x16c/0x1bc
> [    0.873583]  rpm_callback+0x24/0x78
> [    0.877050]  rpm_resume+0x428/0x560
> [    0.880517]  __pm_runtime_resume+0x7c/0xa8
> [    0.884593]  m_can_clk_start.isra.9.part.10+0x1c/0xa8
> [    0.889618]  m_can_class_register+0x138/0x370
> [    0.893950]  m_can_plat_probe+0x120/0x170
> [    0.897939]  platform_drv_probe+0x4c/0xa0
> [    0.901924]  really_probe+0xd8/0x31c
> [    0.905477]  driver_probe_device+0x58/0xe8
> [    0.909551]  device_driver_attach+0x68/0x70
> [    0.913711]  __driver_attach+0x9c/0xf8
> [    0.917437]  bus_for_each_dev+0x50/0xa0
> [    0.921251]  driver_attach+0x20/0x28
> [    0.924804]  bus_add_driver+0x148/0x1fc
> [    0.928617]  driver_register+0x6c/0x124
> [    0.932431]  __platform_driver_register+0x48/0x50
> [    0.937113]  m_can_plat_driver_init+0x18/0x20
> [    0.941446]  do_one_initcall+0x4c/0x19c
> [    0.945259]  kernel_init_freeable+0x1d0/0x280
> [    0.949591]  kernel_init+0x10/0x100
> [    0.953057]  ret_from_fork+0x10/0x18
> [    0.956614] Code: 00000000 00000000 00000000 00000000 (fa22a668)=20
> [    0.962681] ---[ end trace 881f71bd609de763 ]---
> [    0.967301] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x0000000b
>=20
> A device driver for CAN controller hardware registers itself with the
> Linux network layer as a network device. So, the driver data for m_can
> should ideally be of type net_device.=20
>=20
> Further even when passing the proper net device in probe function the
> code was hanging because of the function m_can_runtime_resume() getting=

> recursively called from m_can_class_resume().
>=20
> Pankaj Sharma (2):
>   can: m_can_platform: set net_device structure as driver data
>   can: m_can_platform: remove unnecessary m_can_class_resume() call

For the m_can driver I'm looking for a maintainer. Would be fine if
someone has a look at the mmio and someone else at the spi part.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--0yKmq8RI8pX4qr3dLDqaRfcxmRSBygRYU--

--WbJi57JshuCrMT849Hnrby652bYoNf05B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3X9wIACgkQWsYho5Hk
nSCbBwf/YzSZGICT73cxIHh/d0ZNN5pG6kyvpiJ80AAtNX12f2KfN5gmnnqmcvS5
eTZkSNjQ9dlQBnM7lvr2MjMA0YZY/wp3OZNQ0p+LXFwGHZxFRU1i84elaUVCkB+c
Gs+tRQ8GccjXt1sjhOqFcZJqGmAYvN24gGIsGKJbSNMNTnqj0wn5KrQlesTDKZGH
AhPBLk02a8tT6HvBOak6in4s+Ys2Nc0akE40ebZtXNN89ZdD0V4mCqUPcLgXt0AT
7jeV5x1XgtbxWHSQjH/pfnz86KlVF9X9fOQRfyTDQDkl63xynYthKLVVC35XgWF8
7wyFtKXR8VcuY95KmIhpvyYesxOVuQ==
=J8US
-----END PGP SIGNATURE-----

--WbJi57JshuCrMT849Hnrby652bYoNf05B--
