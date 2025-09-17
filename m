Return-Path: <linux-can+bounces-4723-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AC8B7F898
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BB01889A36
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C8E3195F3;
	Wed, 17 Sep 2025 13:41:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D603195F8
	for <linux-can@vger.kernel.org>; Wed, 17 Sep 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116487; cv=none; b=p7J1IOzRofZlUgcWSFcmRn+zPu1YWWySDzwUh3LgZsLdno6CPA+Jw3v5Awg90gKTQJj2JQ9chMkiXR7ynGR63ROOYWxjzUxpSG8t1a+EcZo7sdpTTAmn+oQjW0UcBqAHsULLjJNbg5Qa3NO7eEmLsNY/B7zXTA6yIsiB5x8HQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116487; c=relaxed/simple;
	bh=bTDVlWtbilqO/bulJlgSjVEvh/1ClQvmAQFeHd22HkI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eiNEnQwoEI5OxoGoP7lcSqb/UWfc2QlPJ724JjdKFoxsnyZQFc7HzpiUoVheH10q4MboxeUtb+3UJXDWvrUs7MAnDiS+oW6LJ71k65Gz1iW17xwpm0SBxp5DEt1RQGk2Au2qcmdbG4/w1VDUV9VeJsE5C+5JwS28By4L5tLoSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uysPT-0004ks-8g; Wed, 17 Sep 2025 15:41:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uysPS-001lsq-3A;
	Wed, 17 Sep 2025 15:41:23 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A13184727EB;
	Wed, 17 Sep 2025 13:41:22 +0000 (UTC)
Date: Wed, 17 Sep 2025 15:41:22 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Subject: PCAN-USB FD: shift-out-of-bounds
Message-ID: <20250917-aboriginal-refined-honeybee-82b1aa-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="umk664vr5haxaooq"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--umk664vr5haxaooq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: PCAN-USB FD: shift-out-of-bounds
MIME-Version: 1.0

Hello St=C3=A9phane,

with the recent Debian kernel (6.16.7+deb14-amd64), the undefined
behavior sanitizer triggered with my "0c72:0012 PEAK System PCAN-USB
FD":

| ------------[ cut here ]------------
| UBSAN: shift-out-of-bounds in /build/reproducible-path/linux-6.16.7/drive=
rs/net/can/usb/peak_usb/pcan_usb_core.c:114:19
| shift exponent 32 is too large for 32-bit type 'int'
| CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.7+deb14-amd64 #1 PR=
EEMPT(lazy)  Debian 6.16.7-1=20
| Hardware name: LENOVO 20AQCTO1WW/20AQCTO1WW, BIOS GJET82WW (2.32 ) 01/09/=
2015
| Call Trace:
|  <IRQ>
|  dump_stack_lvl+0x5d/0x80
|  ubsan_epilogue+0x5/0x2b
|  __ubsan_handle_shift_out_of_bounds.cold+0x5e/0x113
|  peak_usb_set_ts_now.cold+0x14/0x24 [peak_usb]
|  pcan_usb_fd_decode_buf+0x42c/0x600 [peak_usb]
|  ? dma_unmap_page_attrs+0x23b/0x260
|  peak_usb_read_bulk_callback+0x13e/0x160 [peak_usb]
|  __usb_hcd_giveback_urb+0xa0/0x120 [usbcore]
|  usb_giveback_urb_bh+0xb9/0x140 [usbcore]
|  process_one_work+0x18d/0x340
|  bh_worker+0x1ac/0x210
|  tasklet_action+0x10/0x30
|  handle_softirqs+0xdf/0x320
|  ? handle_edge_irq+0x90/0x1e0
|  __irq_exit_rcu+0xbc/0xe0
|  common_interrupt+0x85/0xa0
|  </IRQ>
|  <TASK>
|  asm_common_interrupt+0x26/0x40
| RIP: 0010:cpuidle_enter_state+0xd3/0x690
| Code: 00 00 e8 b0 25 3b ff e8 cb f2 ff ff 49 89 c6 0f 1f 44 00 00 31 ff e=
8 bc 7f 39 ff 45 84 ff 0f 85 13 02 00 00 fb 0f 1f 44 00 00 <45> 85 ed 0f 88=
 e3 01 00 00 4d 63 e5 49 83 fc 0a 0f 83 be 04 00 00
| RSP: 0018:ffffffff8c803e10 EFLAGS: 00000246
| RAX: ffff8dc0c4dc7000 RBX: ffff8dc052239a58 RCX: 0000000000000000
| RDX: 00002622c2e710e1 RSI: 000000002f846563 RDI: 0000000000000000
| RBP: ffffffff8ca40da0 R08: 000000000008cde8 R09: 0000000000000009
| R10: 000000002cb41780 R11: 0000000000000006 R12: 0000000000000005
| R13: 0000000000000005 R14: 00002622c2e710e1 R15: 0000000000000000
|  cpuidle_enter+0x2d/0x40
|  do_idle+0x1df/0x240
|  cpu_startup_entry+0x29/0x30
|  rest_init+0xe7/0xf0
|  start_kernel+0x794/0x7a0
|  x86_64_start_reservations+0x24/0x30
|  x86_64_start_kernel+0x126/0x130
|  common_startup_64+0x13e/0x141
|  </TASK>
| ---[ end trace ]---

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--umk664vr5haxaooq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjKun8ACgkQDHRl3/mQ
kZzWXAf9GkEZSYjkMHEMPRdfL2GIb2H+BFMtSPfaOktLqzGdiSHY5UFoGwFUwlfC
2l0VdbP6mKMcCkU752ICsy3djHlXq+TXWP3JqUQXC3MbyFi707Q9SWOsch3dwOuK
CCe8XNACreZJVQxHPEh70v4LJGgOeMZj0PhbSt1pwbDkwW4vvsPHqFqtuKALxR+2
Q8Ph7kf+bG+9YOzBj13gwg9s/EbVJtuLl9sdgoFkIbUnyfMn/ENvpmY0FBdGC5bn
uXsZOF+tYmjSvr4QdK1thjoh7mJImEFYnyRNQjWsfphWXFzGIxU+FnGvBl3HGOUe
TO3OyGkjnE3RYGTqv4JYTJ6AbZz3SQ==
=TYTa
-----END PGP SIGNATURE-----

--umk664vr5haxaooq--

