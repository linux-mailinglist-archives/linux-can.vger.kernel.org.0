Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3F07060EA
	for <lists+linux-can@lfdr.de>; Wed, 17 May 2023 09:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjEQHQL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 May 2023 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEQHQJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 May 2023 03:16:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8526A1BE3
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 00:16:07 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzBO2-0004yw-UQ; Wed, 17 May 2023 09:15:51 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 79BA01C6CFB;
        Wed, 17 May 2023 07:15:48 +0000 (UTC)
Date:   Wed, 17 May 2023 09:15:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Thomas.Kopp@microchip.com, marex@denx.de,
        linux-can@vger.kernel.org, fedor.ross@ifm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, lgirdwood@gmail.com,
        mani@kernel.org, broonie@kernel.org, pabeni@redhat.com,
        wg@grandegger.com
Subject: Re: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Message-ID: <20230517-shrunk-dinner-e6c43f73c936-mkl@pengutronix.de>
References: <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
 <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
 <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <BL3PR11MB6484A68C2B2CFFAA44AD3E09FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJo=j7wsfOPsYRn++vMSnhKBuQAwckZ-u7qwjBdsb_d_g@mail.gmail.com>
 <BL3PR11MB64843D32844A848AAC7BFDF1FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqK266c+taxgUqd_2kSfbNDgTawkcthTaM+4JXpeLV0cfQ@mail.gmail.com>
 <BL3PR11MB64846AD5ACBC42C74D11DF7DFB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6Rq+M+nyxq2YaOVmVngTVZbAUHd4+YJUasvwyAkxiZJmxGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eo7vf5j5lkluxsyk"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+M+nyxq2YaOVmVngTVZbAUHd4+YJUasvwyAkxiZJmxGw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--eo7vf5j5lkluxsyk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.05.2023 20:19:38, Vincent Mailhol wrote:
[...]
> ISO 11898-1 is such a rabbit hole... sights...

How do we proceed?

I like Marek's approach of defining the delay first in the driver and
then moving it to a common header in the second patch to facilitate
backporting.

Do we agree on the maximum number of bits to wait in the worst case?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--eo7vf5j5lkluxsyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRkfyEACgkQvlAcSiqK
BOja+Qf6AiHXC/1TqfR0z59U4o0iGYme8HQoLvPS1XGMA0MPIQOp+xkVn48+a/jq
NomS+OOF14SSUTmlHapvzTHiCoTTkFaA5TGVW/6I03MJWQmfIFT7jzOuBxSychpr
I+NdHvPbwkhMCovzn+oKu/ZHcEShDpgA7zJ3tzOa2Nl6uW5vAaPaR160+tv84QJo
LuK7qYQNFgWgPlVjWxoXSBy4rHB8lIUdd9wXkcl9uUlrsNRoygZ5bvFv8+XC2rQk
KwqPBJbZ4TyT5lGML4Ngfm+1+KV3JD1/Hj43RwXKeDwtdAavedv5UGlNQbaNBrxY
C/L957pI+tE9dOfO73aGoGCT+E8tzQ==
=zBH4
-----END PGP SIGNATURE-----

--eo7vf5j5lkluxsyk--
