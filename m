Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD899112501
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2019 09:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLDIbP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Dec 2019 03:31:15 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43439 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfLDIbO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Dec 2019 03:31:14 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1icQ3z-0002nE-Aq; Wed, 04 Dec 2019 09:31:11 +0100
Received: from [IPv6:2a03:f580:87bc:d400:858e:130c:14c0:366e] (unknown [IPv6:2a03:f580:87bc:d400:858e:130c:14c0:366e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 18891488F0F;
        Wed,  4 Dec 2019 08:31:10 +0000 (UTC)
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-2-qiangqing.zhang@nxp.com>
 <b77829d5-9eda-a244-3ee8-2ccdbdfb6524@pengutronix.de>
 <DB7PR04MB46183730127339DAC15ABF33E65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH V2 1/4] can: flexcan: fix deadlock when using self wakeup
Message-ID: <b4ce5a7a-7fc0-edb2-608e-4030ce6428a2@pengutronix.de>
Date:   Wed, 4 Dec 2019 09:31:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB46183730127339DAC15ABF33E65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gNfDjcm1x9HHDAIkEGdoHJkH587wTN8L3"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gNfDjcm1x9HHDAIkEGdoHJkH587wTN8L3
Content-Type: multipart/mixed; boundary="RsU4ZEJsDnWk1wNwXlT3btpEzfioQ0U3D";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <b4ce5a7a-7fc0-edb2-608e-4030ce6428a2@pengutronix.de>
Subject: Re: [PATCH V2 1/4] can: flexcan: fix deadlock when using self wakeup
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-2-qiangqing.zhang@nxp.com>
 <b77829d5-9eda-a244-3ee8-2ccdbdfb6524@pengutronix.de>
 <DB7PR04MB46183730127339DAC15ABF33E65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB46183730127339DAC15ABF33E65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>

--RsU4ZEJsDnWk1wNwXlT3btpEzfioQ0U3D
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/4/19 2:58 AM, Joakim Zhang wrote:
> [...]
>>>  drivers/net/can/flexcan.c | 19 +++++++++++--------
>>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index 2efa06119f68..2297663cacb2 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -134,8 +134,7 @@
>>>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)  #define
>>> FLEXCAN_ESR_ALL_INT \
>>>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
>>> -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
>>> -	 FLEXCAN_ESR_WAK_INT)
>>> +	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
>>
>> Why do you remove the FLEXCAN_ESR_WAK_INT from the
>> FLEXCAN_ESR_ALL_INT?
>>
>>>
>>>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>>>  /* Errata ERR005829 step7: Reserve first valid MB */ @@ -960,6
>>> +959,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>>
>>>  	reg_esr =3D priv->read(&regs->esr);
>>>
>>> +	/* ACK wakeup interrupt */
>>> +	if (reg_esr & FLEXCAN_ESR_WAK_INT) {
>>> +		handled =3D IRQ_HANDLED;
>>> +		priv->write(reg_esr & FLEXCAN_ESR_WAK_INT, &regs->esr);
>>> +	}
>>> +
>>
>> If FLEXCAN_ESR_WAK_INT stays in FLEXCAN_ESR_ALL_INT, you don't need
>> that explicit ACK here.
>=20
> Hi Marc,
>=20
> I remove the FLEXCAN_ESR_WAK_INT from the FLEXCAN_ESR_ALL_INT since
> FLEXCAN_ESR_ALL_INT is for all bus error and state change IRQ
> sources, wakeup interrupt does not belong to these. If you think this
> does not need, I can remove this change.

I see, makes sense.

Make this a separate patch. Move the FLEXCAN_ESR_WAK_INT from the
FLEXCAN_ESR_ALL_INT, but add it to the existing ack of the interrupts.
Like this:

> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index b6f675a5e2d9..74f622b40b61 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -960,10 +960,10 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
> =20
>         reg_esr =3D priv->read(&regs->esr);
> =20
> -       /* ACK all bus error and state change IRQ sources */
> -       if (reg_esr & FLEXCAN_ESR_ALL_INT) {
> +       /* ACK all bus error, state change and wake IRQ sources */
> +       if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
>                 handled =3D IRQ_HANDLED;
> -               priv->write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);=

> +               priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ES=
R_WAK_INT), &regs->esr);
>         }
> =20
>         /* state change interrupt or broken error state quirk fix is en=
abled */

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--RsU4ZEJsDnWk1wNwXlT3btpEzfioQ0U3D--

--gNfDjcm1x9HHDAIkEGdoHJkH587wTN8L3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3nbskACgkQWsYho5Hk
nSCM+Qf+O704RSvmyOPEQZDym+oL1w3DRt7iDaIrOET+5giecvKBt+xRX2ogTzqI
BQnYlT4wf40FNlEi62/TJ3EBLEQS8FBH54hEtofn+JKm0yyf3ITpO/xSX0sGqr/+
gC7a8eWCCo6Ypmdtw7kELWiKANXDmgd2RQMXLxwMKMiEa99DPrh/Bxf0kjZ/cVfm
ptkQxARsOVxii03vlwA7w86bkHRLU15XZVhDMuXnI5YRTdL0+z85BR6lzW3CPFR3
XifJ3jlWnDLh4g8BUG6OsJHhoj8HMuC0El2vcVTKEJBx6MUYvpU5Csl8AvbNmAAi
MRTSL0LuB9cuQMCvPv55PY1+NRsBTg==
=5XGv
-----END PGP SIGNATURE-----

--gNfDjcm1x9HHDAIkEGdoHJkH587wTN8L3--
