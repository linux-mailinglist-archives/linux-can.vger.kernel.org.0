Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595062F4F76
	for <lists+linux-can@lfdr.de>; Wed, 13 Jan 2021 17:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhAMQFe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jan 2021 11:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbhAMQFd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jan 2021 11:05:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F637C061575
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 08:04:53 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kzida-0002er-53; Wed, 13 Jan 2021 17:04:46 +0100
Received: from [IPv6:2a03:f580:87bc:d400:fee8:1d97:dec2:c25] (unknown [IPv6:2a03:f580:87bc:d400:fee8:1d97:dec2:c25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AF8515C2D7F;
        Wed, 13 Jan 2021 16:04:41 +0000 (UTC)
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jimmy Assarsson <extja@kvaser.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "open list : NETWORKING DRIVERS" <netdev@vger.kernel.org>
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr>
 <7643bd48-6594-9ede-b791-de6e155c62c1@pengutronix.de>
 <CAMZ6Rq+HggK2HHkPn_QTKzz-niyiU8AkHc4rP5AXE+AqJmkbrg@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
Message-ID: <24603b31-fe7b-1f03-4939-fa074f471239@pengutronix.de>
Date:   Wed, 13 Jan 2021 17:04:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+HggK2HHkPn_QTKzz-niyiU8AkHc4rP5AXE+AqJmkbrg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="nBmtDLkusjkNMRqfqeMFPowSU7LenMjxr"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nBmtDLkusjkNMRqfqeMFPowSU7LenMjxr
Content-Type: multipart/mixed; boundary="IkY9vCoecN0EmxtpMO6eRMzwTE6SYS4Gr";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: linux-can <linux-can@vger.kernel.org>,
 Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jimmy Assarsson <extja@kvaser.com>, Masahiro Yamada <masahiroy@kernel.org>,
 "open list : NETWORKING DRIVERS" <netdev@vger.kernel.org>
Message-ID: <24603b31-fe7b-1f03-4939-fa074f471239@pengutronix.de>
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr>
 <7643bd48-6594-9ede-b791-de6e155c62c1@pengutronix.de>
 <CAMZ6Rq+HggK2HHkPn_QTKzz-niyiU8AkHc4rP5AXE+AqJmkbrg@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+HggK2HHkPn_QTKzz-niyiU8AkHc4rP5AXE+AqJmkbrg@mail.gmail.com>

--IkY9vCoecN0EmxtpMO6eRMzwTE6SYS4Gr
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/13/21 1:15 PM, Vincent MAILHOL wrote:
>>> +/**
>>> + * es58x_calculate_crc() - Compute the crc16 of a given URB.
>>> + * @urb_cmd: The URB command for which we want to calculate the CRC.=

>>> + * @urb_len: Length of @urb_cmd. Must be at least bigger than 4
>>> + *   (ES58X_CRC_CALC_OFFSET + sizeof(crc))
>>> + *
>>> + * Return: crc16 value.
>>> + */
>>> +static u16 es58x_calculate_crc(const union es58x_urb_cmd *urb_cmd, u=
16 urb_len)
>>> +{
>>> +     u16 crc;
>>> +     ssize_t len =3D urb_len - ES58X_CRC_CALC_OFFSET - sizeof(crc);
>>> +
>>> +     WARN_ON(len < 0);
>>
>> Is it possible to ensure earlier, that the urbs are of correct length?=

>=20
> Easy answer: it is ensured.

Okay, then get rid of those checks :)

> On the Tx branch, I create the urbs so I
> know for sure that the length is correct. On the Rx branch, I have a
> dedicated function: es58x_check_rx_urb() for this purpose.  I
> will remove that WARN_ON() and the one in es58x_get_crc().
>=20
> I will also check the other WARN_ON() in my code to see if they
> can be removed (none on my test throughout the last ten months or
> so could trigger any of these WARN_ON() so should be fine to
> remove but I will double check).

[..]

>>> +struct es58x_priv {
>>> +     struct can_priv can;
>>> +     struct es58x_device *es58x_dev;
>>> +     struct urb *tx_urb;
>>> +
>>> +     spinlock_t echo_skb_spinlock;   /* Comments: c.f. supra */
>>> +     u32 current_packet_idx;
>>> +     u16 echo_skb_tail_idx;
>>> +     u16 echo_skb_head_idx;
>>> +     u16 num_echo_skb;
>>
>> Can you explain me how the tx-path works, especially why you need the
>> current_packet_idx.
>>
>> In the mcp251xfd driver, the number of TX buffers is a power of two, t=
hat makes
>> things easier. tx_heads % len points to the next buffer to be filled, =
tx_tail %
>> len points to the next buffer to be completed. tx_head - tx_tail is th=
e fill
>> level of the FIFO. This works without spinlocks.
>=20
> For what I understand of your explanations here are the equivalences
> between the etas_es58x and the mcp251xfd drivers:
>=20
>  +--------------------+-------------------+
>  | etas_es58x         | mcp251xfd         |
>  +--------------------+-------------------+
>  | current_packet_idx | tx_head           |
>  | echo_skb_tail_idx  | tx_tail % len     |
>  | echo_skb_head_idx  | tx_head % len     |
>  | num_echo_skb       | tx_head - tx_tail |
>  +--------------------+-------------------+
>=20
> Especially, the current_packet_idx is sent to the device and returned
> to the driver upon completion.

Is current_packet_idx used only for the TX-PATH?

> I wish the TX buffers were a power of two which is unfortunately not
> the case. The theoretical TX buffer sizes are 330 and 500 for the two
> devices so I wrote the code to work with those values. The exact size
> of the TX buffer is actually even more of a mystery because during
> testing both devices were unstable when using the theoretical values
> and I had to lower these. There is a comment at the bottom of
> es581_4.c and es58x_fd.c to reflect those issues.

What are the performance penalties for using 256 for the fd and 64 ofr th=
e other?

> Because I do not
> have access to the source code of the firmware, I could not identify
> the root cause.

ok

> My understanding is that having a queue size being a power of two is
> required in order not to use spinlocks (else, modulo operations would
> break when the index wraparound back to zero). I tried to minimize the
> number of spinlock: only one per bulk send or bulk receive.

With queue size being power of two the modulo can be written as a mask
operation, so it's reasonable fast. So you only need to care about tx_hea=
d and
tx_tail, and there is only one writer for each variable. With a little da=
nce and
barriers when stopping and starting the queue it's race-free without spin=
locks.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--IkY9vCoecN0EmxtpMO6eRMzwTE6SYS4Gr--

--nBmtDLkusjkNMRqfqeMFPowSU7LenMjxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl//GhYACgkQqclaivrt
76kEkwf/cL97S82lhXjdDrVVze6C90BQdtYnv3xaqGEe95/pdU8Q4HFUSRye5vkY
XGaJvzQPWD1tMR4iOwEsIF4vz10typr8EFzLHmWcM8+L1oKFo2juyiQUPcpe8Lzm
iKfaw/idzFVWciAwn2Lnb8fOy2vBv+rGlF1vspEAy15M012/Y/bwPBMkvw9X1Hug
NxhF8hJiEwEI/7C8mPu1T62LIkkYyWs4X0IBfliuRY3O6BbVCjL5qNxlmu4Qzys/
MdNvHxrl2flqKG0AAayHMJTpFRp1Zed3JP4GalhdFDtXPcPiQRneyD2QbSDiK7yY
iafM5kZrgVedHhUM6DEbHK2msJ61bQ==
=gxgK
-----END PGP SIGNATURE-----

--nBmtDLkusjkNMRqfqeMFPowSU7LenMjxr--
