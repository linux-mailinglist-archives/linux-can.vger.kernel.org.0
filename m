Return-Path: <linux-can+bounces-6017-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C01CFB75B
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 01:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB2893026A81
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 00:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2848817BEBF;
	Wed,  7 Jan 2026 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksHrNXCU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97FD1684A4;
	Wed,  7 Jan 2026 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767745391; cv=none; b=YGg94VlFBZGyl05RfQqbUr/bYPeyvJVki9Z0vVQCvhgvclzXk8KRA8+f9SOdvozES/LmXOF1/jMLB7Z2OdFNYWxgsQV99dLfWJQwOo41K+WpfEboKyi9iZMoEfFIzZGWgxHHFLweo/TGdiFaQq8LWEoR3m4HXe/SNmFIxodZT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767745391; c=relaxed/simple;
	bh=wY4FRjNX3BB8mXL+6r1lxCBoL1PogAM00UMTBb3+13Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvh7wFdC7qtirp/Wpaup+PqUQEZAtiZ/LesbVE9UO3N406K/3ZXZzWS2Ysw60sj2C8aNjEtqniEC/sVHCM51vWr8n0tXeZ9b2l7HPefmnoxtm5zgzdx2s01QOGqDJKHqw4/eEjWMBsCgLrf/JZO7cWzaabkfVXAHQbp+NJmgp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksHrNXCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E7DC116C6;
	Wed,  7 Jan 2026 00:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767745387;
	bh=wY4FRjNX3BB8mXL+6r1lxCBoL1PogAM00UMTBb3+13Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ksHrNXCUkbJnUfD3/20A8m7nvyRRA70BY3IfWnP1qPnGaRsEMJUdFfGJ9JZsyerPT
	 HFtHW5eKfGc/EYff3tfyqAEXIEaQ6+y/biYzV3QdfhUV0T4bQ5c+EfQNe6PW7h/9jG
	 MOlxsB87MUCXsJil+HSkaCMQUM3a5cRxWQwmAimIvoXueN6zPdzSr26qoZMyw7BHDV
	 ga446ZdysuFNvZSWe4ofIXJJwNdjpFrwt111LbfvWwVv9mgJQRCJCjzqB2WOiy9Iv1
	 u3/H61qeuk2BA8r093A9BTraLOzx0BW+LNwvdJDc3doqSJfWhLpT/hJ9JkR0OKV6qd
	 cA23ELIe/0ZGA==
Date: Tue, 6 Jan 2026 16:23:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: mkl@pengutronix.de, Prithvi <activprithvi@gmail.com>, andrii@kernel.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
Message-ID: <20260106162306.0649424c@kernel.org>
In-Reply-To: <904fa297-b657-4f5b-9999-b8cfcc11bfa9@hartkopp.net>
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
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 13:04:41 +0100 Oliver Hartkopp wrote:
> When such skb is echo'ed back after successful transmission via 
> netif_rx() this leads to skb->skb_iif = skb->dev->ifindex;
> 
> To prevent a loopback the CAN frame must not be sent back to the 
> originating interface - even when it has been routed to different CAN 
> interfaces in the meantime (which always overwrites skb_iif).
> 
> Therefore we need to maintain the "real original" incoming interface.

Alternatively perhaps for this particular use case you could use
something like metadata_dst to mark the frame as forwarded / annotate
with the originating ifindex?

