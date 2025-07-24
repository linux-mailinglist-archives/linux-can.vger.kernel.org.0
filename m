Return-Path: <linux-can+bounces-4096-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4C6B1023B
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5CD188C5DB
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675726C3AE;
	Thu, 24 Jul 2025 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="DDtBefKX"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4E2A1BB
	for <linux-can@vger.kernel.org>; Thu, 24 Jul 2025 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343341; cv=none; b=t3K1TNRfDhmhOcd1agIycd8axivZ4yhKjPQKDwcBhQNqukFFOoDu6vGSAULfRxj5V4bZFqillylKJWTR3RpnWhRrnAH/cfraJBJiSNelZhnsBJJ9n46gvZcBulIAJjeRuNX2raC9vAnkuJYsiGCcLKQfjtQhAUKv6m5RUvEfIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343341; c=relaxed/simple;
	bh=nBovr0VDVwcE7jmqNBREv6D6bw7QfnSRhRauShgTPms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s75pdxHaF7atAua5smH/2Xg+Y7DaC4csX/DXhSxruafuZeE6Y/Z17kz1Hj4DUlP13ZhESwFDr/+5Y0tJOkGPpLR1KKfBe8r3aoWHQMDFbQApb0E9lSRgZEGyobAMrbefiEa38OP8qyr1lGnUPqWW3bGmg77+8QrFqPH7ukocb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=DDtBefKX; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by smtp.orange.fr with ESMTPA
	id eqhCu6vHbZLLzeqhCujTSH; Thu, 24 Jul 2025 09:48:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753343334;
	bh=JmnPmULfhUeV0g6XHu9Giez+PojRrPTOkR+lG4tkqvs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=DDtBefKXR4Otvnt2XmRmeKnSyAK+Y584I45PhEfFM1Kg3qKSY7kC6RckWGjltjw0k
	 KxwwpVy48f0dtG/Q6Cl3+t5Juxfq2bjh7eNhjjd1NbK39C1Q9OcP5nSFCPrsNOraAL
	 JBMl2AT2ZaQHYST+pTm2UlVuTThYReHWFZ+OpgAw+OM307tP1XBpJ/IfQH+EKsrwDa
	 XbGOHLWDNbErDKZIRya+P+Dd0U6t6YULN1BEhdFyyybQAuoDbHnsMcgC9axJRKo+/V
	 Ghf470uyd22LUZ0IpPTCsqoG3H1ynYXtJjn9LE9KPWpEzsRTerbU+NaR5TfhJS1Dwk
	 mXf30rGYQvATQ==
X-ME-Helo: mail-ed1-f47.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Jul 2025 09:48:54 +0200
X-ME-IP: 209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so1271265a12.2
        for <linux-can@vger.kernel.org>; Thu, 24 Jul 2025 00:48:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQI9uSmlTLSrfYhAUgptbMLn0jja6ALN6kS81I4lvnD5HkwRKP4VTKjBEIKs+7i6GeRgOKoWiNqYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tyyrjI2g6YOw0cpX7FaI+ldAVSM/OqXwJ1PegNIdzGTZMP5y
	WoX42jJQC+oDlan8V2dfXVGgwIsCVgpf2ynfyIE/SVuzXTxSdTz+Xg0kXDotNq1mLUvUdLNuuEe
	Lte3uBB2zZgS+9QKW9fI8PQ5LRYWUDZ0=
X-Google-Smtp-Source: AGHT+IG5QM8ghVCJteRdq6GC7P6RM3/zd8peEcWML8kF4jLwE1iDjv7Y7tHUAJCwtl/6Amp6w0HDIiQVMfkzgk9kBd8=
X-Received: by 2002:a17:906:b318:b0:af3:7645:43e1 with SMTP id
 a640c23a62f3a-af376454466mr391486366b.17.1753343333946; Thu, 24 Jul 2025
 00:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723083236.9-1-extja@kvaser.com> <20250723083236.9-6-extja@kvaser.com>
 <64db0624-d267-4ec5-ba2e-fdff0023fb21@wanadoo.fr> <a5a32ee9-3bfd-4f47-8438-8748957b0eef@gmail.com>
In-Reply-To: <a5a32ee9-3bfd-4f47-8438-8748957b0eef@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 24 Jul 2025 16:48:43 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJWpxLmdHRQDUFPyO2UBiHt1chZ=86GCcLbiKz1RPo+Dg@mail.gmail.com>
X-Gm-Features: Ac12FXwBOot8S9N_sqTz4LHHVSVQi3vMI-2-f0eED9bLecg94Fq_h-3ueMjXbVM
Message-ID: <CAMZ6RqJWpxLmdHRQDUFPyO2UBiHt1chZ=86GCcLbiKz1RPo+Dg@mail.gmail.com>
Subject: Re: [PATCH 5/9] can: kvaser_pciefd: Store device channel index
To: Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu. 24 Jul. 2025 at 16:05, Jimmy Assarsson <jimmyassarsson@gmail.com> w=
rote:
> On 7/23/25 2:27 PM, Vincent Mailhol wrote:
> > On 23/07/2025 at 17:32, Jimmy Assarsson wrote:
> >> Store device channel index in netdev.dev_id.
> >>
> >> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> >> ---
> >>   drivers/net/can/kvaser_pciefd.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_=
pciefd.c
> >> index eba19819ca43..7feece6d1d41 100644
> >> --- a/drivers/net/can/kvaser_pciefd.c
> >> +++ b/drivers/net/can/kvaser_pciefd.c
> >> @@ -1030,6 +1030,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct =
kvaser_pciefd *pcie)
> >>              can->completed_tx_bytes =3D 0;
> >>              can->bec.txerr =3D 0;
> >>              can->bec.rxerr =3D 0;
> >> +            can->can.dev->dev_id =3D i;
> >
> > Isn't dev_port a better fit here?
> >
> > See the description here:
> >
> >    https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-net
> >
> >    What:              /sys/class/net/<iface>/dev_id
> >    Date:              April 2008
> >    KernelVersion:     2.6.26
> >    Contact:   netdev@vger.kernel.org
> >    Description:
> >               Indicates the device unique identifier. Format is an hexa=
decimal
> >               value. This is used to disambiguate interfaces which migh=
t be
> >               stacked (e.g: VLAN interfaces) but still have the same MA=
C
> >               address as their parent device.
> >
> >    What:              /sys/class/net/<iface>/dev_port
> >    Date:              February 2014
> >    KernelVersion:     3.15
> >    Contact:   netdev@vger.kernel.org
> >    Description:
> >               Indicates the port number of this network device, formatt=
ed
> >               as a decimal value. Some NICs have multiple independent p=
orts
> >               on the same PCI bus, device and function. This attribute =
allows
> >               userspace to distinguish the respective interfaces.
> >
> >               Note: some device drivers started to use 'dev_id' for thi=
s
> >               purpose since long before 3.15 and have not adopted the n=
ew
> >               attribute ever since. To query the port number, some tool=
s look
> >               exclusively at 'dev_port', while others only consult 'dev=
_id'.
> >               If a network device has multiple client adapter ports as
> >               described in the previous paragraph and does not set this
> >               attribute to its port number, it's a kernel bug.
> >
>
> Yes, dev_port is what we want. I looked at kvaser_usb, where dev_id is us=
ed.
>
> > Also, not populating dev_port is a kernel bug, meaning that you should =
probably
> > add a fix tag.
>
> Looks like there are more SocketCAN drivers using dev_id instead of dev_p=
ort:
>    $ grep -r 'dev_id =3D'
>    rockchip/rockchip_canfd-core.c:      dev_id =3D rkcanfd_read(priv, RKC=
ANFD_REG_RTL_VERSION);
>    peak_canfd/peak_canfd.c:     ndev->dev_id =3D index;
>    softing/softing_main.c:              netdev->dev_id =3D j;
>    usb/gs_usb.c:        netdev->dev_id =3D channel;
>    usb/peak_usb/pcan_usb_core.c:        netdev->dev_id =3D ctrl_idx;
>    usb/esd_usb.c:       netdev->dev_id =3D index;
>    usb/kvaser_usb/kvaser_usb_core.c:    netdev->dev_id =3D channel;
>    sja1000/f81601.c:            dev->dev_id =3D i;
>    sja1000/ems_pcmcia.c:                dev->dev_id =3D i;
>    sja1000/kvaser_pci.c:        dev->dev_id =3D channel;
>    sja1000/plx_pci.c:                   dev->dev_id =3D i;
>    sja1000/peak_pcmcia.c:               netdev->dev_id =3D i;
>    sja1000/sja1000_isa.c:       dev->dev_id =3D idx;
>    sja1000/peak_pci.c:          dev->dev_id =3D i;
>    sja1000/ems_pci.c:                   dev->dev_id =3D i;
>    spi/mcp251xfd/mcp251xfd-core.c:      *dev_id =3D get_unaligned_le32(bu=
f_rx->data);

Thanks for checking. I=E2=80=AFguess those will need a fix.

There are also some additional multi-channel devices which set none of
dev_id nor dev_port which and which thus do not appear in your list.

> I'll also assign dev_port in kvaser_usb, but keep the assignment of dev_i=
d
> to avoid potential regressions.
>
> Or do you got other suggestions?

No, I=E2=80=AFagree with your approach: for anything new, only use the
dev_port. For anything old, keep the dev_id to avoid regression but
add dev_port for compliance.


Yours sincerely,
Vincennt Mailhol

