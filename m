Return-Path: <linux-can+bounces-1540-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89497EB1A
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 13:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3DE280E57
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0CB19538A;
	Mon, 23 Sep 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wXvyoGaT"
X-Original-To: linux-can@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080D1F5FD
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092402; cv=none; b=mHa1ugqeskw/c5fZ0dKBCiSZETY91WlDVa8xwXMN0YnLLf29AizTFDpAqDTB8O82JfSNOBxv7Z6T01DHKjdLKUWFLHLgD0+FkldNR9gQd7+QJtZYn0jzthjaHeV5sRU/6MxGp+oqmLN1Usd1gcOkZrCPA6KKSN0WRPxp03SqVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092402; c=relaxed/simple;
	bh=9x+Z6LuBaZHxWOCzLaIyxATAaHQiVSo19rlpJULs/8o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q9n1mSY40TJcnmqG47xQZCei8rJBT6S+F4yuXvDbQQ6TXs1rv+LC+Pe0IanRKJy+x5N1/D/v179dZDwIVcU6HcDNHGHxDnXklYs9g0NCU5sj5XHgJ3sRRdWcHDXQXUlgkpRhKtyUzVuhIeqEUe1O2s0Gsso7SZVKT/GaYgqngJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wXvyoGaT; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 04D921F8F7;
	Mon, 23 Sep 2024 13:53:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727092395;
	bh=LlG5e2QoMXL/BqlgiI9bs1c+qLZ4GQcTeDxDYrvkte0=; h=From:To:Subject;
	b=wXvyoGaTTLSDPTGHhgGzQ3eF+hUkwQfTY9HGegydee7GU71PRSU+dHsTLs0XM61/1
	 YhUwUHlVot2uaISnIJl6eIhj9DW9I8dHmnJiNvQ0YNoYjR30iC2acpqg4pmbPery83
	 fyMIG5XuA4otclhw+bAxgZoIij1ZwNUi39mwPd/IyBnEoRJid9LZDccPirE4zx2cIW
	 /ygozV20cflsbTwZuxI8Njb60gXpjaD63EasY8Eun0FAVkLff8rM7j5rneCKlN2C61
	 E6EfXoJSRnZ5uKyrEum3E73Ee2H4xPO7k0d9Fi5Q2SRkDTBk0uFZR/BXOYHweJyMy/
	 Edpuvfa5GMR/Q==
Date: Mon, 23 Sep 2024 13:53:10 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Oops on mcp251xfd open on 6.6.52
Message-ID: <20240923115310.GA138774@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
I got the following Oops on doing a simple ip link set canX up, running
on an i.MX8MM SoC.

This was reproduced with some automated testing, I have not tried to
reproduce it so far. Any idea or hint? It seems systematic, introduced
around 12th september on the v6.6.y branch.

[   75.694960] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[   75.926065] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   75.933032] pc : timecounter_read+0x18/0x70
[   75.937230] lr : mcp251xfd_ring_init+0x1dc/0x944 [mcp251xfd]
[   75.942903] sp : ffffffc08496b460
[   75.946218] x29: ffffffc08496b460 x28: 0000000000000000 x27: ffffff800a7608c0
[   75.953364] x26: 0000000000000001 x25: 0000000000000000 x24: ffffff800c50a000
[   75.960504] x23: ffffff800a7628c0 x22: 0000000000000000 x21: 0000000000000460
[   75.967648] x20: ffffff800a760e00 x19: ffffff800a763830 x18: 0000000000000000
[   75.974796] x17: 000000040044ffff x16: 00500072b5593519 x15: 0000000000000000
[   75.981942] x14: 000000000003ecee x13: 0000000000000299 x12: 0000000000000002
[   75.989083] x11: 0000000000000000 x10: 0000000000000950 x9 : ffffffc08496aef0
[   75.996224] x8 : ffffff800a760de0 x7 : 0000000000000000 x6 : 00000000256ab2b4
[   76.003365] x5 : 0000000000000001 x4 : 0000000000002f70 x3 : 0000000000000004
[   76.010508] x2 : 0000000000000010 x1 : ffffff800a761680 x0 : 0000000000000000
[   76.017652] Call trace:
[   76.020099]  timecounter_read+0x18/0x70
[   76.023942]  mcp251xfd_ring_init+0x1dc/0x944 [mcp251xfd]
[   76.029263]  mcp251xfd_chip_start+0x228/0x28c [mcp251xfd]
[   76.034669]  mcp251xfd_open+0x8c/0x298 [mcp251xfd]
[   76.039468]  __dev_open+0x100/0x1d8
[   76.042967]  __dev_change_flags+0x194/0x20c
[   76.047158]  dev_change_flags+0x24/0x6c
[   76.051002]  do_setlink+0x27c/0xeb0
[   76.054495]  __rtnl_newlink+0x520/0x88c
[   76.058333]  rtnl_newlink+0x50/0x7c
[   76.061824]  rtnetlink_rcv_msg+0x128/0x378
[   76.065922]  netlink_rcv_skb+0x60/0x130
[   76.069764]  rtnetlink_rcv+0x18/0x24
[   76.073342]  netlink_unicast+0x300/0x36c
[   76.077268]  netlink_sendmsg+0x194/0x400
[   76.081194]  ____sys_sendmsg+0x214/0x248
[   76.085120]  ___sys_sendmsg+0xb0/0xfc
[   76.088788]  __sys_sendmsg+0x78/0xd0
[   76.092370]  __arm64_sys_sendmsg+0x24/0x30
[   76.096470]  invoke_syscall.constprop.0+0x50/0xec
[   76.101179]  do_el0_svc+0x40/0xc8
[   76.104497]  el0_svc+0x48/0x148
[   76.107643]  el0t_64_sync_handler+0x120/0x12c
[   76.112002]  el0t_64_sync+0x190/0x194
[   76.115677] Code: 910003fd f9000bf3 aa0003f3 f9400000 (f9400001)
[   76.121781] ---[ end trace 0000000000000000 ]---

Francesco


