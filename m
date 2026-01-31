Return-Path: <linux-can+bounces-6421-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKLjJPxdfWnKRgIAu9opvQ
	(envelope-from <linux-can+bounces-6421-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 02:42:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2972FC010D
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 02:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 657F4303CD3A
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 01:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FAE328B56;
	Sat, 31 Jan 2026 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBZaZRpa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A3325709;
	Sat, 31 Jan 2026 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823672; cv=none; b=qdNYR4H44Bbwx7b+ov+TE8zdJpu4F8Vm0MhwRvW5L5E0II0JVYibFimU0kjcd9nuDdluKJYyE7bw4Ewu8yTuk65rQEIvAMSBRcBBeZV0XYh4rAFQE9m57Lacw6XKXzyzRRr7UDpUTVj/bKOC0AF64y6pEbdzmuWYt8sI5f36axU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823672; c=relaxed/simple;
	bh=IAIz2pc+uWTbtTKWiVwVS/Tn76PqTJuOp0wXIXWwum8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDYaR4Kn+sGPltBWErkFNFcLXut5OXi8MUnrKj8txSPqt1JGBK+J/D4ILyebHgDzWX///QAmw+Twrk3Ok3E5RdHu2gjIeRhGzXmoEXuJgy/7jbowFRLnZpGzPvfUkA7T7jz/iHOfIcf7K74dG4xS4wnQX7diwrDbicJAxkm4oz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBZaZRpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F8AC4CEF7;
	Sat, 31 Jan 2026 01:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769823671;
	bh=IAIz2pc+uWTbtTKWiVwVS/Tn76PqTJuOp0wXIXWwum8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KBZaZRpa9d4108OVtax15lig4xF+9mNVarFiuop4te/FvyY67Ee4C2yHUGbyJ/48q
	 al9/DF5ejk1wv7iGnY78iKGlUw91slYww3n1nXestA9urvpDk73jzuWZ0LsO+TTIIB
	 X0aU5MFLbN3gVONvOkXPtjedmjU2SzHTO5gqJfOX9YGAk4g+KNolqUGx5msefQSc+p
	 yuXO8pI+tPRUNFV30BH1hnIwYRLnCsGQ0WcVw5VvNmiVN6LcsTxCuEPFAQDXW8Q1W1
	 5778tTz5T+3vHOEYdWEzWGYmhLn44MDuZwfYJ16YP/6PW7pvJAEYECDAYCAlgXWPKh
	 LK8CVQ1ns+N+Q==
Date: Fri, 30 Jan 2026 17:41:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Robin van der Gracht <robin@protonic.nl>, Oleksij
 Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 6/6] can: gw: use can_gw_hops instead of
 sk_buff::csum_start
Message-ID: <20260130174110.1c552bf7@kernel.org>
In-Reply-To: <93d61e1c-5cdf-498e-8699-43e57cbb221b@hartkopp.net>
References: <20260130-can_skb_ext-v6-0-8fceafab7f26@hartkopp.net>
	<20260130-can_skb_ext-v6-6-8fceafab7f26@hartkopp.net>
	<93d61e1c-5cdf-498e-8699-43e57cbb221b@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6421-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2972FC010D
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 10:29:37 +0100 Oliver Hartkopp wrote:
> I'll wait for a respin until tomorrow.

FTR 24h means 24h, you seem to be reposting "tomorrow"
before a full day has passed.

