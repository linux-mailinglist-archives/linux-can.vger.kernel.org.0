Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12911F825A
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 22:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKKVhJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 16:37:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57817 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfKKVhI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2019 16:37:08 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iUHMw-0004u1-84; Mon, 11 Nov 2019 22:37:06 +0100
Received: from [IPv6:2a03:f580:87bc:d400:fcf3:94db:a77f:e6a3] (unknown [IPv6:2a03:f580:87bc:d400:fcf3:94db:a77f:e6a3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 460FD47A752;
        Mon, 11 Nov 2019 21:37:03 +0000 (UTC)
To:     Drew Fustini <pdp7pdp7@gmail.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de>
 <20191111200045.GB7051@x1>
 <CAEf4M_D1ZDmBFjO+VLYxLgOvzb_gpqad8443_OOw7CoEwqJ1Eg@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: mcp251x: read oscillator frequency?
Message-ID: <9c5a79bc-74ad-be14-999b-4be78e1b7bb1@pengutronix.de>
Date:   Mon, 11 Nov 2019 22:36:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAEf4M_D1ZDmBFjO+VLYxLgOvzb_gpqad8443_OOw7CoEwqJ1Eg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ze263RBmzYjfRIlvHFzU6W8XCI86HUuWu"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ze263RBmzYjfRIlvHFzU6W8XCI86HUuWu
Content-Type: multipart/mixed; boundary="Jmo9mRpac3wsqzqEBsch9SrKQxJIffyiL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Drew Fustini <pdp7pdp7@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <9c5a79bc-74ad-be14-999b-4be78e1b7bb1@pengutronix.de>
Subject: Re: mcp251x: read oscillator frequency?
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de>
 <20191111200045.GB7051@x1>
 <CAEf4M_D1ZDmBFjO+VLYxLgOvzb_gpqad8443_OOw7CoEwqJ1Eg@mail.gmail.com>
In-Reply-To: <CAEf4M_D1ZDmBFjO+VLYxLgOvzb_gpqad8443_OOw7CoEwqJ1Eg@mail.gmail.com>

--Jmo9mRpac3wsqzqEBsch9SrKQxJIffyiL
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/11/19 9:31 PM, Drew Fustini wrote:
>> On Mon, Nov 11, 2019 at 11:28:14AM +0100, Marc Kleine-Budde wrote:
>>> I successfully got a mcp25625 (which is basically a mcp2515 with
>>> internal phy) running on a rapsi using the frequency printed on the
>>> oscillator in the DT-overlay.
>>
>> I came across this patch by Andy on the linux-can archives:
>>
>> [PATCH v2] can: mcp251x: Get rid of legacy platform data
>> https://www.spinics.net/lists/linux-can/msg02407.html
>>
>> The description:
>> Instead of using legacy platform data, switch to use device properties=
=2E
>> For clock frequency we are using well established clock-frequency prop=
erty.
>>
>> I reads the clock-frequency property from device tree:
>>
>>         freq =3D clk_get_rate(clk);
>> -       if (freq =3D=3D 0 && pdata)
>> -               freq =3D pdata->oscillator_frequency;
>> +       if (freq =3D=3D 0)
>> +               device_property_read_u32(&spi->dev, "clock-frequency",=
 &freq);
>>
>>
>> I feel like this is currently missing from mcp251x.c.  I don't see how=
 it is
>> reading the clock frequency from Device Tree as I don't see any code i=
n the
>> current mcp251x.c to read device tree properties.
>>
>> I would appreciate any insights to improve my understanding.
>=20
> Also, I meant to ask as to why the clock for MCP2515 Oscillator comes
> from the spi device:
> clk =3D devm_clk_get(&spi->dev, NULL);

The mcp2515 is a SPI chip and it's clocked by an external oscillator.
This is described via the DT. Looking at a random board in the kernel:
arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi

>                 clk20m: clk20m {
>                         compatible =3D "fixed-clock";
>                         #clock-cells =3D <0>;
>                         clock-frequency =3D <20000000>;
>                         clock-output-names =3D "clk20m";
>                 };
[...]
>                         spi1: spi@fc018000 {
>                                 cs-gpios =3D <&pioB 22 0>, <&pioB 23 0>=
, <0>, <0>;
>                                 status =3D "okay";
>=20
>                                 can0: can@0 {
>                                         compatible =3D "microchip,mcp25=
15";
>                                         reg =3D <0>;
>                                         clocks =3D <&clk20m>;

This is a "link" (called phandle in the DT-world) to the "clk20m" node
above. That node has a "clock-frequency" property of 20MHz.

>                                         interrupt-parent =3D <&pioE>;
>                                         interrupts =3D <6 IRQ_TYPE_EDGE=
_RISING>;
>                                         spi-max-frequency =3D <10000000=
>;
>                                 };

By "devm_clk_get()" the driver first gets a reference to the clock and
by "clk_get_rate()" the frequency. This is generic non-spi specific DT
handling.

> line 1034 from:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/spi/mcp2=
51x.c#L1034
>=20
> It seem like there should be separate clocks for the SPI frequency and
> the MCP2515 oscillator frequency.
The SPI frequency, to be more precise the maximal SPI frequency the
mcp2515 supports on that particular board, is specified by the property
"spi-max-frequency" it's handled by the SPI core code.

hth,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--Jmo9mRpac3wsqzqEBsch9SrKQxJIffyiL--

--Ze263RBmzYjfRIlvHFzU6W8XCI86HUuWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3J1HsACgkQWsYho5Hk
nSBMFQf/cN4WNnM8QVtcVQ/Y711fnovXkZ2L7x42fbRqfaQyi4Gck0RyKIVMmnCx
+j5/tD9aDkRcdX6sNo8cdbDHHEOCD4u0DxMj9wLLgVw8Z4Ib+4poEmi93e/EEeWr
D59w1el8/JAB8Ko8P1veZKWfDB1ggMlCXHzjiHhsLbJGwt6LDl9Kk1Cy4poaLlxf
ygCtAVETppHktUAuf/2HU1QVPb53rnw3LX94mSd2AskemQ3r7X0Qp2Io/o7lKezt
KZTPKZJWXakcFbL+Mf16RS83XiznBiyPHIujIju6upAqz2FlmKwgFDpUQ4oFLS/c
UstXa/vdspvsjvQRC5i9CWBgh/jyWw==
=sHkg
-----END PGP SIGNATURE-----

--Ze263RBmzYjfRIlvHFzU6W8XCI86HUuWu--
