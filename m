Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C783C637C69
	for <lists+linux-can@lfdr.de>; Thu, 24 Nov 2022 16:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiKXPCy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Nov 2022 10:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKXPCw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Nov 2022 10:02:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211842F6A
        for <linux-can@vger.kernel.org>; Thu, 24 Nov 2022 07:02:50 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oyDkE-0006Kb-TA; Thu, 24 Nov 2022 16:02:30 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:5507:4aba:5e0a:4c27])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E646A1286FC;
        Thu, 24 Nov 2022 15:02:27 +0000 (UTC)
Date:   Thu, 24 Nov 2022 16:02:26 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Raymond Tan <raymond.tan@intel.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] can: m_can: pci: add missing m_can_class_free_dev()
 in probe/remove methods
Message-ID: <20221124150226.vxvzimlll23unt7g@pengutronix.de>
References: <1668168684-6390-1-git-send-email-zhangchangzhong@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yockql4feiyza47j"
Content-Disposition: inline
In-Reply-To: <1668168684-6390-1-git-send-email-zhangchangzhong@huawei.com>
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


--yockql4feiyza47j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.11.2022 20:11:23, Zhang Changzhong wrote:
> In m_can_pci_remove() and error handling path of m_can_pci_probe(),
> m_can_class_free_dev() should be called to free resource allocated by
> m_can_class_allocate_dev(), otherwise there will be memleak.
>=20
> Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkhart L=
ake")
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--yockql4feiyza47j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmN/h34ACgkQrX5LkNig
0110kAf/awCUKjMOV4BkGa4KGpIgHzxAuo4iEfIlMEVCMK7aFdmu1ebzfWKlK5rZ
7Y8OTjjNr6f0HHYNuSqEqQj9gZzGUXbwlNhfDefAXr268p+dMQPHEdaKYgBrbFvL
RBAXm8PT3ppUr7chdwrE1VhPuudHNRfC8jK7LWPMj4KF0b/r0OHKi6b1KLiBUhYo
8VmDXSc2KtFKselc7I/kOo3j5PkOp8URM+SJIpq9jtP5XxSgBNqMvS4W0Wf2MYcx
XAe1xHcbiVSEvaqV5jxs+kiN1dky/ELyo/f2kBKPXkS76eFn+KQsfY/qIt+rNVFw
ubIGyyIrFCry0Mv6oOORLPDgOzDwog==
=Xd/+
-----END PGP SIGNATURE-----

--yockql4feiyza47j--
