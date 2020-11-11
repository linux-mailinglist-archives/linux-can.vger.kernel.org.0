Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908C72AF1FD
	for <lists+linux-can@lfdr.de>; Wed, 11 Nov 2020 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKKNYD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Nov 2020 08:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKKNYC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2020 08:24:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43ADC0613D4
        for <linux-can@vger.kernel.org>; Wed, 11 Nov 2020 05:24:02 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kcq6O-0005yj-3w; Wed, 11 Nov 2020 14:23:56 +0100
Received: from [IPv6:2a03:f580:87bc:d400:59aa:4a7a:d5ce:5d42] (unknown [IPv6:2a03:f580:87bc:d400:59aa:4a7a:d5ce:5d42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2CD3658FEEC;
        Wed, 11 Nov 2020 13:23:54 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] dt-bindings: can: flexcan: convert fsl,*flexcan
 bindings to yaml
To:     Rob Herring <robh+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
References: <20201022075218.11880-1-o.rempel@pengutronix.de>
 <20201022075218.11880-3-o.rempel@pengutronix.de>
 <CAL_JsqKSdGAY03HK1SBGec-j4S0cmm-mntJ8e0ujHVX4E3dnMw@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <069937f4-9173-db5c-1297-3412cd3eaf8c@pengutronix.de>
Date:   Wed, 11 Nov 2020 14:23:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKSdGAY03HK1SBGec-j4S0cmm-mntJ8e0ujHVX4E3dnMw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eUDJ60eeREhWCPjWKbdWg8Vp4QT865bFZ"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eUDJ60eeREhWCPjWKbdWg8Vp4QT865bFZ
Content-Type: multipart/mixed; boundary="ERFdNakKZUwdawvHEam35ovD1ou077l2g";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rob Herring <robh+dt@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, linux-can@vger.kernel.org,
 netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Joakim Zhang <qiangqing.zhang@nxp.com>
Message-ID: <069937f4-9173-db5c-1297-3412cd3eaf8c@pengutronix.de>
Subject: Re: [PATCH v3 2/2] dt-bindings: can: flexcan: convert fsl,*flexcan
 bindings to yaml
References: <20201022075218.11880-1-o.rempel@pengutronix.de>
 <20201022075218.11880-3-o.rempel@pengutronix.de>
 <CAL_JsqKSdGAY03HK1SBGec-j4S0cmm-mntJ8e0ujHVX4E3dnMw@mail.gmail.com>
In-Reply-To: <CAL_JsqKSdGAY03HK1SBGec-j4S0cmm-mntJ8e0ujHVX4E3dnMw@mail.gmail.com>

--ERFdNakKZUwdawvHEam35ovD1ou077l2g
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/10/20 4:43 PM, Rob Herring wrote:
> On Thu, Oct 22, 2020 at 2:52 AM Oleksij Rempel <o.rempel@pengutronix.de=
> wrote:
>>
>> In order to automate the verification of DT nodes convert
>> fsl-flexcan.txt to fsl,flexcan.yaml
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Link: https://lore.kernel.org/r/20201016073315.16232-3-o.rempel@pengut=
ronix.de
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  .../bindings/net/can/fsl,flexcan.yaml         | 135 +++++++++++++++++=
+
>>  .../bindings/net/can/fsl-flexcan.txt          |  57 --------
>>  2 files changed, 135 insertions(+), 57 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/can/fsl,flex=
can.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/net/can/fsl-flex=
can.txt
>=20
> Why did this go into v5.10-rc3? It's not a fix and now a fix is needed:=


Sorry, this was against the rules and not a good idea.

> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/=
clock/imx5-clock.example.dt.yaml:
> can@53fc8000: compatible: 'oneOf' conditional failed, one must be
> fixed:
>  ['fsl,imx53-flexcan', 'fsl,p1010-flexcan'] is too long
>  Additional items are not allowed ('fsl,p1010-flexcan' was unexpected)
>  'fsl,imx53-flexcan' is not one of ['fsl,imx7d-flexcan',
> 'fsl,imx6ul-flexcan', 'fsl,imx6sx-flexcan']
>  'fsl,imx53-flexcan' is not one of ['fsl,ls1028ar1-flexcan']
>  'fsl,imx6q-flexcan' was expected
>  'fsl,lx2160ar1-flexcan' was expected
>  From schema: /builds/robherring/linux-dt-bindings/Documentation/device=
tree/bindings/net/can/fsl,flexcan.yaml
> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/=
net/can/fsl,flexcan.example.dt.yaml:
> can@2090000: fsl,stop-mode: [[4294967295, 52, 28]] is too short
>  From schema: /builds/robherring/linux-dt-bindings/Documentation/device=
tree/bindings/net/can/fsl,flexcan.yaml

I've both issues and found two more. See the following thread for details=
:

http://lore.kernel.org/r/20201111130507.1560881-1-mkl@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--ERFdNakKZUwdawvHEam35ovD1ou077l2g--

--eUDJ60eeREhWCPjWKbdWg8Vp4QT865bFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+r5eQACgkQqclaivrt
76nIVwf/cIaU7Yb2o1dv5Cp41tSczTTFQDJzKajAppaf+iDAt18ojiqN/67AjqdY
RBqyp+VT9XiLONV3pyuxua368KJ8nMKOF9rKyFoWvDTCeN4MKVY3z4b67wtVktho
iiJSoB0yrNgKb39vzzGrEvxkiSYf4DntwEvKeYy6u4V1/yeZ+y+WIX+K5HWs2H5S
0NsfQTxxLxRUmYjwj2tvSN3BCdMLK4+rzOHI33NCDd2z3mlFfq4669HAflFp7+dO
hc5YFvVlga9EqBtRSum+WSjsDmivMnmq+UyjG4F1Iii5uUW3pCnzKfECmLmaJ4OC
YvvBEGPu/zCe7S+DLV7HmqmZf1Zd/Q==
=IgaO
-----END PGP SIGNATURE-----

--eUDJ60eeREhWCPjWKbdWg8Vp4QT865bFZ--
