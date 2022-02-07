Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520A04AB8F8
	for <lists+linux-can@lfdr.de>; Mon,  7 Feb 2022 11:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiBGKpE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Feb 2022 05:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbiBGKgA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Feb 2022 05:36:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBB5C043181
        for <linux-can@vger.kernel.org>; Mon,  7 Feb 2022 02:35:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nH1NF-0001tD-F3; Mon, 07 Feb 2022 11:35:57 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AFA722D66A;
        Mon,  7 Feb 2022 10:35:55 +0000 (UTC)
Date:   Mon, 7 Feb 2022 11:35:51 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mishak <mishak@eiq.co.za>
Cc:     kernel@pengutronix.de, linux-can <linux-can@vger.kernel.org>
Subject: Re: MCP251xfd PLLEN
Message-ID: <20220207103551.3lf3dzdcm4fguack@pengutronix.de>
References: <c7787001-40a3-d794-6646-bb6d01313aaf@eiq.co.za>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bbzp3zzf45kjkex5"
Content-Disposition: inline
In-Reply-To: <c7787001-40a3-d794-6646-bb6d01313aaf@eiq.co.za>
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


--bbzp3zzf45kjkex5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Mishak,

I've added the linux-can mailing list on Cc. The question is of general
interest :D

On 04.02.2022 18:01:07, Mishak wrote:
> I hope you are well. I developed custom hardware for raspberry pi cm4
> with mcp2518 for CAN support. From what I gather the mcp251xfd driver
> does not support extclk with frequency of 4Mhz. I am looking for a
> branch with PLLEN set for use with 4Mhz clock. Does such a branch
> exist? Is there a plan to mainline a mcp251xfd driver with PLLEN
> support for 4Mhz clocks?

I have a net properly cleaned up branch that adds PLL support. I've
pushed it to the linux-can-next git repo:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/=
?h=3Dtesting

Please test and give me feedback.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bbzp3zzf45kjkex5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIA9gQACgkQrX5LkNig
0111jQgAsn9Uvg8seoUsavnHMIEeX2wjABhNfIatGb69gKpyiCqECAzFCFOWgB1J
8kg0J/DG/kPsip1Gr1jbHDUFodXLWJ55nbmr/wLjpjH+Msbq/LjpBRUDBe1hsjpN
OR7y8H1d5GUxbWDAMSc2H7QY4A5ugV/7T+PichRYb8d+zANFNBvigxGvwMe+pHPB
wYYZ0l0aUOTPmB8Aol6DzefQ1Sh7rem5O69BM+4N+tReJAwspph/qZmzuxfGc7zU
P3a4GwCT4e+vkxvsq9YhDRUutm+9hhxFh77h7ofnTFY/xWWPdnibXU7366aTIH0/
YjwwcVXTPc47iz3tB4w30tOJVvnJ+A==
=ps+z
-----END PGP SIGNATURE-----

--bbzp3zzf45kjkex5--
