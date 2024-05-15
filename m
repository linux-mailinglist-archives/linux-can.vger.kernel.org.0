Return-Path: <linux-can+bounces-642-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C50F8C6A92
	for <lists+linux-can@lfdr.de>; Wed, 15 May 2024 18:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CEAB20849
	for <lists+linux-can@lfdr.de>; Wed, 15 May 2024 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207615665B;
	Wed, 15 May 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvPLn1wK"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618113EFE5;
	Wed, 15 May 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790583; cv=none; b=F24c/v2oBywfTw1nNjhPJx+IkWfBAb1a05g445B5B5xJAr4E+d9X5lwXC4+L0LVvkryx+dORSdcvQNHfUTLBcRwFdh6oENY2QQCkoDt5noqX7QCTjqx3G/qvS+UZgEwvYrKFdY3+PxDoUHxOzSTk+AYCGqNOfrORwiyJkCtDZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790583; c=relaxed/simple;
	bh=rBBC+aSahEmVK7ZPwrfWO9sJBrFh5xxG85dkqntLIq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Le4iUkKVIlE8V44OKta/dyxXZiNE5ffXPwU/E3+BzkOEhixb7SWLGvGZ7nlgfHov1dy7JZAPyaLgPucCUSNU+iQPsISKwNsr0a59ZIx5zB4imehyO04V9wjHLnhyA5UGIT4suZoaXw4mcqhdlWp7qlAB6G1nBmmGipwIncqXsWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvPLn1wK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a9d66a51so189768266b.2;
        Wed, 15 May 2024 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715790580; x=1716395380; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBBC+aSahEmVK7ZPwrfWO9sJBrFh5xxG85dkqntLIq8=;
        b=PvPLn1wKsSO9PJVvmVG+2WmNPx8vq5hWDU4auhlA+p075eYdXAfaLq0cSh8ebRZQEX
         aU67e6aD63RAaQndV5fDagv90+iSY8BfRlnBJmUqnwnWjKPUahwuP5RjL8s7OYIx05QK
         9avF+sslYmvsjgzJExtf0LSnWgG/mi6DM5647Ap7i1pjR963CjiV5msa9zCEd3Ix7Xtn
         0dCA/fK3+7pEYbmW4WVVEFR0dXHF6a2ZehfE84xM57TOgv/0NUPbtk9sOzDFVE4PeBSa
         rDrQXL7Ub1qlxkaBec/xZQTgJJ27FofvkLgG9I88Om8C+qLCj1MAwfRTpByASTC0/vEY
         9G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715790580; x=1716395380;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBBC+aSahEmVK7ZPwrfWO9sJBrFh5xxG85dkqntLIq8=;
        b=H4HBUuHVP6LLL7XYQYagi8vCAdSGiYDt9YJk/Rnvm5Z88H5wbDcq3HQkR1XRled9mq
         x4/3f5+rR7HEXUzxdnPeff39/40A7VTg03YCYiaO37NvIGV+2IjhdYL0BRrQMU/x2csv
         eGmE40WISuC93cCeqbHcroCJ1fU836LuZgxBtVOFEZiNZ2txt9pBdxTUBia+PLN5zZe6
         5/4M0+xhL//ObCGfE3k1F64nen7ArzaKl/Z6OtJB06I2PXV6yODckxJTc/SEzoDY7zpL
         4fyzFjlkVDzIRhVTdb2g6cEWD5UVZTmTq6wIOWe4TtWeU9wC9g/wxWBjARD6Y/I+nkrm
         4ULA==
X-Forwarded-Encrypted: i=1; AJvYcCUTmdvU/A3yTrG2z3HqinXdKMMC9Gavd6G45mqrAWtG03M9llrDCwUdw5gTiGV5cSPzYg3SX6DivBAwEjgvlUTAiGSaeJZh19HHPokckzyCFA33kuK8V+oe5yBcOUC2ETSgjnP9Y/M/IM6tysIqCNPmosBIAvDe8Y8cy/LYVIpU37xd3fLO5R/5RD4Z1lZwlLeJHORpzbqt
X-Gm-Message-State: AOJu0Yy3+sQg2e9qrUe4P+mNXvGZzTEx/Reqi9W3KwzuWA7kE//A4Hyu
	Ydk++98GubBj37aM8ppIrhNUREXDiFqdCFe2lsBX7dXbsMJEk750
X-Google-Smtp-Source: AGHT+IFKimaUstziNEwfRQmnoURBuwCag4JfaSU65VBAInR3zjN+zSk8n2vTRLiJ26j9RrK4poO98A==
X-Received: by 2002:a17:906:5a5a:b0:a5a:34ae:10ea with SMTP id a640c23a62f3a-a5a34ae118emr924333366b.76.1715790579864;
        Wed, 15 May 2024 09:29:39 -0700 (PDT)
Received: from [192.168.10.8] (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d57sm881641966b.73.2024.05.15.09.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:29:39 -0700 (PDT)
Message-ID: <11e4ff07ad6c0e9077326cf288665922ccfc0afd.camel@gmail.com>
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
Date: Wed, 15 May 2024 17:29:38 +0100
In-Reply-To: <20240515-athletic-sensible-swine-4e7692-mkl@pengutronix.de>
References: <20240514105822.99986-1-ivitro@gmail.com>
	 <20240514-corgi-of-marvelous-peace-968f5c-mkl@pengutronix.de>
	 <465a2ddb222beed7c90b36c523633fc5648715bb.camel@gmail.com>
	 <20240515-athletic-sensible-swine-4e7692-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-15 at 13:12 +0200, Marc Kleine-Budde wrote:
> On 14.05.2024 15:34:01, Vitor Soares wrote:
> > > > +void mcp251xfd_tx_obj_write_sync(struct work_struct *ws)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mcp251xfd_priv *priv =
=3D container_of(ws, struct
> > > > mcp251xfd_priv,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 tx_work);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mcp251xfd_tx_obj *tx_o=
bj =3D priv->tx_work_obj;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mcp251xfd_tx_ring *tx_=
ring =3D priv->tx;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D spi_sync(priv->spi, &=
tx_obj->msg);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mcp251xfd_tx_failure_drop(priv, tx_ring, err);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->tx_work_obj =3D NULL;
> > >=20
> > > Race condition:
> > > - after spi_sync() the CAN frame is send
> > > - after the TX complete IRQ the TX queue is restarted
> > > - the xmit handler might get BUSY
> > > - fill the tx_work_obj again
>=20
> You can avoid the race condition by moving "priv->tx_work_obj =3D NULL;"
> in front of the "spi_sync();". Right?
>=20
> > > > +}
> > > > +
> > > > =C2=A0static int mcp251xfd_tx_obj_write(const struct mcp251xfd_priv=
 *priv,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mcp251xfd_=
tx_obj *tx_obj)
> > > > =C2=A0{
> > > > @@ -175,7 +210,7 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff
> > > > *skb,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (can_dev_dropped_skb(=
ndev, skb))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return NETDEV_TX_OK;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mcp251xfd_tx_busy(priv, t=
x_ring))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mcp251xfd_tx_busy(priv, t=
x_ring) || priv->tx_work_obj)
> > >=20
> > > This should not happen, but better save than sorry.
> >=20
> > As there is the race condition you mentioned above, on this condition:
> > priv->tx_work_obj =3D tx_obj --> xmit will return NETDEV_TX_BUSY
> >=20
> > or
> >=20
> > priv->tx_work_obj =3D NULL --> It goes through the rest of the code or
> > the workqueue may sleep after setting tx_work_obj to NULL. Should I
> > use work_busy() here instead or do you have another suggestion?
>=20
> Yes, introduce mcp251xfd_work_busy().
>=20

I'll implement it.

> I'm not sure what happens if the xmit is called between the
> "priv->tx_work_obj =3D NULL" and the end of the work. Will queue_work()
> return false, as the queue is still running?

From the test I did so far, my understanding is the following:

If mcp251xfd_tx_obj_write doesn't fail, everything is OK.

if mcp251xfd_tx_obj_write fails with EBUSY=20
 - stop netif queue
 - fill the tx_work_obj
 - start worker

queue_work() doesn't return false even when work_busy() =3D true.=20
 - xmit handler return, and wait netif_wake_queue()
 - the work handler waits until the previous job gets done before starting =
the=20
next one.
 - after the TX completes IRQ, the TX queue is restarted

If the TX queue is restarted immediately after queue_work(), tx_work_obj is
filled, making the xmit handler return NETDEV_TX_BUSY.

The tests were done with a delay after priv->tx_work_obj =3D NULL.


Best regards,
Vitor Soares

