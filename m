Return-Path: <linux-can+bounces-2565-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61E6A07C2A
	for <lists+linux-can@lfdr.de>; Thu,  9 Jan 2025 16:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7153A3A0F
	for <lists+linux-can@lfdr.de>; Thu,  9 Jan 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A300219A76;
	Thu,  9 Jan 2025 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LReGzzx7"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7E21CFE2
	for <linux-can@vger.kernel.org>; Thu,  9 Jan 2025 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437418; cv=none; b=ugZT92bi5HGd8WHYtBIyaOswbDmNKcMHCfz+Ba7JlGTSDHiZyJZa8SpBB3Spo/Rq0tLIsxsi/EJrPb7uToFTeq+sJvHJ2FujmiCUbJTZ0jaWV67iArgctOhOHOAGPv/QFOUYeSBRh9sv87SQHOptTbwmSKfLYmQxbYmiDubjs1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437418; c=relaxed/simple;
	bh=XVgozF5974tCyd0gUVqohNR1/PNl3f5C7ElTJi2D7ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bffFUg7sVEhrQxwGcVKaf4+QwQaUlutfWwPlDMJM0nzxcv1t5vuvaYyG/A/7Pr/Mr2EaxQ9IvGAlGV5HajW1P8L2/ZK0PpBjooo4/o/+72AEPtNKT8udsF4bTE2PNIevscB3L1DnjeF6eMWT2QmPwfEQLJ2/pJLpyy0DHfP/Xgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LReGzzx7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so13483735e9.0
        for <linux-can@vger.kernel.org>; Thu, 09 Jan 2025 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736437414; x=1737042214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yX1SbUIciwKIcD7gNhRUtkuf4Oxo1fB/K3g4xuBUpWM=;
        b=LReGzzx7rHdqkQeuJRcY8stT8S77HTWtV51rgryIxKHzWaMVP6qeNvZiObLsEfFh5a
         2Pu3zOnEepE3hm2NRwu1mCjmY7LvBcYtLLJ4fcJeQRIKiP2gDPZJDWBMXf80MGu3JAZy
         CnZZQe/1AkYkRiXDC2jLMfSAeGJoZ51gnUr1LRav+htnyA/3Zlu4e80zcyyAeDWAuF4U
         1+hQOBY/hwyPytQsoMt0cIxD8VDW7pCRU0+qU/3it1e6VWGyUuCUwUgVZ/fcM3AbbeSy
         XlzQ1ILz9pzqg3YCriWYiWUx/xuUB5LUb8FSm5gwhg0XSNguUuXIp8Y+wfgQWDP9xSKC
         TZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736437414; x=1737042214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yX1SbUIciwKIcD7gNhRUtkuf4Oxo1fB/K3g4xuBUpWM=;
        b=Kg7KqLvBtErDlKjvfpVNv1SeuDhqpEUon9XwQvpTqUF3NtuyzABq6uY2ZfQeqz1cfA
         MtGDa8Pr0QQr2pQd4oCgRQ1BXsZHloW+Pm2ai6mt6rHz4/fZu5sDe0tL10bN2OdqLQ7j
         38YpvaUdNaStxymCj45m1tlcI2QSM/zkM/NBBJ/K249X2Wy5CnvOrE10WpN3xH2pnAlL
         Vrt3w/PM36HXQAz4yJ/qWsLYIsPdvlMIU9OBmJuVmYFVOfMGjqJLeL1Xn/PMm81/NdRO
         SuCAuvdDBp/1h+dQii0hhp9slchZgz8blXDdTg+x/iq0X925CuLsRyD4VpjdBGSo6HA/
         ExbA==
X-Forwarded-Encrypted: i=1; AJvYcCWEzNR856Qvu7p+sqYIfBtuWti3lEBCLZQ8tsczTLLXecMs9JavNBD+sOqZdpKKgwOds2+h/FqEmKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2rlpyKtpJswJORaSGmH+TH7lGa/kV+QiMlKcQU10VNhftUZKA
	mhIbttNX/SZF1nF2RMcpTt1dntJYfq9ilQfRO90ZAyc+KwVpiTQPCskeqIKwD64=
X-Gm-Gg: ASbGnctI4ONMDkw19bjc4oVpGi/FHtqXbiRGLhOZ08hTiQclXo6gtmqeUz+eJN2RXKT
	0tEh4zAZjd5+Lg/32js4tEPuh2IHP12MblhVH1Y0YiOhrV2qZuzaYD2i5QajfWgBFdaYqE9B6Ur
	Y0ZQqfWUDYxE3124mdK7SZcme9WrBBbYtpqf/9+08qo1A3j5YXHe8KHCZv+qlu5nQAW/S1jZMI7
	IHru0GPh6DoaQtNsrXVIKP/GgP4H3eOTbcUKQEtt+5Ml0g2+HbU
X-Google-Smtp-Source: AGHT+IEuF6tQVtB3iLjcU4fe8xNNvCJgOlHnOa4Kb/PmEsHDjThvfjKcgmI0e2V6g5VBPHlDl2mwVA==
X-Received: by 2002:a5d:5f85:0:b0:386:3213:5b9b with SMTP id ffacd0b85a97d-38a8732c132mr7542954f8f.43.1736437414387;
        Thu, 09 Jan 2025 07:43:34 -0800 (PST)
Received: from localhost ([2001:4090:a245:80cb:3b5a:db2d:b2b7:c8b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b7f79sm2161267f8f.69.2025.01.09.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:43:33 -0800 (PST)
Date: Thu, 9 Jan 2025 16:43:32 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: subramanian.mohan@intel.com
Cc: rcsekar@samsung.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, balbi@kernel.org, raymond.tan@intel.com, 
	jarkko.nikula@linux.intel.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com, lst@pengutronix.de, 
	matthias.hahn@intel.com, srinivasan.chinnadurai@intel.com
Subject: Re: [PATCH 1/1] can: m_can: Control tx flow to avoid message stuck
Message-ID: <fzbw7i5wrpngg4ycapbo2g4b6d7ecykj4an3flcrxgwrp5t6cr@ogqcnsnvlwi2>
References: <20250108090112.58412-1-subramanian.mohan@intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ptnoju3rxvwa4zqc"
Content-Disposition: inline
In-Reply-To: <20250108090112.58412-1-subramanian.mohan@intel.com>


--ptnoju3rxvwa4zqc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] can: m_can: Control tx flow to avoid message stuck
MIME-Version: 1.0

Hi,

On Wed, Jan 08, 2025 at 02:31:12PM +0530, subramanian.mohan@intel.com wrote:
> From: Subramanian Mohan <subramanian.mohan@intel.com>
>=20
> The prolonged testing of passing can messages between
> two Elkhartlake platforms resulted in message stuck
> i.e Message did not receive at receiver side

Can you please describe the reason for the stuck messages in your
commit message? I am reading this but I don't understand why this
happens or why your proposed solution helps.

>=20
> Contolling TX i.e TEFN bit helped to resolve the message
> stuck issue.
>=20
> The current solution is enhanced/optimized from the below patch:
> https://lore.kernel.org/lkml/20230623051124.64132-1-kumari.pallavi@intel.=
com/T/
>=20
> Setup used to reproduce the issue:
>=20
> +---------------------+         +----------------------+
> |Intel ElkhartLake    |         |Intel ElkhartLake     |
> |       +--------+    |         |       +--------+     |
> |       |m_can 0 |    |<=3D=3D=3D=3D=3D=3D=3D>|       |m_can 0 |     |
> |       +--------+    |         |       +--------+     |
> +---------------------+         +----------------------+
>=20
> Steps to be run on the two Elkhartlake HW:
> 1)Bus-Rate is 1 MBit/s
> 2)Busload during the test is about 40%
> 3)we initialize the CAN with following commands
> 4)ip link set can0 txqueuelen 100/1024/2048
> 5)ip link set can0 up type can bitrate 1000000
>=20
> Python scripts are used send and receive the can messages
> between the EHL systems.
>=20
> Signed-off-by: Hahn Matthias <matthias.hahn@intel.com>
> Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
> ---
>  drivers/net/can/m_can/m_can.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 97cd8bbf2e32..0a2c9a622842 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1220,7 +1220,7 @@ static void m_can_coalescing_update(struct m_can_cl=
assdev *cdev, u32 ir)
>  static int m_can_interrupt_handler(struct m_can_classdev *cdev)
>  {
>  	struct net_device *dev =3D cdev->net;
> -	u32 ir =3D 0, ir_read;
> +	u32 ir =3D 0, ir_read, new_interrupts;
>  	int ret;
> =20
>  	if (pm_runtime_suspended(cdev->dev))
> @@ -1283,6 +1283,9 @@ static int m_can_interrupt_handler(struct m_can_cla=
ssdev *cdev)
>  			ret =3D m_can_echo_tx_event(dev);
>  			if (ret !=3D 0)
>  				return ret;
> +
> +			new_interrupts =3D cdev->active_interrupts & ~(IR_TEFN);
> +			m_can_interrupt_enable(cdev, new_interrupts);

Here is a theoretical situation of two messages being sent. The first is
being sent and handled in this interrupt handler. Then it would disable
the TEFN bit right? If the second message wasn't done sending yet, how
would it ever call the interrupt handler if the interrupt is disabled?

Also you are disabling this interrupt here regardless of the type of
mcan device and also regardless of the coalescing state. In the transmit
part you are only enabling it for non-peripheral devices. For peripheral
mcan devices this would also introduce an additional two transfers per
transmit.

In which situations is this really necessary? Does it help to implement
coalescing for non-peripheral devices?

Best
Markus

>  		}
>  	}
> =20
> @@ -1989,6 +1992,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff =
*skb,
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
>  	unsigned int frame_len;
>  	netdev_tx_t ret;
> +	u32 new_interrupts;
> =20
>  	if (can_dev_dropped_skb(dev, skb))
>  		return NETDEV_TX_OK;
> @@ -2008,8 +2012,11 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff=
 *skb,
> =20
>  	if (cdev->is_peripheral)
>  		ret =3D m_can_start_peripheral_xmit(cdev, skb);
> -	else
> +	else {
> +		new_interrupts =3D cdev->active_interrupts | IR_TEFN;
> +		m_can_interrupt_enable(cdev, new_interrupts);
>  		ret =3D m_can_tx_handler(cdev, skb);
> +	}
> =20
>  	if (ret !=3D NETDEV_TX_OK)
>  		netdev_completed_queue(dev, 1, frame_len);
> --=20
> 2.35.3
>=20

--ptnoju3rxvwa4zqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZ3/unwAKCRAkjLTi1BWu
P3cdAQD7IIk4hO3eiMH9Ze//hQCQiGhOi2I/aJtNeUN2MlWc0AD9EjzVfgbAhJcI
B8Cm8cJdjRKJtkKoBH6bwys3ZC2K3gA=
=eEqD
-----END PGP SIGNATURE-----

--ptnoju3rxvwa4zqc--

