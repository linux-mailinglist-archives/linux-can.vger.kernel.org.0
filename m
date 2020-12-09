Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910142D3C74
	for <lists+linux-can@lfdr.de>; Wed,  9 Dec 2020 08:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgLIHp7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Dec 2020 02:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgLIHp7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Dec 2020 02:45:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CFEC0613CF
        for <linux-can@vger.kernel.org>; Tue,  8 Dec 2020 23:45:18 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kmu9x-00035y-8v; Wed, 09 Dec 2020 08:45:13 +0100
Received: from [IPv6:2a03:f580:87bc:d400:8e8d:7805:9bb0:cb77] (unknown [IPv6:2a03:f580:87bc:d400:8e8d:7805:9bb0:cb77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E0E725A84A0;
        Wed,  9 Dec 2020 07:45:09 +0000 (UTC)
Subject: Re: [net 3/3] can: isotp: add SF_BROADCAST support for functional
 addressing
To:     Jakub Kicinski <kuba@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Thomas Wagner <thwa1@web.de>, linux-can@vger.kernel.org,
        kernel@pengutronix.de, netdev@vger.kernel.org, davem@davemloft.net
References: <20201204133508.742120-1-mkl@pengutronix.de>
 <20201204133508.742120-4-mkl@pengutronix.de>
 <20201204194435.0d4ab3fd@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <b4acc4eb-aff6-9d20-b8a9-d1c47213cefd@hartkopp.net>
 <eefc4f80-da1c-fed5-7934-11615f1db0fc@pengutronix.de>
 <20201205123300.34f99141@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <ce547683-925d-6971-6566-a0b54146090a@pengutronix.de>
 <20201205130904.3d81b0dc@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <752c8838-b478-43da-620b-e15bcc690518@hartkopp.net>
 <20201208100718.5ed008dc@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <20e31c74-eb50-072c-1212-a58eb8da704b@pengutronix.de>
Date:   Wed, 9 Dec 2020 08:45:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201208100718.5ed008dc@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="yQf7H64lAYxLepZfl5AlEHn5hISni0zkB"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yQf7H64lAYxLepZfl5AlEHn5hISni0zkB
Content-Type: multipart/mixed; boundary="jhzGGYkFOtQzqGNHHiJInQCkyMy4dp0ie";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Thomas Wagner <thwa1@web.de>, linux-can@vger.kernel.org,
 kernel@pengutronix.de, netdev@vger.kernel.org, davem@davemloft.net
Message-ID: <20e31c74-eb50-072c-1212-a58eb8da704b@pengutronix.de>
Subject: Re: [net 3/3] can: isotp: add SF_BROADCAST support for functional
 addressing
References: <20201204133508.742120-1-mkl@pengutronix.de>
 <20201204133508.742120-4-mkl@pengutronix.de>
 <20201204194435.0d4ab3fd@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <b4acc4eb-aff6-9d20-b8a9-d1c47213cefd@hartkopp.net>
 <eefc4f80-da1c-fed5-7934-11615f1db0fc@pengutronix.de>
 <20201205123300.34f99141@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <ce547683-925d-6971-6566-a0b54146090a@pengutronix.de>
 <20201205130904.3d81b0dc@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <752c8838-b478-43da-620b-e15bcc690518@hartkopp.net>
 <20201208100718.5ed008dc@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201208100718.5ed008dc@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>

--jhzGGYkFOtQzqGNHHiJInQCkyMy4dp0ie
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/8/20 7:07 PM, Jakub Kicinski wrote:
> On Tue, 8 Dec 2020 13:54:28 +0100 Oliver Hartkopp wrote:
>> On 05.12.20 22:09, Jakub Kicinski wrote:
>>> On Sat, 5 Dec 2020 21:56:33 +0100 Marc Kleine-Budde wrote: =20
>>>> On 12/5/20 9:33 PM, Jakub Kicinski wrote: =20
>>>>>> What about the (incremental?) change that Thomas Wagner posted?
>>>>>>
>>>>>> https://lore.kernel.org/r/20201204135557.55599-1-thwa1@web.de =20
>>>>>
>>>>> That settles it :) This change needs to got into -next and 5.11. =20
>>>>
>>>> Ok. Can you take patch 1, which is a real fix:
>>>>
>>>> https://lore.kernel.org/linux-can/20201204133508.742120-2-mkl@pengut=
ronix.de/ =20
>>>
>>> Sure! Applied that one from the ML (I assumed that's what you meant).=

>>
>> I just double-checked this mail and in fact the second patch from Marc=
's=20
>> pull request was a real fix too:
>>
>> https://lore.kernel.org/linux-can/20201204133508.742120-3-mkl@pengutro=
nix.de/
>=20
> Ack, I thought it was a fix to some existing code but it's a fix to
> ISO-TP so we should probably get it in before someone start depending
> on existing behavior - Marc should I apply that one directly, too?

Yes, please take that patch directly.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--jhzGGYkFOtQzqGNHHiJInQCkyMy4dp0ie--

--yQf7H64lAYxLepZfl5AlEHn5hISni0zkB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl/QgIEACgkQqclaivrt
76l28ggAjlNGPNIw8y8MTOAsrUROnwi1BLpmntX4Fa1IX30OoJs2gwcFyidJo1bA
XUR9hyxUHyY+/kSLStBPXVAyNhCjqh5IUw08OCIVu/eRT3j/OfcdU/MxNgqpkq8B
Od2cqIOylCn0SdbimgHReDvRs3gjEz0AJuE2IDZOwUEDC4VsV3bmA+8L+BOJVveV
CTPS2m3zgmjzFfz528Hqon+TysGhbiSon60or0Il3d1HTErJcSrz/VhcUtomF5cC
uLkTnN7qKUzfQR0SwwtvwfijSYqvRUr8gdeWhFDUtnoMS1ufQVrq3zHGHKOiG2GO
DAlVi9uhRA2qQP6ie7kwkzFN0zlvvw==
=QpzY
-----END PGP SIGNATURE-----

--yQf7H64lAYxLepZfl5AlEHn5hISni0zkB--
