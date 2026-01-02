Return-Path: <linux-can+bounces-5990-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86456CEF46F
	for <lists+linux-can@lfdr.de>; Fri, 02 Jan 2026 21:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C97DA3001BF9
	for <lists+linux-can@lfdr.de>; Fri,  2 Jan 2026 20:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170631961D;
	Fri,  2 Jan 2026 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LatBHsvD"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588F319614;
	Fri,  2 Jan 2026 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384247; cv=none; b=NEQ1RAg4gJkxG0jOoshQ9lBtPUZDyqTQCT3BTbx7bxaY+iSlNSwre2cSvc40mwu9tDrLECjSS/8IboskKqNe0ZsQNHue1GxP9DQCBlp1OnaguWcAthIXux8Qp0EKhWvhf4maPtwAk0pgTYmIvjILm+7+RY+R2kTIQ/S6ix2+qhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384247; c=relaxed/simple;
	bh=2vq9xeh/ZjwJCXeCtC2pq+VOjFi6w5FQElmEF3VFqI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxYKCpWtT0yVNSWvL9p8656Gt0UzNMS0iLBJd2x0fsBuBf4At7KC4s2KAqkEDjTeA5nDXwH4nmg8D7pMxlAEE7qqVPtHK3ucWYudgZ5pO/I2Dh+PASrLnfWqFdGWCwQ7hnhcdYpFv+IQXiaBOZ81GwHF/ZPGaR5tzV07o9echGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LatBHsvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D356C116B1;
	Fri,  2 Jan 2026 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767384246;
	bh=2vq9xeh/ZjwJCXeCtC2pq+VOjFi6w5FQElmEF3VFqI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LatBHsvD91n9PNyXgiGK0woU+gfEz/RmcTMpAH63pH2HJ45jAmGWuxu0/CWc6nRyi
	 d5iMxlym4KCsdn7VB+gsCe6IlDZfYidTTJkIFws+m+X8TDdooFeYDU46F2mQTLq16I
	 D7dz7PAfigSVVC0otmNZFVr8AXNNcKNnk4dle1D13AEqFGsSgxqNJpalYuDQ7tEsB0
	 +Ej+i+szISTz0FYqKX3mQvRdi26UPAQv00iyWhyOIE67wYMNE2BCEbKZAefNsfEifk
	 v4M3YBamRKzulRg+iPuvjzlCQdXEyfoMvPPEJZUc36e4U6wxwUnfRyS0SbUo950kQj
	 CEwhk5RS94Fzw==
Date: Fri, 2 Jan 2026 12:04:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Prithvi <activprithvi@gmail.com>
Cc: andrii@kernel.org, socketcan@hartkopp.net, mkl@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
Message-ID: <20260102120405.34613b68@kernel.org>
In-Reply-To: <20260102153611.63wipdy2meh3ovel@inspiron>
References: <20251117173012.230731-1-activprithvi@gmail.com>
	<0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
	<c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
	<aSx++4VrGOm8zHDb@inspiron>
	<d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
	<20251220173338.w7n3n4lkvxwaq6ae@inspiron>
	<01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
	<20260102153611.63wipdy2meh3ovel@inspiron>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Jan 2026 21:06:11 +0530 Prithvi wrote:
> Just a gentle ping on this thread 

You're asking the wrong person, IIUC Andrii is tangentially involved
in XDP (via bpf links?):

XDP (eXpress Data Path)
M:	Alexei Starovoitov <ast@kernel.org>
M:	Daniel Borkmann <daniel@iogearbox.net>
M:	David S. Miller <davem@davemloft.net>
M:	Jakub Kicinski <kuba@kernel.org>
M:	Jesper Dangaard Brouer <hawk@kernel.org>
M:	John Fastabend <john.fastabend@gmail.com>
R:	Stanislav Fomichev <sdf@fomichev.me>
L:	netdev@vger.kernel.org
L:	bpf@vger.kernel.org

Without looking too deeply - XDP has historically left the new space
uninitialized after push, expecting programs to immediately write the
headers in that space. syzbot had run into this in the past but I can't
find any references to past threads quickly :(

