Return-Path: <linux-can+bounces-6336-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Eo9IY/0eWn71AEAu9opvQ
	(envelope-from <linux-can+bounces-6336-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 12:35:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 057B3A0838
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 12:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4771C300EFBE
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A434C2DFF19;
	Wed, 28 Jan 2026 11:35:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9E28CF6F;
	Wed, 28 Jan 2026 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600139; cv=none; b=B9niAdzXiBqKtfcASSaHwOZmhIGOUgEMH7I0eROKZMZfO9hDT6lsXO3kFhcpM9fnLYjCTwzctGCWzdRFvsvJxIFXJucHD1of+6Hijwb3GxMKXPuw49PIOGf/+CGNqPQCh1xkgRH7goG05G6Fh9r/FHMEb9KjtEO7fShtuM+4zq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600139; c=relaxed/simple;
	bh=TYRNjHwoPRm01+rAWATcjLjhB2x+k95NwhkoIIYfsGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCWOjxpnz8r6FdkseJ/Tj9Jj+Fj0CqPCQXcRzBXVNKuw4Oj4tI9xjB2cdvHXely+MKEp1SVN0HGqM7+0U+rflHDXdoUCKfhVvIvSPmhSWE/iClhcZ8hJDX7dYc6FgYakTMZd/PpUSl4A1skgkeqZjsQmlWkMV+GfsaJhWy+y5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 793A860516; Wed, 28 Jan 2026 12:35:35 +0100 (CET)
Date: Wed, 28 Jan 2026 12:35:36 +0100
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
Message-ID: <aXn0iLuRqdOdcIBN@strlen.de>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127174937.4c5fc226@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6336-lists,linux-can=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Queue-Id: 057B3A0838
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> wrote:
> This is fine. Wish we could make md_dst work, since skb_ext still burns
> a bit in the skb (last extension bit in fact, next user will have to
> bump the filed size). And you very much do not route these frames, 
> so dst would work perfectly fine. But whatever.

An alternative would be to 'union' extensions that cannot be
active at the same time.  Something like the br netfilter extension
for example.

When the first extensions were added all of them could be enabled
at same time, but I think that has changed.

