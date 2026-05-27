Return-Path: <linux-can+bounces-7713-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHKMCNkVF2px3wcAu9opvQ
	(envelope-from <linux-can+bounces-7713-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 18:03:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0F25E7671
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4059A30EA45F
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B07380FCF;
	Wed, 27 May 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="DE0Q7D1H"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0133815D4
	for <linux-can@vger.kernel.org>; Wed, 27 May 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897309; cv=none; b=tB1E7hvYg6BTf5zXkkuYN3G8nY7xW/z9O1F1RVVSVqsUHW5ksfsclZVM8kIzfstTaur5Sjx9OP2xvJih2CeoneLk5MEuhB99ikAqjYaA7MoEcLWr4059iPClmhnvUPGAtultSEpMk9AjeayjujiB28m0pBVcviiQ3r30Se9/hsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897309; c=relaxed/simple;
	bh=powOeTcFP5ppUnWEZ2uLnIVDnl0rqlDwjWu8L9YQxNk=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=VK+pOV9KS3gmt6wbW6/4EiGaAEwZtCjW25U4vGJ1vdBPKJo+VjrkItweuzJ+Ax8zgbiT/kbtPAV+gtxNJeCpdfWccHS3X9ki1ei/yGoky91BjYBdkIpcGOZPGX5JeEXBqSnjFm+JgrNSfTivf6cH3jdMtKLD56MaURLcX3/Ocrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=DE0Q7D1H; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 84734F064;
	Wed, 27 May 2026 17:45:02 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id 7QT77C1oMh4u; Wed, 27 May 2026 17:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1779896303;
	bh=fE19YoDJr0H3xkso9GICPamHx1IFHU/eRXXo7yQyeG8=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=DE0Q7D1HmyVVRjkTuHEHaBjnM3/9iQWP8/4xCywJYzTHI+tZuIE9UPRTI+thjl1eh
	 s+Ah2HX0D4GseNIEnv7WAY4SM8Eqd24C9JXuDlk/We2CEgbk76zjOsDD9znUgZKo+x
	 91NBy4sg3g3mbACRLL+r4uHL0X42ZdnULgJ+Hd4Rdw6pfCBEgl516a0erZrwKJjv3d
	 miDfOZRv/B/IHWj7xvgLZxAtzAiY5jHlhTd4O0JgBJJgltZ1hMWtz1eouVWtgMw4B1
	 dJE8duKqMWRxUu3elyLVUiCQ9Jt/moRszvtTMDSiUz7LJ2RZQaxTUe8NE9Ahle3PnA
	 PPh1c0exvklxw==
Received: from [147.32.86.192] (unknown [147.32.86.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id A2A1BF387;
	Wed, 27 May 2026 17:38:22 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: [PATCH v3 0/7] hw/arm/sabrelite: Add FlexCAN support
Date: Wed, 27 May 2026 17:38:21 +0200
User-Agent: KMail/1.9.10
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?utf-8?q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 Matyas Bobek <bobekmat@fel.cvut.cz>,
 qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 linux-can@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Andrey Volkov <andrey.volkov@munic.io>
References: <cover.1777571962.git.matyas.bobek@gmail.com> <CAFEAcA95RcGhhN8ZqVeOgRyhRqSar23EnJhCjVgKBwoqXBJwjw@mail.gmail.com> <08A7BC6B-7019-45C4-B581-0A26AD3AA554@gmail.com>
In-Reply-To: <08A7BC6B-7019-45C4-B581-0A26AD3AA554@gmail.com>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202605271738.21722.pisa@fel.cvut.cz>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fel.cvut.cz,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fel.cvut.cz:s=felmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,fel.cvut.cz,nongnu.org,hartkopp.net,redhat.com,linaro.org,vger.kernel.org,pengutronix.de,munic.io];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-7713-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pisa@fel.cvut.cz,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[fel.cvut.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:email,linaro.org:email,varma-el.com:email,fel.cvut.cz:mid,fel.cvut.cz:dkim]
X-Rspamd-Queue-Id: 7C0F25E7671
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Marc,

please, provide your opinion, the license for small Linux kernel
headers excepts seems to be the last and only blocker for mainlining.
See the copied code below.

On Wednesday 27 of May 2026 12:42:23 Bernhard Beschow wrote:
> Am 8. Mai 2026 12:10:21 UTC schrieb Peter Maydell <peter.maydell@linaro.o=
rg>:
> >On Tue, 5 May 2026 at 21:21, Bernhard Beschow <shentey@gmail.com> wrote:
> >> Am 5. Mai 2026 18:41:52 UTC schrieb Peter Maydell <peter.maydell@linar=
o.org>:
> >> >On Tue, 5 May 2026 at 19:03, Bernhard Beschow <shentey@gmail.com> wro=
te:
> >> >> I guess the only open issue is the licensing of struct FlexcanRegs
> >> >> [1] which originates from Linux? How do we proceed here?
> >> >>
> >> >> Best regards,
> >> >> Bernhard
> >> >>
> >> >> [1]
> >> >> https://lore.kernel.org/qemu-devel/202603211316.18181.pisa@fel.cvut=
=2Ec
> >> >>z/
> >> >
> >> >Could you say what the problem is? In general there is no problem
> >> >with taking header structs from the Linux kernel, as they are
> >> >GPL-2-only and that is a QEMU-compatible license. The relevant
> >> >source files or pieces of source files would need to be noted
> >> >as 2-only rather than our default of 2-or-later, but that is
> >> >doable -- we already do that for other things we have borrowed
> >> >from the kernel.
> >>
> >> In
> >> https://lore.kernel.org/qemu-devel/f3cb3166-c3f8-4ed8-8c9a-cbf48b071d1=
e@
> >>gmail.com/ I raised this review question: "The following structure looks
> >> like being based on Linux. Does this affect the copyright of this file=
?"
> >> I was just asking for advice and I'm glad the solution is that easy.
> >
> >If the struct was copied from the kernel, then it's GPL-2.0-only,
> >and we should just note the license and where we got the code from.
> >
> >If the struct is just very similar to the kernel's one because
> >it's the obvious representation taken from the datasheet, then
> >it's not related to the kernel code and we can treat it as
> >GPL-2.0-or-later like the rest of the file.
> >
> >Since Maty=C3=A1=C5=A1 says in the cover letter here "the headers (struct
> >FlexcanRegs and flexcan_regs.h macros) were copied from the Linux
> >kernel" then we're in case 1.
> >
> >You can mark this up by having the file's SPDX tag be
> >"SPDX-License-Identifier: (GPL-2.0-only AND GPL-2.0-or-later)"
> >Then have a normal comment in the file next to the part that is
> >2.0-only that says
> >/*
> > * [This struct / the macros X, Y, Z / whatever ] are borrowed
> > * from the Linux kernel, and so (unlike the rest of this file)
> > * they are GPL-2.0-only.
> > */
>
> Ping
>
> Any news? With just the license issue remaining, it would be nice to get
> FlexCAN support into the upcoming release.

The problem is that QEMU maintainers decided to prefer GPL-2.0-or-later
as the rule for new contributions and Matyas Bobek has reused
next excepts from Linux kernel sources

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/can/flexcan/flexcan-core.c

which have license

// SPDX-License-Identifier: GPL-2.0
//
// flexcan.c - FLEXCAN CAN controller driver
//
// Copyright (c) 2005-2006 Varma Electronics Oy
// Copyright (c) 2009 Sascha Hauer, Pengutronix
// Copyright (c) 2010-2017 Pengutronix, Marc Kleine-Budde <kernel@pengutron=
ix.de>
// Copyright (c) 2014 David Jander, Protonic Holland
//
// Based on code originally by Andrey Volkov <avolkov@varma-el.com>


I think, personally, that the code excepts are on the edge
of the rules for copyright applications because the lines are direct
transformation of the offests and bit-fields found in the original
=46reeScale/NXP manuals so there should be no problem to use them for
QEMU and revwite from scratch for copyright clarity with a little
different naming rules would make only more mess for future updates
to FexCAN 3 etc.

Thanaks in advance

Pavel

hw/net/can/flexcan_regs.h

+/**
+ * These macros ware originally written for the Linux kernel
+ * by Marc Kleine-Budde.
+ */
+
+/* FLEXCAN module configuration register (CANMCR) bits */
+#define FLEXCAN_MCR_MDIS                BIT(31)
+#define FLEXCAN_MCR_FRZ                 BIT(30)
+#define FLEXCAN_MCR_FEN                 BIT(29)
+#define FLEXCAN_MCR_HALT                BIT(28)
+#define FLEXCAN_MCR_NOT_RDY             BIT(27)
+#define FLEXCAN_MCR_WAK_MSK             BIT(26)
+#define FLEXCAN_MCR_SOFTRST             BIT(25)
+#define FLEXCAN_MCR_FRZ_ACK             BIT(24)
+#define FLEXCAN_MCR_SUPV                BIT(23)
+#define FLEXCAN_MCR_SLF_WAK             BIT(22)
+#define FLEXCAN_MCR_WRN_EN              BIT(21)
+#define FLEXCAN_MCR_LPM_ACK             BIT(20)
+#define FLEXCAN_MCR_WAK_SRC             BIT(19)
+#define FLEXCAN_MCR_DOZE                BIT(18)
+#define FLEXCAN_MCR_SRX_DIS             BIT(17)
+#define FLEXCAN_MCR_IRMQ                BIT(16)
+#define FLEXCAN_MCR_LPRIO_EN            BIT(13)
+#define FLEXCAN_MCR_AEN                 BIT(12)
+#define FLEXCAN_MCR_FDEN                BIT(11)
+#define FLEXCAN_MCR_MAXMB(x)            ((x) & 0x7f)
+#define FLEXCAN_MCR_IDAM_A              (0x0 << 8)
+#define FLEXCAN_MCR_IDAM_B              (0x1 << 8)
+#define FLEXCAN_MCR_IDAM_C              (0x2 << 8)
+#define FLEXCAN_MCR_IDAM_D              (0x3 << 8)
+#define FLEXCAN_MCR_IDAM_MASK           (0x3 << 8)
+
+/* FLEXCAN control register (CANCTRL) bits */
+#define FLEXCAN_CTRL_PRESDIV(x)         (((x) & 0xFF) << 24)
+#define FLEXCAN_CTRL_PRESDIV_MASK       FLEXCAN_CTRL_PRESDIV(UINT32_MAX)
+#define FLEXCAN_CTRL_RJW(x)             (((x) & 0x03) << 22)
+#define FLEXCAN_CTRL_RJW_MASK           FLEXCAN_CTRL_RJW(UINT32_MAX)
+#define FLEXCAN_CTRL_PSEG1(x)           (((x) & 0x07) << 19)
+#define FLEXCAN_CTRL_PSEG1_MASK         FLEXCAN_CTRL_PSEG1(UINT32_MAX)
+#define FLEXCAN_CTRL_PSEG2(x)           (((x) & 0x07) << 16)
+#define FLEXCAN_CTRL_PSEG2_MASK         FLEXCAN_CTRL_PSEG2(UINT32_MAX)
+#define FLEXCAN_CTRL_BOFF_MSK           BIT(15)
+#define FLEXCAN_CTRL_ERR_MSK            BIT(14)
+#define FLEXCAN_CTRL_CLK_SRC            BIT(13)
+#define FLEXCAN_CTRL_LPB                BIT(12)
+#define FLEXCAN_CTRL_TWRN_MSK           BIT(11)
+#define FLEXCAN_CTRL_RWRN_MSK           BIT(10)
+#define FLEXCAN_CTRL_SMP                BIT(7)
+#define FLEXCAN_CTRL_BOFF_REC           BIT(6)
+#define FLEXCAN_CTRL_TSYN               BIT(5)
+#define FLEXCAN_CTRL_LBUF               BIT(4)
+#define FLEXCAN_CTRL_LOM                BIT(3)
+#define FLEXCAN_CTRL_PROPSEG(x)         ((x) & 0x07)
+#define FLEXCAN_CTRL_PROPSEG_MASK       FLEXCAN_CTRL_PROPSEG(UINT32_MAX)
+#define FLEXCAN_CTRL_ERR_BUS            (FLEXCAN_CTRL_ERR_MSK)
+#define FLEXCAN_CTRL_ERR_STATE \
+        (FLEXCAN_CTRL_TWRN_MSK | FLEXCAN_CTRL_RWRN_MSK | \
+         FLEXCAN_CTRL_BOFF_MSK)
+#define FLEXCAN_CTRL_ERR_ALL \
+        (FLEXCAN_CTRL_ERR_BUS | FLEXCAN_CTRL_ERR_STATE)
+
+/* FLEXCAN control register 2 (CTRL2) bits */
+#define FLEXCAN_CTRL2_ECRWRE            BIT(29)
+#define FLEXCAN_CTRL2_WRMFRZ            BIT(28)
+#define FLEXCAN_CTRL2_RFFN(x)           (((x) & 0x0f) << 24)
+#define FLEXCAN_CTRL2_TASD(x)           (((x) & 0x1f) << 19)
+#define FLEXCAN_CTRL2_MRP               BIT(18)
+#define FLEXCAN_CTRL2_RRS               BIT(17)
+#define FLEXCAN_CTRL2_EACEN             BIT(16)
+#define FLEXCAN_CTRL2_ISOCANFDEN        BIT(12)
+
+/* FLEXCAN memory error control register (MECR) bits */
+#define FLEXCAN_MECR_ECRWRDIS           BIT(31)
+#define FLEXCAN_MECR_HANCEI_MSK         BIT(19)
+#define FLEXCAN_MECR_FANCEI_MSK         BIT(18)
+#define FLEXCAN_MECR_CEI_MSK            BIT(16)
+#define FLEXCAN_MECR_HAERRIE            BIT(15)
+#define FLEXCAN_MECR_FAERRIE            BIT(14)
+#define FLEXCAN_MECR_EXTERRIE           BIT(13)
+#define FLEXCAN_MECR_RERRDIS            BIT(9)
+#define FLEXCAN_MECR_ECCDIS             BIT(8)
+#define FLEXCAN_MECR_NCEFAFRZ           BIT(7)
+
+/* FLEXCAN error and status register (ESR) bits */
+#define FLEXCAN_ESR_SYNCH               BIT(18)
+#define FLEXCAN_ESR_TWRN_INT            BIT(17)
+#define FLEXCAN_ESR_RWRN_INT            BIT(16)
+#define FLEXCAN_ESR_BIT1_ERR            BIT(15)
+#define FLEXCAN_ESR_BIT0_ERR            BIT(14)
+#define FLEXCAN_ESR_ACK_ERR             BIT(13)
+#define FLEXCAN_ESR_CRC_ERR             BIT(12)
+#define FLEXCAN_ESR_FRM_ERR             BIT(11)
+#define FLEXCAN_ESR_STF_ERR             BIT(10)
+#define FLEXCAN_ESR_TX_WRN              BIT(9)
+#define FLEXCAN_ESR_RX_WRN              BIT(8)
+#define FLEXCAN_ESR_IDLE                BIT(7)
+#define FLEXCAN_ESR_BOFF_INT            BIT(2)
+#define FLEXCAN_ESR_ERR_INT             BIT(1)
+#define FLEXCAN_ESR_WAK_INT             BIT(0)
+
+/* FLEXCAN Bit Timing register (CBT) bits */
+#define FLEXCAN_CBT_BTF                 BIT(31)
+#define FLEXCAN_CBT_EPRESDIV_MASK       FLEXCAN_GENMASK(30, 21)
+#define FLEXCAN_CBT_ERJW_MASK           FLEXCAN_GENMASK(20, 16)
+#define FLEXCAN_CBT_EPROPSEG_MASK       FLEXCAN_GENMASK(15, 10)
+#define FLEXCAN_CBT_EPSEG1_MASK         FLEXCAN_GENMASK(9, 5)
+#define FLEXCAN_CBT_EPSEG2_MASK         FLEXCAN_GENMASK(4, 0)
+
+/* FLEXCAN FD control register (FDCTRL) bits */
+#define FLEXCAN_FDCTRL_FDRATE           BIT(31)
+#define FLEXCAN_FDCTRL_MBDSR1           FLEXCAN_GENMASK(20, 19)
+#define FLEXCAN_FDCTRL_MBDSR0           FLEXCAN_GENMASK(17, 16)
+#define FLEXCAN_FDCTRL_MBDSR_8          0x0
+#define FLEXCAN_FDCTRL_MBDSR_12         0x1
+#define FLEXCAN_FDCTRL_MBDSR_32         0x2
+#define FLEXCAN_FDCTRL_MBDSR_64         0x3
+#define FLEXCAN_FDCTRL_TDCEN            BIT(15)
+#define FLEXCAN_FDCTRL_TDCFAIL          BIT(14)
+#define FLEXCAN_FDCTRL_TDCOFF           FLEXCAN_GENMASK(12, 8)
+#define FLEXCAN_FDCTRL_TDCVAL           FLEXCAN_GENMASK(5, 0)
+
+/* FLEXCAN FD Bit Timing register (FDCBT) bits */
+#define FLEXCAN_FDCBT_FPRESDIV_MASK     FLEXCAN_GENMASK(29, 20)
+#define FLEXCAN_FDCBT_FRJW_MASK         FLEXCAN_GENMASK(18, 16)
+#define FLEXCAN_FDCBT_FPROPSEG_MASK     FLEXCAN_GENMASK(14, 10)
+#define FLEXCAN_FDCBT_FPSEG1_MASK       FLEXCAN_GENMASK(7, 5)
+#define FLEXCAN_FDCBT_FPSEG2_MASK       FLEXCAN_GENMASK(2, 0)
+
+/* FLEXCAN CRC Register (CRCR) bits */
+#define FLEXCAN_CRCR_MBCRC_MASK         FLEXCAN_GENMASK(22, 16)
+#define FLEXCAN_CRCR_MBCRC(x)           (((x) & FLEXCAN_CRCR_MBCRC_MASK) <=
< 16)
+#define FLEXCAN_CRCR_TXCRC_MASK         FLEXCAN_GENMASK(14, 0)
+#define FLEXCAN_CRCR_TXCRC(x)           ((x) & FLEXCAN_CRCR_TXCRC_MASK)
+
+/* FLEXCAN interrupt flag register (IFLAG) bits */
+/* Errata ERR005829 step7: Reserve first valid MB */
+#define I_FIFO_OVERFLOW  7
+#define I_FIFO_WARN      6
+#define I_FIFO_AVAILABLE 5
+
+#define FLEXCAN_TX_MB_RESERVED_RX_FIFO  8
+#define FLEXCAN_TX_MB_RESERVED_RX_MAILBOX       0
+#define FLEXCAN_RX_MB_RX_MAILBOX_FIRST  (FLEXCAN_TX_MB_RESERVED_RX_MAILBOX=
 + 1)
+#define FLEXCAN_IFLAG_MB(x)             BIT_ULL(x)
+#define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW  BIT(I_FIFO_OVERFLOW)
+#define FLEXCAN_IFLAG_RX_FIFO_WARN      BIT(I_FIFO_WARN)
+#define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE BIT(I_FIFO_AVAILABLE)
+
+/* FLEXCAN message buffers */
+#define FLEXCAN_MB_CODE_RX_BUSY_BIT     (0x1 << 24)
+#define FLEXCAN_MB_CODE_RX_INACTIVE     (0x0 << 24)
+#define FLEXCAN_MB_CODE_RX_EMPTY        (0x4 << 24)
+#define FLEXCAN_MB_CODE_RX_FULL         (0x2 << 24)
+#define FLEXCAN_MB_CODE_RX_OVERRUN      (0x6 << 24)
+#define FLEXCAN_MB_CODE_RX_RANSWER      (0xa << 24)
+
+#define FLEXCAN_MB_CODE_TX_INACTIVE     (0x8 << 24)
+#define FLEXCAN_MB_CODE_TX_ABORT        (0x9 << 24)
+#define FLEXCAN_MB_CODE_TX_DATA         (0xc << 24)
+#define FLEXCAN_MB_CODE_TX_TANSWER      (0xe << 24)
+
+#define FLEXCAN_MB_CODE(x)              (((x) & 0xF) << 24)
+#define FLEXCAN_MB_CODE_MASK            FLEXCAN_MB_CODE(UINT32_MAX)
+
+#define FLEXCAN_MB_CNT_EDL              BIT(31)
+#define FLEXCAN_MB_CNT_BRS              BIT(30)
+#define FLEXCAN_MB_CNT_ESI              BIT(29)
+#define FLEXCAN_MB_CNT_SRR              BIT(22)
+#define FLEXCAN_MB_CNT_IDE              BIT(21)
+#define FLEXCAN_MB_CNT_RTR              BIT(20)
+#define FLEXCAN_MB_CNT_LENGTH(x)        (((x) & 0xF) << 16)
+#define FLEXCAN_MB_CNT_TIMESTAMP(x)     ((x) & 0xFFFF)
+#define FLEXCAN_MB_CNT_TIMESTAMP_MASK   FLEXCAN_MB_CNT_TIMESTAMP(UINT32_MA=
X)

+/* view of single message buffer registers */
+typedef struct FlexcanRegsMessageBuffer {
+    uint32_t can_ctrl;
+    uint32_t can_id;
+    uint32_t data[2];
+} FlexcanRegsMessageBuffer;


include/hw/net/flexcan.h

+/**
+ * Structure of the hardware registers
+ *
+ * originally created for the Linux kernel by Marc Kleine-Budde
+ */
+typedef struct FlexcanRegs {
+    uint32_t mcr;                /* 0x00 */
+    uint32_t ctrl;               /* 0x04 - not affected by soft reset */
+    uint32_t timer;              /* 0x08 */
+    uint32_t tcr;                /* 0x0C */
+    uint32_t rxmgmask;           /* 0x10 - not affected by soft reset */
+    uint32_t rx14mask;           /* 0x14 - not affected by soft reset */
+    uint32_t rx15mask;           /* 0x18 - not affected by soft reset */
+    uint32_t ecr;                /* 0x1C */
+    uint32_t esr;                /* 0x20 */
+    uint32_t imask2;             /* 0x24 */
+    uint32_t imask1;             /* 0x28 */
+    uint32_t iflag2;             /* 0x2C */
+    uint32_t iflag1;             /* 0x30 */
+    union {                      /* 0x34 */
+        uint32_t gfwr_mx28;      /* MX28, MX53 */
+        uint32_t ctrl2;          /* MX6, VF610 - not affected by soft rese=
t */
+    };
+    uint32_t esr2;               /* 0x38 */
+    uint32_t imeur;              /* 0x3C, unused */
+    uint32_t lrfr;               /* 0x40, unused */
+    uint32_t crcr;               /* 0x44 */
+    uint32_t rxfgmask;           /* 0x48 */
+    uint32_t rxfir;              /* 0x4C - not affected by soft reset */
+    uint32_t cbt;                /* 0x50, unused - not affected by soft re=
set */
+    uint32_t _reserved2;         /* 0x54 */
+    uint32_t dbg1;               /* 0x58, unused */
+    uint32_t dbg2;               /* 0x5C, unused */
+    uint32_t _reserved3[8];      /* 0x60 */
+    union {                      /* 0x80 - not affected by soft reset */
+        uint32_t mb[sizeof(FlexcanRegsMessageBuffer) * FLEXCAN_MAILBOX_COU=
NT];
+        FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
+        FlexcanRegsRXFifo fifo;
+    };
+    uint32_t _reserved4[256];    /* 0x480 */
+    uint32_t rximr[64];          /* 0x880 - not affected by soft reset */
+    uint32_t _reserved5[24];     /* 0x980 */
+    uint32_t gfwr_mx6;           /* 0x9E0 - MX6 */
+
+    /* the rest is unused except for SMB */
+    uint32_t _reserved6[39];     /* 0x9E4 */
+    uint32_t _rxfir[6];          /* 0xA80 */
+    uint32_t _reserved8[2];      /* 0xA98 */
+    uint32_t _rxmgmask;          /* 0xAA0 */
+    uint32_t _rxfgmask;          /* 0xAA4 */
+    uint32_t _rx14mask;          /* 0xAA8 */
+    uint32_t _rx15mask;          /* 0xAAC */
+    uint32_t tx_smb[4];          /* 0xAB0 */
+    union {                      /* 0xAC0, used for SMB emulation */
+        uint32_t rx_smb0_raw[4];
+        FlexcanRegsMessageBuffer rx_smb0;
+    };
+    uint32_t rx_smb1[4];         /* 0xAD0 */
+    uint32_t mecr;               /* 0xAE0 */
+    uint32_t erriar;             /* 0xAE4 */
+    uint32_t erridpr;            /* 0xAE8 */
+    uint32_t errippr;            /* 0xAEC */
+    uint32_t rerrar;             /* 0xAF0 */
+    uint32_t rerrdr;             /* 0xAF4 */
+    uint32_t rerrsynr;           /* 0xAF8 */
+    uint32_t errsr;              /* 0xAFC */
+    uint32_t _reserved7[64];     /* 0xB00 */
+    uint32_t fdctrl;             /* 0xC00 - not affected by soft reset */
+    uint32_t fdcbt;              /* 0xC04 - not affected by soft reset */
+    uint32_t fdcrc;              /* 0xC08 */
+    uint32_t _reserved9[199];    /* 0xC0C */
+    uint32_t tx_smb_fd[18];      /* 0xF28 */
+    uint32_t rx_smb0_fd[18];     /* 0xF70 */
+    uint32_t rx_smb1_fd[18];     /* 0xFB8 */
+} FlexcanRegs;
+

