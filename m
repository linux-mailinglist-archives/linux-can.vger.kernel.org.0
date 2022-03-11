Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A29D4D61C2
	for <lists+linux-can@lfdr.de>; Fri, 11 Mar 2022 13:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345534AbiCKMuq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Mar 2022 07:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiCKMup (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 11 Mar 2022 07:50:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9DA1B65C5
        for <linux-can@vger.kernel.org>; Fri, 11 Mar 2022 04:49:42 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nSei8-0002Xl-Ch; Fri, 11 Mar 2022 13:49:36 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9CD2948EDB;
        Fri, 11 Mar 2022 12:49:31 +0000 (UTC)
Date:   Fri, 11 Mar 2022 13:49:30 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Oliver Hartkopp <socketcan@hartkopp.net>,
        lkp@intel.com, kbuild-all@lists.01.org, linux-can@vger.kernel.org
Subject: Re: [mkl-can-next:testing 4/29] drivers/net/can/vxcan.c:60
 vxcan_xmit() error: use kfree_skb() here instead of kfree(oskb)
Message-ID: <20220311124930.3ei7xvbnsuqzaug3@pengutronix.de>
References: <202203110433.qIHMpuS5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5n5iz6dazu5udutn"
Content-Disposition: inline
In-Reply-To: <202203110433.qIHMpuS5-lkp@intel.com>
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


--5n5iz6dazu5udutn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.03.2022 14:16:25, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-nex=
t.git testing
> head:   0691a4b55c89055c1efb61a7696f4bc6aa5cf630
> commit: 1574481bb3de11c9d44f5405c17e948b76794f39 [4/29] vxcan: remove sk =
reference in peer skb
> config: arc-randconfig-m031-20220310 (https://download.01.org/0day-ci/arc=
hive/20220311/202203110433.qIHMpuS5-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 11.2.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Good Bot!

> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> New smatch warnings:
> drivers/net/can/vxcan.c:60 vxcan_xmit() error: use kfree_skb() here inste=
ad of kfree(oskb)

The totally makes sense, I've send a patch:
https://lore.kernel.org/all/20220311123741.382618-1-mkl@pengutronix.de

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5n5iz6dazu5udutn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIrRVgACgkQrX5LkNig
0126mAf/SOJSvia5qez7lTsAdpwOihepFd+yn6NO7Le7P8/O/gzHdZn/9QSI2nP0
DfpNGb/iMAqo7Ec0wOifClFlExmlEfFKQmTsv5HawQxR6AjCTXiwOeIU0C/2YHFO
5U2UdcbkDW3VoZbMOfb5dGyXZq7VZUBQamigE+tIrpPNQnzZH2CAS6zqEe9B/wYm
UWSBUSs5lF0+OVtNvOgJFud+GSU7z/UtDeaJwf9fDcrwM0sNboN7qWy5yECwQxLo
37sHZQMpCk9zkfVZJLiStbxqWgaoejucwVk3cceNKDj8sDUdYkMjkN76LP5ieXtA
IbKpMH8eJoqvZMjk+Z1VfYUzxyPHcQ==
=x7iw
-----END PGP SIGNATURE-----

--5n5iz6dazu5udutn--
