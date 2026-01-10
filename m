Return-Path: <linux-can+bounces-6100-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77605D0DE92
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 23:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92CB3302BABA
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 22:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB32BEFFE;
	Sat, 10 Jan 2026 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWGyJctg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1FA2139C9;
	Sat, 10 Jan 2026 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768084733; cv=none; b=QS4sxIEWnrmZZlLvtGdBtBWBzs7eGpKSAkJTTJ7ojRbNpgJaSjpfqjcmyRv5LDL0WjQ9NsEyj//+ZZsXCbgOZ6K6/xFlQx6YpPRltl/RU4SgKHkBTXfjrEaamCTLKSeaBiMTzXnFJOZdFjHLzrJzCag5JBCN5PQT6C0+ZdaiuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768084733; c=relaxed/simple;
	bh=cFy/T8mSd2Wo1IgsveCGgRX5Nc2k/3aNLJOImE3w8ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM7FavA2lsfRegZZyvN8QJHI5IzlT/cHE6g69R33PaFBc1XCj94rNpbnf3eFVCzgsWeA5fnsUpv+sbDIX1wdh4agXqoQV5XEMnhdnBSa5I75t7KG7gKdM57y0cXR4w9s6RpJzMSWO+brJ/mKO5nMKwIJKR7pR51jD3KHCTb8pj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWGyJctg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49B5C4CEF1;
	Sat, 10 Jan 2026 22:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768084733;
	bh=cFy/T8mSd2Wo1IgsveCGgRX5Nc2k/3aNLJOImE3w8ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWGyJctgiaOTE5J/oaNd6UyEsH3ebSC9qVWBv42kFEYPYZzJ4pSPGcwPHdsOR6mPa
	 8WT/huszHE3h0a7OlG2vs2+sqGgptCoH2roltntnoX2sPcWYAw6NoT163nMPDlOKKj
	 6vA8NVU7DBaarPVuQh557RfcRAXU7GNej1I5rqnW5ASqgCOdFxWiMrn0X9ovDhJfUS
	 Lln/bIjpTCx13vdJwvDTfAxXC38kjr/V8ad0mpLoQluUrwq95VL1lmXQhyUFwtR8Xn
	 xtoU+O+PzCJWb2GxLFRwTdAqP7MYxQDgCNsZWNQyQ/d3n4nt33nNV48vIA/n45zyD2
	 zXgLJZnMMd3uw==
From: Jakub Kicinski <kuba@kernel.org>
To: mkl@pengutronix.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mailhol@kernel.org,
	ondrej.ille@gmail.com,
	linux-can@vger.kernel.org,
	davem@davemloft.net,
	kernel@pengutronix.de,
	swilczek.lx@gmail.com,
	pisa@fel.cvut.cz,
	syzbot+e8cb6691a7cf68256cb8@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [net,2/3] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak
Date: Sat, 10 Jan 2026 14:38:36 -0800
Message-ID: <20260110223836.3890248-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109135311.576033-3-mkl@pengutronix.de>
References: <20260109135311.576033-3-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak

This patch fixes a memory leak by re-anchoring the URB in
gs_usb_receive_bulk_callback() before resubmission. The USB framework
unanchors URBs before calling the completion callback, so the URB needs to
be re-anchored to be tracked by usb_kill_anchored_urbs() in gs_can_close().

Link: https://patch.msgid.link/20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index a0233e550a5a..d093babbc320 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -751,6 +751,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  			  hf, parent->hf_size_rx,
>  			  gs_usb_receive_bulk_callback, parent);
>
> +	usb_anchor_urb(urb, &parent->rx_submitted);
> +
>  	rc = usb_submit_urb(urb, GFP_ATOMIC);

If usb_submit_urb() fails here, the URB remains anchored but is never
submitted. When gs_can_close() later calls usb_kill_anchored_urbs(), it
iterates over anchored URBs and calls usb_kill_urb() on each one. For URBs
that were never successfully submitted, use_count is 0, so usb_kill_urb()
returns without unanchoring them. This causes usb_kill_anchored_urbs() to
loop infinitely on the same URB since the anchor list never becomes empty.

Other CAN USB drivers handle this by calling usb_unanchor_urb() when
submission fails. For example, peak_usb_read_bulk_callback() does:

    usb_anchor_urb(urb, &dev->rx_submitted);
    err = usb_submit_urb(urb, GFP_ATOMIC);
    if (!err)
        return;

    usb_unanchor_urb(urb);

Should similar error handling be added here to avoid potential hangs when
closing the device after a URB submission failure?

>
>  	/* USB failure take down all interfaces */
>  	if (rc == -ENODEV) {

[ ... ]

