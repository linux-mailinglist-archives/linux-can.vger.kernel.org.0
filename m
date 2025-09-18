Return-Path: <linux-can+bounces-4740-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D98B83C27
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 11:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584FF1732CB
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAAC2F9DB2;
	Thu, 18 Sep 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="SZUH66kq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCC2FCC1A
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187454; cv=none; b=hl4TahDkoeykr+GcSE9ywQ5jJi7WNR1qhjyDncVvnigmY4Gtbn2OH0AatbAfHSShODKB6ztLmpULK8jnYM/BYsRPyGd9veGv6VUZZSVFGaV6cto15Pn/GIFmePQq7cDmFPMFWXcDNSYVjSPRavqmy/oUfBywiq/m7OR6LGfhjyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187454; c=relaxed/simple;
	bh=JJcv6T0zfvA/A6HWvSo2iaEpiM5RVVPIqh9LpzpWjoQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=KH4ciWeMivIQp381eYOEGqzE87qII5EJ4Zxr7xMFLee2uO94lL2p2dd2xf266JvOjPnJgfy+BFiWe2tdYYaNDom7mjxS8XfId2pLuXKIDlnXIhcIJiwRZdltgCJLFl9oRJN6ZZhnoOmpvbCC0cHFDl1reVeGpa2fYo6arydZoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=SZUH66kq; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 8DD5460128;
	Thu, 18 Sep 2025 11:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1758187444;
	bh=JJcv6T0zfvA/A6HWvSo2iaEpiM5RVVPIqh9LpzpWjoQ=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=SZUH66kqT7bzO8UVdqFrR7jB4LBTiAMj3wGy1i4jIgucSjubgjolGRO8qCoTPjsvk
	 wOaMkx4wZ7rFnxB+kgR/oR015sCUW2vHrkzRX4m04hjomd/ooX6OycQVWFmjGnFYlf
	 oHFStqBEfe3WkQl5t2U/mbG2Bgj+/tBV5TGuowP5uFdyaTJF1UdrvTrNUxCtcoy2G0
	 P1wGOyUn8yapL1dctBg1TDJsLZEpzS+N55Uy2qX4H0/mjZpENbH1uqHZc2vumN13qW
	 ANhkZ4A4keamnolrz+HU2mwgXsq7kjjSQluwh9th6tuPzCgz13Gb0znoWBm3qyhETW
	 JESd4b5FVWVjw==
Date: Thu, 18 Sep 2025 11:24:04 +0200 (CEST)
From: stephane.grosjean@free.fr
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, 
	=?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@hms-networks.com>
Message-ID: <1904779500.401455893.1758187444281.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <20250917-aboriginal-refined-honeybee-82b1aa-mkl@pengutronix.de>
Subject: Re: PCAN-USB FD: shift-out-of-bounds
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC140 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Hello Marc,

Ok I'll send a patch right away.

Regards,

St=C3=A9phane

----- Mail original -----=20

De: "Marc Kleine-Budde" <mkl@pengutronix.de>=20
=C3=80: "St=C3=A9phane Grosjean" <stephane.grosjean@hms-networks.com>=20
Cc: "linux-can Mailing List" <linux-can@vger.kernel.org>=20
Envoy=C3=A9: Mercredi 17 Septembre 2025 15:41:22=20
Objet: PCAN-USB FD: shift-out-of-bounds=20

Hello St=C3=A9phane,=20

with the recent Debian kernel (6.16.7+deb14-amd64), the undefined=20
behavior sanitizer triggered with my "0c72:0012 PEAK System PCAN-USB=20
FD":=20

| ------------[ cut here ]------------=20
| UBSAN: shift-out-of-bounds in /build/reproducible-path/linux-6.16.7/drive=
rs/net/can/usb/peak_usb/pcan_usb_core.c:114:19=20
| shift exponent 32 is too large for 32-bit type 'int'=20
| CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.7+deb14-amd64 #1 PR=
EEMPT(lazy) Debian 6.16.7-1=20
| Hardware name: LENOVO 20AQCTO1WW/20AQCTO1WW, BIOS GJET82WW (2.32 ) 01/09/=
2015=20
| Call Trace:=20
| <IRQ>=20
| dump_stack_lvl+0x5d/0x80=20
| ubsan_epilogue+0x5/0x2b=20
| __ubsan_handle_shift_out_of_bounds.cold+0x5e/0x113=20
| peak_usb_set_ts_now.cold+0x14/0x24 [peak_usb]=20
| pcan_usb_fd_decode_buf+0x42c/0x600 [peak_usb]=20
| ? dma_unmap_page_attrs+0x23b/0x260=20
| peak_usb_read_bulk_callback+0x13e/0x160 [peak_usb]=20
| __usb_hcd_giveback_urb+0xa0/0x120 [usbcore]=20
| usb_giveback_urb_bh+0xb9/0x140 [usbcore]=20
| process_one_work+0x18d/0x340=20
| bh_worker+0x1ac/0x210=20
| tasklet_action+0x10/0x30=20
| handle_softirqs+0xdf/0x320=20
| ? handle_edge_irq+0x90/0x1e0=20
| __irq_exit_rcu+0xbc/0xe0=20
| common_interrupt+0x85/0xa0=20
| </IRQ>=20
| <TASK>=20
| asm_common_interrupt+0x26/0x40=20
| RIP: 0010:cpuidle_enter_state+0xd3/0x690=20
| Code: 00 00 e8 b0 25 3b ff e8 cb f2 ff ff 49 89 c6 0f 1f 44 00 00 31 ff e=
8 bc 7f 39 ff 45 84 ff 0f 85 13 02 00 00 fb 0f 1f 44 00 00 <45> 85 ed 0f 88=
 e3 01 00 00 4d 63 e5 49 83 fc 0a 0f 83 be 04 00 00=20
| RSP: 0018:ffffffff8c803e10 EFLAGS: 00000246=20
| RAX: ffff8dc0c4dc7000 RBX: ffff8dc052239a58 RCX: 0000000000000000=20
| RDX: 00002622c2e710e1 RSI: 000000002f846563 RDI: 0000000000000000=20
| RBP: ffffffff8ca40da0 R08: 000000000008cde8 R09: 0000000000000009=20
| R10: 000000002cb41780 R11: 0000000000000006 R12: 0000000000000005=20
| R13: 0000000000000005 R14: 00002622c2e710e1 R15: 0000000000000000=20
| cpuidle_enter+0x2d/0x40=20
| do_idle+0x1df/0x240=20
| cpu_startup_entry+0x29/0x30=20
| rest_init+0xe7/0xf0=20
| start_kernel+0x794/0x7a0=20
| x86_64_start_reservations+0x24/0x30=20
| x86_64_start_kernel+0x126/0x130=20
| common_startup_64+0x13e/0x141=20
| </TASK>=20
| ---[ end trace ]---=20

regards,=20
Marc=20

--=20
Pengutronix e.K. | Marc Kleine-Budde |=20
Embedded Linux | https://www.pengutronix.de |=20
Vertretung N=C3=BCrnberg | Phone: +49-5121-206917-129 |=20
Amtsgericht Hildesheim, HRA 2686 | Fax: +49-5121-206917-9 |

