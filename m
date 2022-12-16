Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0CC64EE52
	for <lists+linux-can@lfdr.de>; Fri, 16 Dec 2022 16:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiLPP5S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Dec 2022 10:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiLPP5O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Dec 2022 10:57:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2ADF2E
        for <linux-can@vger.kernel.org>; Fri, 16 Dec 2022 07:57:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p6D4v-0006JF-4P; Fri, 16 Dec 2022 16:56:53 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a779:30ea:4b2a:44b8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 441BE140EC9;
        Fri, 16 Dec 2022 15:56:48 +0000 (UTC)
Date:   Fri, 16 Dec 2022 16:56:39 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        speakup@linux-speakup.org, linux-can@vger.kernel.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291
Message-ID: <20221216155639.wp2t6wqtcfzw3ov2@pengutronix.de>
References: <639c8c39./q+QZSDrWluXOpoJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qx4fdxrhbrb4hgcr"
Content-Disposition: inline
In-Reply-To: <639c8c39./q+QZSDrWluXOpoJ%lkp@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--qx4fdxrhbrb4hgcr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.12.2022 23:18:17, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-n=
ext.git master
> branch HEAD: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291  Add linux-next spe=
cific files for 20221216
>=20
> Error/Warning reports:
>=20
> https://lore.kernel.org/oe-kbuild-all/202211180516.dtOWIlEo-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202211180955.UiXgTkeu-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202211190207.Rf66o1j0-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202211242120.MzZVGULn-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202212020520.0OkMIno3-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202212051759.cEv6fyHy-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202212142121.vendKsOc-lkp@intel.com
>=20
> Error/Warning: (recently discovered and may have been fixed)

I think none of these Errors/Warnings are linux-can related, am I
missing something?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qx4fdxrhbrb4hgcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOclTUACgkQrX5LkNig
012mzQgAiHhOG/kg5QGDimeqlSQPqRYlVDz41081SJa4PvjfsJCk7GIqy83Zu0RW
PCsXlT8qOZmr7ec5PGE9jDMlVXh/Ht3EDOxCCymqszlyQ6+O4itYal9vghEU3n44
RopjPes1vyIh5xXV3k/OMCAzXejOP4diLrXEQeSUD8SQsXzG6Yt6psF/NQ8imFV1
HBu7SgWrPVLDKbLb22MXyHlbxSFqz1Gdn+f/0+GCBdV5SqwBkk7nfD1H6fr/hWoD
Z35fhmmczvlxkrWvl1h6RuA/fuCGht6qvzysCgS1fi6Ga0htEL9wY+eLHJzk8Cks
1YFg9BK0PTFhFdn9KxBZFFu78ZmrmA==
=LWnh
-----END PGP SIGNATURE-----

--qx4fdxrhbrb4hgcr--
