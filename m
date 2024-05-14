Return-Path: <linux-can+bounces-640-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0713C8C580B
	for <lists+linux-can@lfdr.de>; Tue, 14 May 2024 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C6028461C
	for <lists+linux-can@lfdr.de>; Tue, 14 May 2024 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E69217EBBB;
	Tue, 14 May 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dad7QvBI"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D70F17BB10;
	Tue, 14 May 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697246; cv=none; b=o1KxjfWNaifcKRqtqowglGal/6BBfCTM6mQBObvAC/Yex1Hkm8OsOrDUKpVtmvcLQDDHjazH6E4K45lhYEWfvbP1G7RZvG6p2LcNmks/fwkud4BDl/ndydyNh6w7AyV9ZBX7Sp+U4PAsXA67fu2jTCPKW8NbpmanSIB06NrxI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697246; c=relaxed/simple;
	bh=kvSyTsnMXDYsuCW1EWDCcml8RyRRgdNeHZOY1IEZpt0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdcWXmO37dR3c5D3lZN2dSAlJP17nPuOdX41gOgY0AMySeaGnswOC8CMw+lk4j0XV/kQsHvuCCNPZe03JdvMW40Zz8BTsj903xadZa20kpl7oB++r+t6iA11XJdJT+JBJy9QbXyYjtb1K5t1tnIMjY9Yv8Wl3/tDDrbdYIyjsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dad7QvBI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59ad344f7dso19520366b.0;
        Tue, 14 May 2024 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715697243; x=1716302043; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kvSyTsnMXDYsuCW1EWDCcml8RyRRgdNeHZOY1IEZpt0=;
        b=Dad7QvBIgF74tfCij36vbWKoZY0O6RhkxEk+bARQzsQb4gjiruScPzs59dCK3vKLGm
         Q1XSEzXgKDK3LM7ZtCD3j+sz7CJq1cqOBzEj5rueekqfIKQGVaTKhzP7EH2LGU2lgmJj
         lCS7RdUXkHZ5yFqErWAEaR8b2EXqDsUO1ODKzyYy4//+S0Y06ec4Y3MxQG3hejoRnWbn
         zmWfAD6mXjAuSTeP+TOYU6RdErmyUom/Ikrc01n5JoS07dLt7nszOD+Ba1n66Y2P6wXv
         ku/6X0/T+BP/jYdf5JWOr9VNvSdHia8WYN5eGOORvcaTpb05SK21pof3P5c0AHPCsvXG
         HhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715697243; x=1716302043;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvSyTsnMXDYsuCW1EWDCcml8RyRRgdNeHZOY1IEZpt0=;
        b=STmMVzYYGmV81A0yHyi5KhXpSeXTBFwSCIacm2Dlauhige2ajiseQe3SmL2eEHvNiG
         qwD6lVwK3KVYf7omYegvE2f+yG5jsAI5LOU1KK7GH+fFtE21PQ2bfVqn+OlhPizWtFDS
         7WYqG0QQKcFlzvANWdrfVLmmDoHipqBm9IvsORSHSooZrSzI4IxbwU+Q/5kDRl/Mpx/s
         koZGNpSki5XIXvOGytX8Ue5ct48zU3ixOTeTqD4nBDTLAhCQvymSwJnhKo0J6q4jxM+/
         Cjl3jrelG8uunq08OHesOflao67cayZPvfbajZC+9nJ5gIVGJMGT3z7s5VFu8oKhKcx7
         bIVg==
X-Forwarded-Encrypted: i=1; AJvYcCVMQ8V8YIyFRMRV7yULQt+2iJoimt5FCD1d06vq5mKmHhTf2n2fPvkNqazIJj8PV8Q+vvtr9DDyCUtRi0sEs8VLwcykg568qce1fkkY6IFJhDG7h6I5+KyXbWB2/rWI1chUj6zwKDQF6cIaJStUZPbdIyAt7q9wjC0FJNmpdcSDMWYkStMo5q3FHgN65vSlaPmJWVATl7qR
X-Gm-Message-State: AOJu0YzTS7oH5jWDF82BIh0CiMF5tUZ7kuZCfieJ5zt21XKiaUYMHbJQ
	UEvSOfLOlHvZlHl+jR49Fa7zxDpbPLcMb0EI3OGqbILdZfopRD+b
X-Google-Smtp-Source: AGHT+IGisZsYYuJpSHO6SXJJ11wxOP84sr7BbJsoJxY9upgHu5lJTphJGKaPF1hhgnvfoBVusGMqjw==
X-Received: by 2002:a17:906:f809:b0:a59:d063:f5f5 with SMTP id a640c23a62f3a-a5a2d681271mr786990966b.70.1715697242417;
        Tue, 14 May 2024 07:34:02 -0700 (PDT)
Received: from [192.168.10.8] (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01631sm728836866b.153.2024.05.14.07.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 07:34:02 -0700 (PDT)
Message-ID: <465a2ddb222beed7c90b36c523633fc5648715bb.camel@gmail.com>
Subject: Re: [PATCH v5] can: mcp251xfd: fix infinite loop when xmit fails
From: Vitor Soares <ivitro@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thomas Kopp
 <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Vitor Soares <vitor.soares@toradex.com>,
 linux-can@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 14 May 2024 15:34:01 +0100
In-Reply-To: <20240514-corgi-of-marvelous-peace-968f5c-mkl@pengutronix.de>
References: <20240514105822.99986-1-ivitro@gmail.com>
	 <20240514-corgi-of-marvelous-peace-968f5c-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Marc,

Appreciate your feedback.

On Tue, 2024-05-14 at 14:23 +0200, Marc Kleine-Budde wrote:
> On 14.05.2024 11:58:22, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > When the mcp251xfd_start_xmit() function fails, the driver stops
> > processing messages, and the interrupt routine does not return,
> > running indefinitely even after killing the running application.
> >=20
> > Error messages:
> > [=C2=A0 441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmi=
t: -16
> > [=C2=A0 441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer n=
ot empty.
> > (seq=3D0x000017c7, tef_tail=3D0x000017cf, tef_head=3D0x000017d0,
> > tx_head=3D0x000017d3).
> > ... and repeat forever.
> >=20
> > The issue can be triggered when multiple devices share the same
> > SPI interface. And there is concurrent access to the bus.
> >=20
> > The problem occurs because tx_ring->head increments even if
> > mcp251xfd_start_xmit() fails. Consequently, the driver skips one
> > TX package while still expecting a response in
> > mcp251xfd_handle_tefif_one().
> >=20
> > This patch resolves the issue by starting a workqueue to write
> > the tx obj synchronously if err =3D -EBUSY. In case of another error,
> > it decrements tx_ring->head, removes skb from the echo stack, and
> > drops the message.
>=20
> This looks quite good! Good work!
>=20
> I think you better move the allocation/destroy of the wq into the open()
> and stop() callbacks. You have to destroy the workqueue before putting
> the interface to sleep.
>=20
> >=20
> > Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxF=
D SPI
> > CAN")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> >=20
> > V4->V5:
> > =C2=A0 - Start a workqueue to write tx obj with spi_sync() when spi_asy=
nc() =3D=3D -
> > EBUSY.
> >=20
> > V3->V4:
> > =C2=A0 - Leave can_put_echo_skb() and stop the queue if needed, before
> > mcp251xfd_tx_obj_write().
> > =C2=A0 - Re-sync head and remove echo skb if mcp251xfd_tx_obj_write() f=
ails.
> > =C2=A0 - Revert -> return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() =
=3D=3D -EBUSY.
> >=20
> > V2->V3:
> > =C2=A0 - Add tx_dropped stats.
> > =C2=A0 - netdev_sent_queue() only if can_put_echo_skb() succeed.
> >=20
> > V1->V2:
> > =C2=A0 - Return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() =3D=3D -EBUS=
Y.
> > =C2=A0 - Rework the commit message to address the change above.
> > =C2=A0 - Change can_put_echo_skb() to be called after mcp251xfd_tx_obj_=
write()
> > succeed.
> > =C2=A0=C2=A0=C2=A0 Otherwise, we get Kernel NULL pointer dereference er=
ror.
> >=20
> > =C2=A0.../net/can/spi/mcp251xfd/mcp251xfd-core.c=C2=A0=C2=A0=C2=A0 | 13=
 ++++-
> > =C2=A0drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c=C2=A0 | 51 +++++++++=
+++++++---
> > =C2=A0drivers/net/can/spi/mcp251xfd/mcp251xfd.h=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 5 ++
> > =C2=A03 files changed, 60 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > index 1d9057dc44f2..6cca853f2b1e 100644
> > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > @@ -2141,15 +2141,25 @@ static int mcp251xfd_probe(struct spi_device *s=
pi)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out_free_candev;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv->tx_work_obj =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv->wq =3D alloc_workqueue=
("mcp251xfd_wq", WQ_FREEZABLE, 0);
>=20
> The m_can driver uses a ordered workqueue and you can add the name of
> the spi device to the wq's name :)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->wq =3D alloc_ordered_wor=
kqueue("%s-mcp251xfd_wq", WQ_FREEZABLE |
> WQ_MEM_RECLAIM, dev_name(&spi->dev));
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!priv->wq) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0err =3D -ENOMEM;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto out_can_rx_offload_del;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0INIT_WORK(&priv->tx_work, mc=
p251xfd_tx_obj_write_sync);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D mcp251xfd_regis=
ter(priv);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err_probe(&spi->dev, err, "Failed to detect =
%s.\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcp251xfd_get_model_str(priv));
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto out_can_rx_offload_del;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto out_can_free_wq;
>=20
> nitpick:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out_destroy_workqueue;
>=20
> to match the function call.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0
> > + out_can_free_wq:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0destroy_workqueue(priv->wq);
> > =C2=A0 out_can_rx_offload_del:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0can_rx_offload_del(&pri=
v->offload);
> > =C2=A0 out_free_candev:
> > @@ -2165,6 +2175,7 @@ static void mcp251xfd_remove(struct spi_device *s=
pi)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mcp251xfd_priv *=
priv =3D spi_get_drvdata(spi);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct net_device *ndev=
 =3D priv->ndev;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0destroy_workqueue(priv->wq);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0can_rx_offload_del(&pri=
v->offload);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mcp251xfd_unregister(pr=
iv);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spi->max_speed_hz =3D p=
riv->spi_max_speed_hz_orig;
> > diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > index 160528d3cc26..1e7ddf316643 100644
> > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > @@ -131,6 +131,41 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_p=
riv
> > *priv,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_obj->xfer[0].len =3D=
 len;
> > =C2=A0}
> > =C2=A0
> > +static void mcp251xfd_tx_failure_drop(const struct mcp251xfd_priv *pri=
v,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct mcp251xfd_tx_ring *tx_ring,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t err)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct net_device *ndev =3D =
priv->ndev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct net_device_stats *sta=
ts =3D &ndev->stats;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int frame_len =3D 0=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 tx_head;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_ring->head--;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stats->tx_dropped++;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_head =3D mcp251xfd_get_tx=
_head(tx_ring);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0can_free_echo_skb(ndev, tx_h=
ead, &frame_len);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netdev_completed_queue(ndev,=
 1, frame_len);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netif_wake_queue(ndev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (net_ratelimit())
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, =
err);
> > +}
> > +
> > +void mcp251xfd_tx_obj_write_sync(struct work_struct *ws)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mcp251xfd_priv *priv =
=3D container_of(ws, struct
> > mcp251xfd_priv,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 tx_work);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mcp251xfd_tx_obj *tx_=
obj =3D priv->tx_work_obj;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mcp251xfd_tx_ring *tx=
_ring =3D priv->tx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D spi_sync(priv->spi, =
&tx_obj->msg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0mcp251xfd_tx_failure_drop(priv, tx_ring, err);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv->tx_work_obj =3D NULL;
>=20
> Race condition:
> - after spi_sync() the CAN frame is send
> - after the TX complete IRQ the TX queue is restarted
> - the xmit handler might get BUSY
> - fill the tx_work_obj again
>=20
> > +}
> > +
> > =C2=A0static int mcp251xfd_tx_obj_write(const struct mcp251xfd_priv *pr=
iv,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mcp251xfd_tx_=
obj *tx_obj)
> > =C2=A0{
> > @@ -175,7 +210,7 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *sk=
b,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (can_dev_dropped_skb=
(ndev, skb))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return NETDEV_TX_OK;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mcp251xfd_tx_busy(priv, =
tx_ring))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mcp251xfd_tx_busy(priv, =
tx_ring) || priv->tx_work_obj)
>=20
> This should not happen, but better save than sorry.


As there is the race condition you mentioned above, on this condition:
priv->tx_work_obj =3D tx_obj --> xmit will return NETDEV_TX_BUSY

or

priv->tx_work_obj =3D NULL --> It goes through the rest of the code or the
workqueue may sleep after setting tx_work_obj to NULL. Should I use work_bu=
sy()
here instead or do you have another suggestion?


Everything else is clear to me and I'm addressing it for the v6.

Best regards,
Vitor Soares

