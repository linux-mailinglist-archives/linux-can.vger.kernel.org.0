Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3D2A8320
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfIDMmG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 08:42:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54603 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfIDMmF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 08:42:05 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Ubn-0000XW-Ou; Wed, 04 Sep 2019 14:41:59 +0200
Received: from [IPv6:2a03:f580:87bc:d400:746e:2448:cd8f:dc51] (unknown [IPv6:2a03:f580:87bc:d400:746e:2448:cd8f:dc51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5449745325E;
        Wed,  4 Sep 2019 12:41:57 +0000 (UTC)
To:     Thomas.Kopp@microchip.com, martin@sperl.org,
        linux-can <linux-can@vger.kernel.org>
References: <6bb64740-bd74-6465-c017-5d0581f32101@sperl.org>
 <042C443F-731D-45B5-A092-2F041F0EADCF@sperl.org>
 <3AD46AF4-5589-4B28-9539-EB47B146B60D@sperl.org>
 <E88D73B8-00F9-48EA-9F2D-7F29FE22756F@sperl.org>
 <ECB8C3DB-E220-4E41-915D-E06F6CFCA8E8@sperl.org>
 <8A2E6272-0C56-4163-9A0E-1334E5A8B1C8@sperl.org>
 <74119C0B-8A5C-45AD-9919-E8E8479253E1@sperl.org>
 <9cd721b8-ed38-2ea6-49e6-b89614970cec@sperl.org>
 <5DE21741-C968-40BF-BE42-32C963F673C6@sperl.org>
 <B346DB94-FCF3-4F85-8568-905C6EA0E1AA@sperl.org>
 <MN2PR11MB3645AE47B236AD42961F2CB9FBB90@MN2PR11MB3645.namprd11.prod.outlook.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: MCP25XXFD Linux driver status
Message-ID: <70e48799-e20b-4b9c-8a05-42fa39d66bac@pengutronix.de>
Date:   Wed, 4 Sep 2019 14:41:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR11MB3645AE47B236AD42961F2CB9FBB90@MN2PR11MB3645.namprd11.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ho3hDtTxAODhJmlHQVKuCwREVh4k8HtfG"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ho3hDtTxAODhJmlHQVKuCwREVh4k8HtfG
Content-Type: multipart/mixed; boundary="WvnycoYLlVZrrr2C5jMWKPqJ9g4IXKFCV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Thomas.Kopp@microchip.com, martin@sperl.org,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <70e48799-e20b-4b9c-8a05-42fa39d66bac@pengutronix.de>
Subject: Re: MCP25XXFD Linux driver status
References: <6bb64740-bd74-6465-c017-5d0581f32101@sperl.org>
 <042C443F-731D-45B5-A092-2F041F0EADCF@sperl.org>
 <3AD46AF4-5589-4B28-9539-EB47B146B60D@sperl.org>
 <E88D73B8-00F9-48EA-9F2D-7F29FE22756F@sperl.org>
 <ECB8C3DB-E220-4E41-915D-E06F6CFCA8E8@sperl.org>
 <8A2E6272-0C56-4163-9A0E-1334E5A8B1C8@sperl.org>
 <74119C0B-8A5C-45AD-9919-E8E8479253E1@sperl.org>
 <9cd721b8-ed38-2ea6-49e6-b89614970cec@sperl.org>
 <5DE21741-C968-40BF-BE42-32C963F673C6@sperl.org>
 <B346DB94-FCF3-4F85-8568-905C6EA0E1AA@sperl.org>
 <MN2PR11MB3645AE47B236AD42961F2CB9FBB90@MN2PR11MB3645.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB3645AE47B236AD42961F2CB9FBB90@MN2PR11MB3645.namprd11.prod.outlook.com>

--WvnycoYLlVZrrr2C5jMWKPqJ9g4IXKFCV
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 9/3/19 6:28 PM, Thomas.Kopp@microchip.com wrote:
> I finally started with reviewing and testing the MCP25xxFD driver (way
> later than originally planned=E2=80=A6)

I'm familiar with this situation :/

> To start with: I don=E2=80=99t have any background in Kernel developmen=
t (my
> background is mainly bare-metal firmware for 8bit/small 32-bit CM0+
> devices), so I=E2=80=99ll be focusing on device specifics of the 2517/1=
8 and
> things that seem strange to me and might end up asking stupid questions=

> about kernel-specifics.

=2E..there are no stupid questions.

> I noticed that Marc is currently working on implementing changes and
> fixes here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/=
log/?h=3Dmcp25xxfd-rpi

For now it's just random hacking. However that yielded some fixes I want
to upstream. That's why I asked for the correct branch in Martin's repo
to send pull request to.

> Is development progressing there now?

I hope it's progressing, but for now I'm happy to keep the upstream at
Martin's repo. It has a much larger user base than linux-can-next.

> Should I base feedback my feedback on the latest release from Martin or=

> on the latest code from you Marc?

Use Martin's latest release for now.

> I did find that previous feedback seems to be scattered around mailing
> lists and dedicated distribution list. In what way is the feedback
> preferred? Comments/Questions to a specific distribution list? Patches?=


I'm interested in mainline development only. Please use this mailinglist
here. Post patches using git send-email.

The rest will settle in :)

> As for the hardware: I=E2=80=99ll mainly be testing with our SAMA5D27 p=
roducts,
> but also have a couple RPIs lying around to test with.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WvnycoYLlVZrrr2C5jMWKPqJ9g4IXKFCV--

--Ho3hDtTxAODhJmlHQVKuCwREVh4k8HtfG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1vsRAACgkQWsYho5Hk
nSARsAf/cn/f6ICxwblO8fH0cQ65NlELqmxARMfwVy7BALRSfkKdgo1SNdKL1QNg
ErVvp8w3DzQvx8gF3x4zKmmPDDFZPTrNjP7ADasFVgfZby3Kfs9wctA25QKwpDit
iP3JaBpvvysKG6m6p61jH/cSm1/hYRwJB8FlURwYDEKEMNXmYbpCcdu9dnmQW2Lr
4AVTplK0H1Z3p3GjIWh8GZEZDg4W1vUIWtbpeZBagU5M3Vb2k7aY04IA1vhCDMjh
dp60woQcgV6Qzb+I9W0Ug2DItc0WZDLrcRRrwAZ/RHx9yeNBvQJ0QfGphATYvVfS
rW0QoJYE8+5rREdAMMjezKtpn+W5EQ==
=l12l
-----END PGP SIGNATURE-----

--Ho3hDtTxAODhJmlHQVKuCwREVh4k8HtfG--
