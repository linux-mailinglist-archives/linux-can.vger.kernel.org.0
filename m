Return-Path: <linux-can+bounces-1780-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7320A9B023E
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 14:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE541C21359
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 12:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7555C1F80DB;
	Fri, 25 Oct 2024 12:24:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39BA1F9431
	for <linux-can@vger.kernel.org>; Fri, 25 Oct 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859065; cv=none; b=Kfa3aeTQxVGE/0wFbqI3L918nfzYmmW0lY0qaWuCO9X9+6q21XNpTUqdMIzKxbPSiDMKtEwBJ01CLZjNDSZ0B01NeXCcvKAqaWxHS0mRWlnF2D8bL8LXMyAvw/ykTmbMfBzuV+WehvfQnB4ihJEseuEAz7zNkzPExUODiMEj0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859065; c=relaxed/simple;
	bh=RotsDzwV65vdcegbc+IWs4ohE9v9gVi2rfCJNN0Lg0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz7s1s0kZ0QhFoRHQFJlcWNXIjTQj2HS0dDCaJjyHmAFiur9HGhBgv3HnD9rADtAlNLmzTFDMAhdi2kKywVrpZsp6OgmM+9C9G/mqRcfANgIRl9ooKA/4DvLuk9DuMKzWItcPO+5AyKJ7VOmSP7oER5NklUGrNAxD9ylDngBtLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4JMG-0002fY-8D; Fri, 25 Oct 2024 14:24:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4JMC-000MW9-0p;
	Fri, 25 Oct 2024 14:23:56 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CAFC235EA1D;
	Fri, 25 Oct 2024 12:23:55 +0000 (UTC)
Date: Fri, 25 Oct 2024 14:23:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, linus.walleij@linaro.org, 
	brgl@bgdev.pl, andi.shyti@kernel.org, mailhol.vincent@wanadoo.fr, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, wim@linux-watchdog.org, linux@roeck-us.net, jdelvare@suse.com, 
	jic23@kernel.org, lars@metafoo.de, ukleinek@kernel.org, 
	alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 1/9] mfd: Add core driver for Nuvoton NCT6694
Message-ID: <20241025-spirited-nocturnal-antelope-ce93dd-mkl@pengutronix.de>
References: <20241024085922.133071-1-tmyu0@nuvoton.com>
 <20241024085922.133071-2-tmyu0@nuvoton.com>
 <20241024-adventurous-imaginary-hornet-4d5c46-mkl@pengutronix.de>
 <CAOoeyxUhnyYG3p+DQJG-tvU5vc5WYQZLLqCXW=uPcXTjq2gVfw@mail.gmail.com>
 <20241025-truthful-honest-newt-c371c8-mkl@pengutronix.de>
 <CAOoeyxUEf5vjqL67WjR-DbrhE0==2hqHLEyZ5XEBhEfMfQ5pag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z3j4brfwrbwtq3fy"
Content-Disposition: inline
In-Reply-To: <CAOoeyxUEf5vjqL67WjR-DbrhE0==2hqHLEyZ5XEBhEfMfQ5pag@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--z3j4brfwrbwtq3fy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/9] mfd: Add core driver for Nuvoton NCT6694
MIME-Version: 1.0

On 25.10.2024 19:03:55, Ming Yu wrote:
> Oh! I'm sorry about that I confused the packet size.
> The NCT6694 bulk maximum packet size is 256 bytes,
> and USB High speed bulk maximum packet size is 512 bytes.
>=20
> Marc Kleine-Budde <mkl@pengutronix.de> =E6=96=BC 2024=E5=B9=B410=E6=9C=88=
25=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:08=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > On 25.10.2024 16:08:10, Ming Yu wrote:
> > > > > +int nct6694_read_msg(struct nct6694 *nct6694, u8 mod, u16 offset=
, u16 length,
> > > > > +                  u8 rd_idx, u8 rd_len, unsigned char *buf)
> > > >
> > > > why not make buf a void *?
> > >
> > > [Ming] I'll change the type in the next patch.
> > >
> > > >
> > > > > +{
> > > > > +     struct usb_device *udev =3D nct6694->udev;
> > > > > +     unsigned char err_status;
> > > > > +     int len, packet_len, tx_len, rx_len;
> > > > > +     int i, ret;
> > > > > +
> > > > > +     mutex_lock(&nct6694->access_lock);
> > > > > +
> > > > > +     /* Send command packet to USB device */
> > > > > +     nct6694->cmd_buffer[REQUEST_MOD_IDX] =3D mod;
> > > > > +     nct6694->cmd_buffer[REQUEST_CMD_IDX] =3D offset & 0xFF;
> > > > > +     nct6694->cmd_buffer[REQUEST_SEL_IDX] =3D (offset >> 8) & 0x=
FF;
> > > > > +     nct6694->cmd_buffer[REQUEST_HCTRL_IDX] =3D HCTRL_GET;
> > > > > +     nct6694->cmd_buffer[REQUEST_LEN_L_IDX] =3D length & 0xFF;
> > > > > +     nct6694->cmd_buffer[REQUEST_LEN_H_IDX] =3D (length >> 8) & =
0xFF;
> > > > > +
> > > > > +     ret =3D usb_bulk_msg(udev, usb_sndbulkpipe(udev, BULK_OUT_E=
NDPOINT),
> > > > > +                        nct6694->cmd_buffer, CMD_PACKET_SZ, &tx_=
len,
> > > > > +                        nct6694->timeout);
> > > > > +     if (ret)
> > > > > +             goto err;
> > > > > +
> > > > > +     /* Receive response packet from USB device */
> > > > > +     ret =3D usb_bulk_msg(udev, usb_rcvbulkpipe(udev, BULK_IN_EN=
DPOINT),
> > > > > +                        nct6694->rx_buffer, CMD_PACKET_SZ, &rx_l=
en,
> > > > > +                        nct6694->timeout);
> > > > > +     if (ret)
> > > > > +             goto err;
> > > > > +
> > > > > +     err_status =3D nct6694->rx_buffer[RESPONSE_STS_IDX];
> > > > > +
> > > > > +     /*
> > > > > +      * Segmented reception of messages that exceed the size of =
USB bulk
> > > > > +      * pipe packets.
> > > > > +      */
> > > >
> > > > The Linux USB stack can receive bulk messages longer than the max p=
acket size.
> > >
> > > [Ming] Since NCT6694's bulk pipe endpoint size is 128 bytes for this =
MFD device.
> > > The core will divide packet 256 bytes for high speed USB device, but
> > > it is exceeds
> > > the hardware limitation, so I am dividing it manually.
> >
> > You say the endpoint descriptor is correctly reporting it's max packet
> > size of 128, but the Linux USB will send packets of 256 bytes?
>=20
> [Ming] The endpoint descriptor is correctly reporting it's max packet
> size of 256, but the Linux USB may send more than 256 (max is 512)
> https://elixir.bootlin.com/linux/v6.11.5/source/drivers/usb/host/xhci-mem=
=2Ec#L1446

AFAIK according to the USB-2.0 spec the maximum packet size for
high-speed bulk transfers is fixed set to 512 bytes. Does this mean that
your device is a non-compliant USB device?

> > > > > +     for (i =3D 0, len =3D length; len > 0; i++, len -=3D packet=
_len) {
> > > > > +             if (len > nct6694->maxp)
> > > > > +                     packet_len =3D nct6694->maxp;
> > > > > +             else
> > > > > +                     packet_len =3D len;
> > > > > +
> > > > > +             ret =3D usb_bulk_msg(udev, usb_rcvbulkpipe(udev, BU=
LK_IN_ENDPOINT),
> > > > > +                                nct6694->rx_buffer + nct6694->ma=
xp * i,
> > > > > +                                packet_len, &rx_len, nct6694->ti=
meout);
> > > > > +             if (ret)
> > > > > +                     goto err;
> > > > > +     }
> > > > > +
> > > > > +     for (i =3D 0; i < rd_len; i++)
> > > > > +             buf[i] =3D nct6694->rx_buffer[i + rd_idx];
> > > >
> > > > memcpy()?
> > > >
> > > > Or why don't you directly receive data into the provided buffer? Co=
pying
> > > > of the data doesn't make it faster.
> > > >
> > > > On the other hand, receiving directly into the target buffer means =
the
> > > > target buffer must not live on the stack.
> > >
> > > [Ming] Okay! I'll change it to memcpy().
> >
> > fine!
> >
> > > This is my perspective: the data is uniformly received by the rx_bffe=
r held
> > > by the MFD device. does it need to be changed?
> >
> > My question is: Why do you first receive into the nct6694->rx_buffer and
> > then memcpy() to the buffer provided by the caller, why don't you
> > directly receive into the memory provided by the caller?
>=20
> [Ming] Due to the bulk pipe maximum packet size limitation, I think consi=
stently
> using the MFD'd dynamically allocated buffer to submit URBs will better
> manage USB-related operations

The non-compliant max packet size limitation is unrelated to the
question which RX or TX buffer to use.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--z3j4brfwrbwtq3fy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcbjdgACgkQKDiiPnot
vG95/AgAiPNi/vMS9nchDZVXjokoV01fOqux/uWYm+s/lk7YtmY8A44YW4qnCziW
AOtNeirWbJkwxb2gXSJoK7kvmkzC0+AKgJgksEaV9w8iu36UwdncI9DddyFBqp94
PtK+pw4tDYIMbCv4kfBwZYfd3jLkhd2gUpSCy5ILk8kYXOt3okVldhS+fRVP7HvV
lz0bdF8a+MHgpnYI8ird2jHHUkaCMDqmkwQ5ZNaqwxRUGOuoGLiHcsrsijM6y0N7
eVkF1YBCJDx9GB/uBAF0ySqoCk43czk3hGNRxImH5oN8Z1vaFj8ojSHQKSRrDqS2
eFNtgifkiNOayvdYTjHVPmq2TfsYHA==
=aegl
-----END PGP SIGNATURE-----

--z3j4brfwrbwtq3fy--

