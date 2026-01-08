Return-Path: <linux-can+bounces-6042-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AAAD0409F
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 16:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3643730F90B6
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C142C21DF;
	Thu,  8 Jan 2026 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/pe9NNM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB9212FB9;
	Thu,  8 Jan 2026 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885425; cv=none; b=txrYIR2SmieGqZSzCSELfxkbC6bhdm49Oz/TSvWm9Rkl0Ko5zhTIQua5yvpDzz/2bxbmm9iwCQMddVU1WQt+4r63Pf7X+z4BUUdN7lXGxNjNREXHxzGXNpvDDqWJwSFWkFwWpbObeyJAmqixFPByiAnTnzsOPVMPNU+Qw/bcOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885425; c=relaxed/simple;
	bh=f0CvU2tIQVYrHZLwRGFpAIZTZzQEZlmsLyp505OcoT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7p5E5iY3fBt3Oxo04+ELXVDWW4yc6be9OuPLAlSbleQILJ0zdKTZZgVFpqD/CgskbAp+yHoqfryBTudsVN2I6RHNphTPIQro5ksgGByKH0DkttnI9vi9+leTsBEILq8r344AXujUclffMW8+a97wAFTQL9VTS7TvUPQC/bB0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/pe9NNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9FDC116C6;
	Thu,  8 Jan 2026 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767885424;
	bh=f0CvU2tIQVYrHZLwRGFpAIZTZzQEZlmsLyp505OcoT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q/pe9NNMiNxz34hUsWNmWKU2WKqFubbla3Wr7oWeH8vOiu/jI6KQbvAGDiyqebpee
	 zueXbvVoEBUbdilVPWFJqRuNuBAGfpQY2nYSH9LvfR+BEfmKbAmTaTk3QHLESwLWxL
	 c135xytcgj5cRVkPduRTaYTXtd8dD4ewUE3Z//Eazp9mW0O7lbVosamcHzpVBpSAh4
	 obT6D1ou2uLjkRk25+UQt+57hKnWBZQhox46TD8U12AduKkVvhG7W33xnvNXXjjSLx
	 lR+Mn0/snAZwvs+38w+8/rWcw4jdjKomYHqwq+hCNYv4L7gB3mBokXbb7PQnPcYV5H
	 MZ5zw230QRGUw==
Date: Thu, 8 Jan 2026 07:17:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: mkl@pengutronix.de, Prithvi <activprithvi@gmail.com>, andrii@kernel.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
Message-ID: <20260108071703.788c67ed@kernel.org>
In-Reply-To: <8b55ae26-daba-4b2e-a10b-4be367fb42d0@hartkopp.net>
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
	<20260104074222.29e660ac@kernel.org>
	<fac5da75-2fc0-464c-be90-34220313af64@hartkopp.net>
	<20260105152638.74cfea6c@kernel.org>
	<904fa297-b657-4f5b-9999-b8cfcc11bfa9@hartkopp.net>
	<20260106162306.0649424c@kernel.org>
	<8b55ae26-daba-4b2e-a10b-4be367fb42d0@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 16:34:13 +0100 Oliver Hartkopp wrote:
> > Alternatively perhaps for this particular use case you could use
> > something like metadata_dst to mark the frame as forwarded / annotate
> > with the originating ifindex?  
> 
> I looked into it and the way how skb_dst is shared in the union behind 
> cb[] does not look very promising for skbs that wander up and down in 
> the network layer.

Maybe I'm misunderstanding, but skb_dst is only unioned with some
socket layer (TCP and sockmsg) fields, not with cb[]. It'd be
problematic if CAN gw frames had to traverse routing but I don't 
think they do?

