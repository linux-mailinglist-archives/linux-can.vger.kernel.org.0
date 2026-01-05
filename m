Return-Path: <linux-can+bounces-6003-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA449CF5FAC
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 00:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CD9230319EA
	for <lists+linux-can@lfdr.de>; Mon,  5 Jan 2026 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45103009EC;
	Mon,  5 Jan 2026 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF+KKnvf"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E822DECA0;
	Mon,  5 Jan 2026 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655599; cv=none; b=OIGqIAAx8nb32uMhDlzhpZ0Mm/qlz3Tc3wNj1OshlfmFyxgtFy2LcdQBByyjiBps05JkxqOrJkTnCNGTjecIIhkywDNrpvW+2/Eq8+ZZkS0kwuiKb0bsyDFCtd+r9eW4H8AJgodSW2x7SZ1Wb4hwWCe7l0zufGaNahVNM9EaTr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655599; c=relaxed/simple;
	bh=i3X5JOtfbCztF91Q37MouqIUBmed3uHYKQYaim1BFfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZRLrgBqH5+6fp010HbBU8Sy6bQDGvmc+Gj1ARgZk2RtAqqkmA5qYJSfTqVEKMwm1K4KvmweerUKACRoeLxXvKVqIYvMfErsX4EW6vGdB01z0yTpLRaQnRrEAia11KmSJlhpRlLbUddCIWVgNyPl78UH9TU4eYKWmui0IhATviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF+KKnvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9F1C116D0;
	Mon,  5 Jan 2026 23:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767655599;
	bh=i3X5JOtfbCztF91Q37MouqIUBmed3uHYKQYaim1BFfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mF+KKnvfXUt7RciOKVHr5JBP+mEofSM5/pG0M9wPV2nJwuNjShRJEF5tQqtf2eN/n
	 fg8Sz4vPgf4/+rwtKzqn5c379f7ys5shBtrMyCpMrYPbFcnUm1nYls73ATJNOFDNrl
	 3HFxn8O7sCBLjErGoOvY9pr8TCgSmPupU6DNTxF4GC90Zk238nU0tpozJ7DVT1LOVp
	 /utf2Ce85Fz8MxPOZJOjcnxadSbR8Tb6tX7WtZDQMYracFdPdK9eXvyWqT4b8TzqN7
	 tR85/yzPm7rtrTB5+wh4sHcyJ0KKovpPWu5HquWPZ6+CuRKoI7T4eRwNJBNeffiyEm
	 PZ4/ylEWAi3KA==
Date: Mon, 5 Jan 2026 15:26:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: mkl@pengutronix.de, Prithvi <activprithvi@gmail.com>, andrii@kernel.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
Message-ID: <20260105152638.74cfea6c@kernel.org>
In-Reply-To: <fac5da75-2fc0-464c-be90-34220313af64@hartkopp.net>
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
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 14:47:08 +0100 Oliver Hartkopp wrote:
> For the ifindex I would propose to store it in struct skb_shared_info:
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 86737076101d..f7233b8f461c 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -604,10 +604,15 @@ struct skb_shared_info {
>                  struct xsk_tx_metadata_compl xsk_meta;
>          };
>          unsigned int    gso_type;
>          u32             tskey;
> 
> +#if IS_ENABLED(CONFIG_CAN)
> +       /* initial CAN iif to avoid routing back to it (can-gw) */
> +       int can_iif;
> +#endif
> +
>          /*
>           * Warning : all fields before dataref are cleared in __alloc_skb()
>           */
>          atomic_t        dataref;
> 
> Would this be a suitable approach to get rid of struct can_skb_priv in 
> your opinion?

Possibly a naive question but why is skb_iif not working here?

