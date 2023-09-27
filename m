Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9907AFB6B
	for <lists+linux-can@lfdr.de>; Wed, 27 Sep 2023 08:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjI0Gxv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Sep 2023 02:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjI0Gxu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Sep 2023 02:53:50 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B1EB
        for <linux-can@vger.kernel.org>; Tue, 26 Sep 2023 23:53:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qlOQb-0003Cp-64; Wed, 27 Sep 2023 08:53:45 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qlOQa-009HSj-4B; Wed, 27 Sep 2023 08:53:44 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BA90B229708;
        Wed, 27 Sep 2023 06:53:43 +0000 (UTC)
Date:   Wed, 27 Sep 2023 08:53:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Eric Stahl <ericstahl@limntech.com>
Cc:     linux-can@vger.kernel.org, marm@hms-networks.de,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        socketcan@hms-networks.de, Florian Ferg <flfe@hms-networks.de>,
        Peter Seiderer <ps.report@gmx.net>
Subject: Re: IXXAT CAN-IB2XX drivers
Message-ID: <20230927-rely-slicer-d36eabd3b04f-mkl@pengutronix.de>
References: <20bd5abf-5d0f-86a5-4774-a8ba33d6ca1b@limntech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mmtlf2hqeethvljn"
Content-Disposition: inline
In-Reply-To: <20bd5abf-5d0f-86a5-4774-a8ba33d6ca1b@limntech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--mmtlf2hqeethvljn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.09.2023 23:10:52, Eric Stahl wrote:
> I was beginning to familiarize myself with the ix_active_can drivers
> for IXXAT CAN-IB2XX pci/pcie boards in an attempt to get IXXAT
> pci/pcie drivers into the kernel. I noticed that the device driver
> distributed by HMS
> (https://www.ixxat.com/docs/librariesprovider8/ixxat-english-new/pc-can-i=
nterfaces/linux-drivers/socketcan-linux.tgz)
> appears to be using the IFI CAN/CANFD core. There already appears to
> be a kernel driver (ifi_canfd_plat_driver) that leverages the IFI
> CAN/CANFD core. Should I continue to try to get the ix_active_can
> drivers into the kernel or should I try to leverage the existing
> ifi_canfd_plat_driver? If I should leverage the ifi_canfd_plat_driver,
> what approach should I take to get it compatible with the IXXAT
> pci/pcie cards?

I think it's best reusing the existing driver.

You can split the existing ifi_canfd_plat_probe() into a generic (i.e.
ifi_canfd_probe()) and a platform driver specific part. The PCIe and the
platform driver will alloc_candev() and fill out the bare minimum of
that structure and the call into the generic ifi_canfd_probe().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mmtlf2hqeethvljn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUT0XQACgkQvlAcSiqK
BOhhtQgAjbunCeF3OIsHacwT1qXdNh7sIroR4jMnvd2crmZGMe0AAF7YwhEmoSyr
/idER0kVB3z6LIfGi0hzCjgaHkoadI2/CkcqGuZj34aTLPhQYU5b6V30iVD0m0FY
ikfI4L+4Ga+zGhAyvaOwu2ApS4Gd69Xj0UYzAJ5w4pxPFsTwHnhvRr3xfTF1rqEf
rSo+IhSXBAbOkAjPyZKM+uIsm1mqtG2ojXcJqJsmTsp1ieWm6iArihorz74qdIBe
2IAhtWO/WRUzQzf+CcwT/5uLsygBleVYVHDzX6yWxZZvZRb5gwIja+PxanxGJ0YL
+sJ2aPCSvVw6XkwBgzwPrnPaItwf9A==
=yjGs
-----END PGP SIGNATURE-----

--mmtlf2hqeethvljn--
