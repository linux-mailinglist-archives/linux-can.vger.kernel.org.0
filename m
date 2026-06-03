Return-Path: <linux-can+bounces-7749-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QYzsAqQDIGpGuAAAu9opvQ
	(envelope-from <linux-can+bounces-7749-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 12:36:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A1636A4B
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 12:36:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gAs9Y5bs;
	dkim=pass header.d=redhat.com header.s=google header.b=IgT3RnqK;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7749-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7749-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9024301952B
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B88384248;
	Wed,  3 Jun 2026 10:28:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87C3AFCEA
	for <linux-can@vger.kernel.org>; Wed,  3 Jun 2026 10:28:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482526; cv=pass; b=ggrL4OtyFV6mqUzY+fGd4+v/8N5u4n0yt01te5dbBHpiFeR8CQtkAC1Fvrk2wUjVROtKyf+04R+wgnCn6VQSyKZy2z/DSkManzusIPX+GBef+y/DlNh9MgmQju+Q3ftRI6+dKR6mP2Wj9r0SfJjF35QefMxNcfl85RR+SsKYDD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482526; c=relaxed/simple;
	bh=1KMiOis/bLdEHRWDkIcCxP1fVnp/dYeFCQreZ5iyUms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDdnKvx1FPeml05T8vBPWmy19EmU+xBBYH2Bz4BFrND5Yiev2mOIgY2OhNA1eV4JOzXcs462N5Sqmv7+JnwKuI1xh0kdsz1ZT+pgEouR0ypBJPK9nof6fOzwIk0LiRP73sIgL+FCsFAFl3Sm+m0pjbx3Mxh1A1blx2szyBNvSiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAs9Y5bs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgT3RnqK; arc=pass smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780482524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVdTuQdmZHYEnxjt/VTYFuuNhfhMD/0cQDhgpbVYh54=;
	b=gAs9Y5bsEt0xaUQLdWsRyuuRiLBgqJPQrFgDr4ZFMF3NfxZvB6PGHq552TWHDLu2qaEvJI
	FbkygedretKZQZnZm0nMPrkVcueYggSQZnlpxkZdPAbCKeK25HTmv5MEnRjkh+qLJo+lnI
	zhjkVXRdWesa8SIU73UeWaf1n5461B4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-P5awS04ZMZijsaQJWkRnsg-1; Wed, 03 Jun 2026 06:28:42 -0400
X-MC-Unique: P5awS04ZMZijsaQJWkRnsg-1
X-Mimecast-MFC-AGG-ID: P5awS04ZMZijsaQJWkRnsg_1780482521
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-396698bb73fso3728771fa.1
        for <linux-can@vger.kernel.org>; Wed, 03 Jun 2026 03:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780482521; cv=none;
        d=google.com; s=arc-20240605;
        b=QGWdWdx1rhUYIPj+kngxCIecl5ihSkcCLjI+Q/6mW7jKKOE9r1fMkv2pBphldhBP5s
         8xYQD6hD4Rh3LQ4OomLSNuKVkv9pqqBFrL0/c92/t2uwaq28xf/9jGrAdWqRlTZFBhJY
         eBib90UxH4yU8ZiIS1uvl347/NspkUNiiXHcvsxv9p3o7FKyP9I1Uvflyt0WdXtrAmnl
         PJZcMOUPlp/MsQ/X9b96ygB1j7pPEp7kVqkQwMDMEzPoeNhaD5I4tBVGGkkHbqNqUts+
         QepjceyNExEULZwCzPwOv+hcTZeXIWljtxoKS2XxwBpwyGt0W9YamGMkcqozSJapQLPQ
         t8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mVdTuQdmZHYEnxjt/VTYFuuNhfhMD/0cQDhgpbVYh54=;
        fh=F808pwDCdaDy3AqpsUnQRwo5UzQoUXeABTPi5DGMSIg=;
        b=ObX/00joZpVi/Q+C74SpdGa7iL1f4sV6TDtJvrtYzKVRMCO0AJeO3iXtDEmCS3iFnt
         PlmFj6xJwSKpYn72o95+4USA4HqMzBwroF7SYfKPH7YP0blNptPTxpibcvdvVSUNqUkx
         5ndJ02wrLB/SyL4hW6Krg1GupwHmAnMYb4bqUQ4qZvwNwIFWhBgKP8dTlvUGMGrmPir1
         qdSi7DOzHzlCFXdKgwUV5JOZDTlXozIhOUBialAGzey2bMAriFfwrldQDOpy+i0HwsMS
         DQ1ZUJR1SGDe4+Tywd1e8uuO2Gim6QmB2UBEPqn240iD29lG85OvhkXYnIuoX3FrHC9F
         M/9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780482521; x=1781087321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVdTuQdmZHYEnxjt/VTYFuuNhfhMD/0cQDhgpbVYh54=;
        b=IgT3RnqKj8Z67jrHQmSxcbbF+lHtoLVoRUlKAJE75tjYIHXP5B/iiFT5mSXsvPiKDV
         uQLVmjIX3O2zEJ1zXiO3RTIiAkuUniRfY+tiq6HUcwufV6SjIdceffdUn1YLOdn6feEB
         jBK5bcgeJyW6EM95wmxLBZoKmMQDxzV0ftPC5ddmzhipdF8QEfRSKoBEBpLcxhio7off
         r1iaTMAiLNUPS/fQD+TrRDPriIAPjYF9uXx0CBnCeu4AMdkcYHbW+hRUGJz19M0doVvT
         lQJS6sb2GicUfiYtvjgOHH4UAzw5pGzglvm8mjVinN+JKIcpaMOnnk0VG8/XIpZnIj0m
         aDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780482521; x=1781087321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVdTuQdmZHYEnxjt/VTYFuuNhfhMD/0cQDhgpbVYh54=;
        b=P3uSDV6FRp9J7VkrvYPwh7zgwY5+2J1LE9f4KKysJMRFNAeaiw/zvzjWWRTJiT/rZl
         uWV86vQ7TO/7D2ScCcH9xfTgAqqG5Tkm+dm75r/l3yL49JzTNxnczJxSr0cBuspKxfk5
         s7Pwik/YmEF9CBhOjhxS4euMIqPNNv/nf+ldft3CwOvjMmdlJlqxX3GaJFqhNeTkrPM/
         vO+5KVoE2Q/aULbu+MooNIijiGMfFm80/YQKRZA+EY634XpDKEU4jnVM5xpbw6jMnmxf
         VyDnSX9PNx8YUXM9j4F1g/c7gjL4WcOfo66GZFQsL5IdWTHqfOtGWcAPr3u2Z9QM/Dl5
         pE5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/6JUcF7MnTskSqrcFnjHwIsIkX0ZDE/rA3n5V9ExO66A4Tk/mdsedIy44zvhpuVe1iC2/E+kPbFqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wB0VVIuA+l9o7cVxDXvbIAyjeUB02NGXFO29pUhXYjBPdE/k
	birqcWBBBCkFT4JtOfhlYlGi7shKtxUCTAV9FlGJL312nknW70u8LOlpcaqo/tajlC5rXNWqYaf
	4e/4fTK6cAjVmo95eOdtvO4nRMWawhsHwuTt8xCU0BvHjUgRASodxwhLW7psNDoloYH/azrMsw4
	4mwfoBOuwBfbji8B6JzyRZ7RQKjj86VC4KsYBL
X-Gm-Gg: Acq92OEHIhgdKE0cH3XbaIu9p0ym2PjxUnjHXKLkKY2AFhWzKVFkUCwe2oDJKfM5Ntr
	4cIjd0lg8WhILjjjXvYS91awArK8mXzsFyDfowEM5+pTrOu6Gfjm1wcSGNgL9iZMx39LTlVOoBW
	lDTvHjUrtCYhUklDHkwcfVaFZ33ljsrNTTeZ9iayQEp9wEkHvc7PlRKvbNM2BYkc2Kqo05XaLrv
	uh7pd4ZEqQKwwHZ
X-Received: by 2002:a2e:a378:0:b0:38d:fae9:9aa2 with SMTP id 38308e7fff4ca-396ac1f98dbmr3702151fa.1.1780482521041;
        Wed, 03 Jun 2026 03:28:41 -0700 (PDT)
X-Received: by 2002:a2e:a378:0:b0:38d:fae9:9aa2 with SMTP id
 38308e7fff4ca-396ac1f98dbmr3702051fa.1.1780482520475; Wed, 03 Jun 2026
 03:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com> <20260603093941.ysev5do557hy2rui@nxp.com>
In-Reply-To: <20260603093941.ysev5do557hy2rui@nxp.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 3 Jun 2026 12:28:28 +0200
X-Gm-Features: AVHnY4K243RGdZFkCQVWXj6BAHeNzA4KK32K9WJ-HAOfKjnlZ8EVyBxG-YNveZ8
Message-ID: <CALE0LRuqZhm03QbYg-ZOJcKe0XqCLqVZ8j-4o07QuBF-OqX9BA@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 0/8] can: flexcan: Add NXP S32N79 SoC support
To: Bough Chen <haibo.chen@oss.nxp.com>
Cc: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7749-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:haibo.chen@oss.nxp.com,m:ciprianmarian.costea@oss.nxp.com,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:echanude@redhat.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[eballetb@redhat.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[oss.nxp.com,pengutronix.de,kernel.org,nxp.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eballetb@redhat.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 555A1636A4B

Hi Ciprian,

Sorry in advance for the noise, for some strange reason I didn't get
or find the cover until now, so I added my tested patch in 1. Doing it
now properly.

On Wed, Jun 3, 2026 at 11:44=E2=80=AFAM Bough Chen <haibo.chen@oss.nxp.com>=
 wrote:
>
> On Wed, Jun 03, 2026 at 09:13:34AM +0200, Ciprian Costea wrote:
> > From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> >
> > This patch series adds FlexCAN support for the NXP S32N79 SoC.
> >
> > The S32N79 is an automotive-grade processor from NXP with multiple
> > FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
> > other SoCs in the interrupt routing - it uses two separate interrupt
> > lines:
> >   - one interrupt for mailboxes 0-127
> >   - one interrupt for bus error detection and device state changes
> >
> > The CAN controllers are connected through an irqsteer interrupt
> > controller in the RCU (Resource Control Unit) domain.
> >
> > This series:
> >   1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platfor=
ms
> >   2. Adds dt-bindings documentation for S32N79 FlexCAN
> >   3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
> >      configuration
> >   4. Adds S32N79 device data and compatible string to the driver
> >   5. Adds FlexCAN device tree nodes for S32N79 SoC
> >   6. Enables FlexCAN devices on the S32N79-RDB board
> >
> > Tested on S32N79-RDB board with CAN and CAN FD communication.
>
> Tested on imx95-19x19-evk board with CAN and CAN FD communication. No iss=
ue found.
> This means this patch set do not impact the original platforms.
>
> For this patch set, feel free to add tag:
> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
>
> Regards
> Haibo Chen

Tested-by: Enric Balletbo i Serra <eballetb@.redhat.com>

Tested on the NXP S32G399A-RDB3 with loopback and high-rate traffic.
No regressions observed:
  CAN frames transmit and receive correctly, with no duplicates.
  Frame reception showed no errors during stress testing.

Regards,
  Enric Balletbo

> >
> > This is a resend of v4 with no changes.
> >
> > v4 -> v3
> > - flexcan_chip_interrupts_enable(): disable/enable all IRQ lines
> >   (not just dev->irq) during IMASK register writes
> > - Split rx/tx masks per mailbox IRQ line (struct flexcan_mb_irq) so
> >   each handler on S32G2 only processes its own MB range
> > - Added received Acked-by tag on DT bindings patch
> >
> > v3 -> v2
> > - Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
> >   flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
> >   processing when multiple IRQ lines run concurrently (new patch).
> > - Added flexcan_irq_esr() handler composing state + berr for S32N79
> > - Ordered quirks used by s32n devtype data by value.
> >
> > v2 -> v1
> > - Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
> > describe the actual hardware feature
> > - Appended new quirk at the end
> > - Switched from platform_get_irq to platform_get_irq_byname usage
> > - Updated interrupt description in dt-bindings
> >
> > Ciprian Marian Costea (8):
> >   can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
> >   can: flexcan: disable all IRQ lines in
> >     flexcan_chip_interrupts_enable()
> >   can: flexcan: split rx/tx masks per mailbox IRQ line
> >   dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
> >   can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
> >   can: flexcan: add NXP S32N79 SoC support
> >   arm64: dts: s32n79: add FlexCAN nodes
> >   arm64: dts: s32n79: enable FlexCAN devices
> >
> >  .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
> >  arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  12 +
> >  arch/arm64/boot/dts/freescale/s32n79.dtsi     |  50 ++++
> >  drivers/net/can/flexcan/flexcan-core.c        | 249 +++++++++++++++---
> >  drivers/net/can/flexcan/flexcan.h             |  12 +-
> >  5 files changed, 316 insertions(+), 37 deletions(-)
> >
> > --
> > 2.43.0
> >
>


