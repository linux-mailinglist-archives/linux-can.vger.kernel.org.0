Return-Path: <linux-can+bounces-5992-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D929CF11C2
	for <lists+linux-can@lfdr.de>; Sun, 04 Jan 2026 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 930043007270
	for <lists+linux-can@lfdr.de>; Sun,  4 Jan 2026 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D726CE2D;
	Sun,  4 Jan 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX2Fedpw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0FA4400;
	Sun,  4 Jan 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767541344; cv=none; b=t3ZsmqQP2gRIvqir7NKtwHyFV5g3pPtnB4+IXVnPgAeR9Snhr5FkApkH7TRVweJdmUYLS7CKtMWynRXqMuVK322In9MzjfQq7aGX916nBPoyzWpDzVKAaLiq5cyluv6k7fsjclZnlOcN6yQYooEs9rirg05i6yneZAdF1XTY634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767541344; c=relaxed/simple;
	bh=UjJWRT85rpQHhNsUnnSlU0JLznEEUlM8LzlU0ybpfFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk5oGEOjGovTcS1Sox/tbmwj/AWfbWRW7qi+s2KNX27AZHEaS/kUQLjazS/1TLlXHTo7yn3l4mm4N3Ckc5xOPNe0/rRThA6dUe+sJJSzvlfl6oO/jEcUPKKiTAR4o5u79VdZwlq4K3Uur4eNWBDnFAgLgS4ahRqp/ze/m9gE3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX2Fedpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766AFC4CEF7;
	Sun,  4 Jan 2026 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767541343;
	bh=UjJWRT85rpQHhNsUnnSlU0JLznEEUlM8LzlU0ybpfFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JX2FedpwHJMYb96Y9Hy/Y/5G5AucFNpQZ9MKpn7vaeggkv3iwWznZagNcO3I4F+13
	 I2rpWUGxNZy9WV5sK+rx6X1GTsLQLoKymHxKLZJHgD40PqSUcJlpv4g9oSOvyuOtG6
	 Di/moqAA5PrKdauPb43IzQOLEVhqZA6h06TmNKnRJIyv/g2le03f1J/7oSPLgiBX+b
	 YIp8Ude3W+FvJGOSnQ1btl10PFS13jPDONArZBSZ/nxwlyOC36wIndPxZqFVvLrr6w
	 HyXFHnEBH5h+ydJjSNskwod+SbmMRodu1JqsSzV++T6YsSEiOm52PJKuPu3cW0z9kX
	 L6AgIVAW6parg==
Date: Sun, 4 Jan 2026 07:42:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Prithvi <activprithvi@gmail.com>, andrii@kernel.org, mkl@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
Message-ID: <20260104074222.29e660ac@kernel.org>
In-Reply-To: <63c20aae-e014-44f9-a201-99e0e7abadcb@hartkopp.net>
References: <20251117173012.230731-1-activprithvi@gmail.com>
	<0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
	<c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
	<aSx++4VrGOm8zHDb@inspiron>
	<d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
	<20251220173338.w7n3n4lkvxwaq6ae@inspiron>
	<01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
	<20260102153611.63wipdy2meh3ovel@inspiron>
	<20260102120405.34613b68@kernel.org>
	<63c20aae-e014-44f9-a201-99e0e7abadcb@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Jan 2026 13:20:34 +0100 Oliver Hartkopp wrote:
> Hello Jakub,
> 
> thanks for stepping in!
> 
> On 02.01.26 21:04, Jakub Kicinski wrote:
> 
> > You're asking the wrong person, IIUC Andrii is tangentially involved
> > in XDP (via bpf links?):
> >   
> (..)
> > 
> > Without looking too deeply - XDP has historically left the new space
> > uninitialized after push, expecting programs to immediately write the
> > headers in that space. syzbot had run into this in the past but I can't
> > find any references to past threads quickly :(  
> 
> To identify Andrii I mainly looked into the code with 'git blame' that 
> led to this problematic call chain:
> 
>    pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
>    netif_skb_check_for_xdp net/core/dev.c:5081 [inline]
>    netif_receive_generic_xdp net/core/dev.c:5112 [inline]
>    do_xdp_generic+0x9e3/0x15a0 net/core/dev.c:5180
> 
> Having in mind that the syzkaller refers to 
> 6.13.0-rc7-syzkaller-00039-gc3812b15000c I wonder if we can leave this 
> report as-is, as the problem might be solved in the meantime??
> 
> In any case I wonder, if we should add some code to re-check if the 
> headroom of the CAN-related skbs is still consistent and not changed in 
> size by other players. And maybe add some WARN_ON_ONCE() before dropping 
> the skb then.
> 
> When the skb headroom is not safe to be used we need to be able to 
> identify and solve it.

Ugh, I should have looked at the report. The struct can_skb_priv
business is highly unconventional for the networking stack.
Would it be possible to kmalloc() this info and pass it to the socket
via shinfo->destructor_arg?

