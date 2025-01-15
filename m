Return-Path: <linux-can+bounces-2655-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F55A12743
	for <lists+linux-can@lfdr.de>; Wed, 15 Jan 2025 16:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EB33A4E93
	for <lists+linux-can@lfdr.de>; Wed, 15 Jan 2025 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8DC14A605;
	Wed, 15 Jan 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c497UoBH"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98899148314
	for <linux-can@vger.kernel.org>; Wed, 15 Jan 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954474; cv=none; b=mXd7F018YKeVZKJoQPALUnKrktTH/ueBpX3gONn65aYcuADmgc0hoDUYXqYA6EmEfrqud/fGAsBS1J01Zj+KKPYc+SyER9ZYYAiOLpUq1ZHEDcJQHI+2By5uIgsDcC+AluqnN+T45ibPd/4qApaYg/md8BwOdKF8If2e6tMEEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954474; c=relaxed/simple;
	bh=5wPvvUq/x9kgpc4GGn2LiVZEzRFSRw9iFKhu+Wm0oyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QClBM12Kd0JzMyovxNgpzsa+9dwtYJwn3CSMB+Dkq+Z80AuEvA/JpZuv7fe6ltnMpRVM5bQ1fvdqck/yvfx6D4ojbA+WOAbe5padO5cGet0NOyYcVTOPhmQksYrz7XDJDzdRzD3nJ3owQ6HRCwoj23U8kLTbp9Cmcsq1SldAOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c497UoBH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436345cc17bso49462575e9.0
        for <linux-can@vger.kernel.org>; Wed, 15 Jan 2025 07:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736954469; x=1737559269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D6d6cbijVVsswPWM9ajYYbU15Oi8pP8MiBG3v+Lz77g=;
        b=c497UoBHmUWJ7ugeAIX/aoWlLtaSOuypiRGcz6veUQ5z71xZ6Ti7J9B++i7kqctmzs
         rr4u65V40jZBcSadDggEWIrJDddBDJiU2TzWoNrKgoDuLquatzmOK81XFNXxknEq2VtD
         8t2oUYOEQBoMWMS1w+F+QNMxcyKZ18fYXo9qHAjR5980FP9d3fYYOeDdUftTDpwC1Rja
         qZYThq9WvpwqNopJDAoSGdLmnsUHOlm1BUJYRvVvLHN0cP/9b5YJTs0O65NlDhax9R0y
         3c2hh0wFQsfCLfrxV5PuFmzUcJffXE6+LHAAXlB3Usi3y3gr1LgUev5ciAt9EP6SStuN
         5Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736954469; x=1737559269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6d6cbijVVsswPWM9ajYYbU15Oi8pP8MiBG3v+Lz77g=;
        b=RlG9MoOuY0UQbGYpuPxdRgdBLb0UNJAF2i5CVQZhi4R5+dJUz9mJ4q8TV+pRuA6fX5
         fXe5mr3BhOL0e1n9R1eTRaC2hJbnaPSqHlRG2Nod0YlqgceE2hKHZEzHZ/oGx/TtBP5q
         OwLrQV53T4JOhYzmF4A96SaRjVcfTy3zqrEuacRk5rQnaQlA+mgLiFX+ghJfut65w+Xq
         GA2ES8dxLX92eaed0u0VMPxJx+mvJ91YMKmDeNZwEfLGjnniWzDepslHxOPPcGmAGQqG
         6pNgtDqRcnyy8JiT8phiSWxPzyUUomqBK3E7ZcTTVXbyYR4Ea+xoX/jDOy844aGK85oU
         YdWA==
X-Forwarded-Encrypted: i=1; AJvYcCVWAmLK2belQjQomD9Bn1Lg57QX1/UDARZx/YuCOQywqM+HZMDP5CndUJDWnYDcwTBGFXh/vIUR6Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40rNnJtAasd8o/MIVTFayyW/xLHSCIBlT7GS0K/yQCRtW8pYd
	S9FbThhH4oWxmyhzowHOfQ3fp+MsP8b5DmzI9IS/OM6QY3z4qyeSbJgVHeIwx5E=
X-Gm-Gg: ASbGnctOO3myXaFVWqJbHiID989Vw9GMEU4Dto7Zid0LBv5vKcD2OCi6fZRW/lZAA+K
	2+TyyPKjaPpyKhMvS9MkvSlkVdziDg7dr6zfMpnay1sZzSFHB4s5phRPTd4XvEafIznYkWx8f2F
	W5SfzjynetDnBH18MklTQKBlrCz8Tdb2loLtfnhjER4O5zi6yKEWIorBtJYj6ybsfpdvXTzatmL
	2ai4PsGnKAQIL4HPgpVHU91zzOcb9ksAvVrjR6jJmkx2MEdAju4
X-Google-Smtp-Source: AGHT+IGlbUxFkjRuwHKpATFcORxqk4Qsb95Bw4NhBed4Z7WxJajRniih79OSFO/FUjWO+nRNLCPRCg==
X-Received: by 2002:a05:600c:3543:b0:434:f767:68ea with SMTP id 5b1f17b1804b1-436e2677c7dmr301082325e9.5.1736954468846;
        Wed, 15 Jan 2025 07:21:08 -0800 (PST)
Received: from localhost ([2001:4090:a245:80cb:3b5a:db2d:b2b7:c8b4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c749989asm27537515e9.2.2025.01.15.07.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 07:21:08 -0800 (PST)
Date: Wed, 15 Jan 2025 16:21:07 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: "Mohan, Subramanian" <subramanian.mohan@intel.com>
Cc: "rcsekar@samsung.com" <rcsekar@samsung.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"balbi@kernel.org" <balbi@kernel.org>, "Tan, Raymond" <raymond.tan@intel.com>, 
	"jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux@ew.tq-group.com" <linux@ew.tq-group.com>, "lst@pengutronix.de" <lst@pengutronix.de>, 
	"Hahn, Matthias" <matthias.hahn@intel.com>, "Chinnadurai, Srinivasan" <srinivasan.chinnadurai@intel.com>
Subject: Re: [PATCH 1/1] can: m_can: Control tx flow to avoid message stuck
Message-ID: <nqsrgqln3g42wobectykxqztrb2uv2tdjyzvrfd6oq4olrfiew@oqoupeg4ogas>
References: <20250108090112.58412-1-subramanian.mohan@intel.com>
 <fzbw7i5wrpngg4ycapbo2g4b6d7ecykj4an3flcrxgwrp5t6cr@ogqcnsnvlwi2>
 <PH7PR11MB58625A0D029BB135A9F506C8F71F2@PH7PR11MB5862.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xw3kz3tidjt3aln5"
Content-Disposition: inline
In-Reply-To: <PH7PR11MB58625A0D029BB135A9F506C8F71F2@PH7PR11MB5862.namprd11.prod.outlook.com>


--xw3kz3tidjt3aln5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] can: m_can: Control tx flow to avoid message stuck
MIME-Version: 1.0

On Mon, Jan 13, 2025 at 03:58:09PM +0000, Mohan, Subramanian wrote:
> Hi @Markus Schneider-Pargmann,
>=20
> > -----Original Message-----
> > From: Markus Schneider-Pargmann <msp@baylibre.com>
> > Sent: Thursday, January 9, 2025 9:14 PM
> > To: Mohan, Subramanian <subramanian.mohan@intel.com>
> > Cc: rcsekar@samsung.com; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; balbi@kernel.org; Tan, Raymond
> > <raymond.tan@intel.com>; jarkko.nikula@linux.intel.com; linux-
> > can@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.o=
rg;
> > linux@ew.tq-group.com; lst@pengutronix.de; Hahn, Matthias
> > <matthias.hahn@intel.com>; Chinnadurai, Srinivasan
> > <srinivasan.chinnadurai@intel.com>
> > Subject: Re: [PATCH 1/1] can: m_can: Control tx flow to avoid message s=
tuck
> >
> > Hi,
> >
> > On Wed, Jan 08, 2025 at 02:31:12PM +0530,
> > subramanian.mohan@intel.com wrote:
> > > From: Subramanian Mohan <subramanian.mohan@intel.com>
> > >
> > > The prolonged testing of passing can messages between two Elkhartlake
> > > platforms resulted in message stuck i.e Message did not receive at
> > > receiver side
> >
> > Can you please describe the reason for the stuck messages in your commit
> > message? I am reading this but I don't understand why this happens or w=
hy
> > your proposed solution helps.
>=20
> Let me describe problem bit more:
> We are using 2 different Python Scripts(client and server) on both of the=
 Elkhart lake connected systems.
> The "server" script sends out messages with Arbitration ID's, and then wa=
its for a response. If the Arbitration ID is different than the
> one expected or no message arrives it logs an error.
> The "client" script listens for messages, and depending on the Arbitratio=
n ID received it sends a message with a specific Arbitration ID back.
> We have deployed both the scripts in 2 different systems and triggered th=
e testing
> If any message is lost/stuck then the "server" - Script will log an error.
> The Message stuck corresponds over here, whenever the server sends out me=
ssage and waits for reply, we wont me getting the reply message
> On the server side. Even though time slice increase in scripts did not he=
lp. On further debugging enabling TX/TEFN impacts the processing load.
> To overcome this we disabled the TX/TEFN interrupt once processed and ena=
ble it back in the TX start xmit function.

Sorry, I still don't understand what is happening in the driver/hardware
that requires the interrupt to be disabled and enabled again later. Is
it causing interrupt_handler runs that are not associated with a real
interrupt? Is it causing real interrupts without anything being sent?
Does the clearing of the interrupts not work?

>=20
> >
> > >
> > > Contolling TX i.e TEFN bit helped to resolve the message stuck issue.
> > >
> > > The current solution is enhanced/optimized from the below patch:
> > > https://lore.kernel.org/lkml/20230623051124.64132-1-kumari.pallavi@int
> > > el.com/T/
> > >
> > > Setup used to reproduce the issue:
> > >
> > > +---------------------+         +----------------------+
> > > |Intel ElkhartLake    |         |Intel ElkhartLake     |
> > > |       +--------+    |         |       +--------+     |
> > > |       |m_can 0 |    |<=3D=3D=3D=3D=3D=3D=3D>|       |m_can 0 |     |
> > > |       +--------+    |         |       +--------+     |
> > > +---------------------+         +----------------------+
> > >
> > > Steps to be run on the two Elkhartlake HW:
> > > 1)Bus-Rate is 1 MBit/s
> > > 2)Busload during the test is about 40% 3)we initialize the CAN with
> > > following commands 4)ip link set can0 txqueuelen 100/1024/2048 5)ip
> > > link set can0 up type can bitrate 1000000
> > >
> > > Python scripts are used send and receive the can messages between the
> > > EHL systems.
> > >
> > > Signed-off-by: Hahn Matthias <matthias.hahn@intel.com>
> > > Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
> > > ---
> > >  drivers/net/can/m_can/m_can.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/can/m_can/m_can.c
> > > b/drivers/net/can/m_can/m_can.c index 97cd8bbf2e32..0a2c9a622842
> > > 100644
> > > --- a/drivers/net/can/m_can/m_can.c
> > > +++ b/drivers/net/can/m_can/m_can.c
> > > @@ -1220,7 +1220,7 @@ static void m_can_coalescing_update(struct
> > > m_can_classdev *cdev, u32 ir)  static int
> > > m_can_interrupt_handler(struct m_can_classdev *cdev)  {
> > >      struct net_device *dev =3D cdev->net;
> > > -   u32 ir =3D 0, ir_read;
> > > +   u32 ir =3D 0, ir_read, new_interrupts;
> > >      int ret;
> > >
> > >      if (pm_runtime_suspended(cdev->dev)) @@ -1283,6 +1283,9 @@
> > static
> > > int m_can_interrupt_handler(struct m_can_classdev *cdev)
> > >                      ret =3D m_can_echo_tx_event(dev);
> > >                      if (ret !=3D 0)
> > >                              return ret;
> > > +
> > > +                   new_interrupts =3D cdev->active_interrupts &
> > ~(IR_TEFN);
> > > +                   m_can_interrupt_enable(cdev, new_interrupts);
> >
> > Here is a theoretical situation of two messages being sent. The first i=
s being
> > sent and handled in this interrupt handler. Then it would disable the T=
EFN bit
> > right? If the second message wasn't done sending yet, how would it ever=
 call
> > the interrupt handler if the interrupt is disabled?
>=20
> With this patch we are controlling only TEFN/TX interrupt bit, rest of th=
e interrupts remains unaffected.
> Since We are enabling/disabling TEFN bit only, interrupt handler will be =
called normally with other interrupts.

I am worried about the next TEFN interrupt here. I am currently not
sure, can the mcan driver for non-peripheral setups have multiple
messages being sent at the same time? If that is possible then what
happens to the other messages that are in flight when you disable TEFN?

Best
Markus

>=20
> >
> > Also you are disabling this interrupt here regardless of the type of mc=
an device
> > and also regardless of the coalescing state. In the transmit part you a=
re only
> > enabling it for non-peripheral devices. For peripheral mcan devices thi=
s would
> > also introduce an additional two transfers per transmit.
>=20
> TEFN bit enabling/disabling applies only to non-peripheral device.
> While disabling the TEFN bit in interrupt handler, we will add the check =
for non-peripheral device before disabling it(V2).
> On the coalescing state, The snapshot is already taken while entering the=
 interrupt handler.
>=20
> >
> > In which situations is this really necessary? Does it help to implement
> > coalescing for non-peripheral devices?
> This helps in heavy load/traffic conditions
> Not exactly sure on the coalescing part.
>=20
> Thanks,
> Subbu
>=20
> >
> > Best
> > Markus
> >
> > >              }
> > >      }
> > >
> > > @@ -1989,6 +1992,7 @@ static netdev_tx_t m_can_start_xmit(struct
> > sk_buff *skb,
> > >      struct m_can_classdev *cdev =3D netdev_priv(dev);
> > >      unsigned int frame_len;
> > >      netdev_tx_t ret;
> > > +   u32 new_interrupts;
> > >
> > >      if (can_dev_dropped_skb(dev, skb))
> > >              return NETDEV_TX_OK;
> > > @@ -2008,8 +2012,11 @@ static netdev_tx_t m_can_start_xmit(struct
> > > sk_buff *skb,
> > >
> > >      if (cdev->is_peripheral)
> > >              ret =3D m_can_start_peripheral_xmit(cdev, skb);
> > > -   else
> > > +   else {
> > > +           new_interrupts =3D cdev->active_interrupts | IR_TEFN;
> > > +           m_can_interrupt_enable(cdev, new_interrupts);
> > >              ret =3D m_can_tx_handler(cdev, skb);
> > > +   }
> > >
> > >      if (ret !=3D NETDEV_TX_OK)
> > >              netdev_completed_queue(dev, 1, frame_len);
> > > --
> > > 2.35.3
> > >

--xw3kz3tidjt3aln5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZ4fSXQAKCRAkjLTi1BWu
PwetAQCuUoiYhfNF9/bfULu30MYHVgT1AtVuHWIw27yr81sGsAEAxY5Dc4FAMNQ8
KuxtTwp+eUtLI/XH+RYBorOg2QWE/gM=
=iO6I
-----END PGP SIGNATURE-----

--xw3kz3tidjt3aln5--

