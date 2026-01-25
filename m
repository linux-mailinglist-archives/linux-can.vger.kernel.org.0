Return-Path: <linux-can+bounces-6297-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGZaHsJvdmnyQgEAu9opvQ
	(envelope-from <linux-can+bounces-6297-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 20:32:18 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3BE8234F
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 20:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A543B300D910
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6D32F745D;
	Sun, 25 Jan 2026 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shtE3Y4Z"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51525228D
	for <linux-can@vger.kernel.org>; Sun, 25 Jan 2026 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369517; cv=none; b=WbEfW0aUiJIQTCTGXeke91ZHWKOT0wCbsNh9205CSDNBkVzfWUT7dHPAnMov0SarJToJncLFW85lXWuDxCxRFoXA7PHfcmmQJcJkytffT//MoMhw2584s/eMFLK0cs3RRqDg+m4mwaUw0OjcuYUYsvSYCQL4bXQDljXOz7169xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369517; c=relaxed/simple;
	bh=RtLimdViGHyHbvLW0327ccp0gvMCAQossj99eq7Uj1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I36CXOM0QvbHDZPicPKLRx6kIbsugh4Iy6Fkl5F/E8/5EPsjYnYGicdc6Fw/OvZF/5IrA6xiLLydaw3mAZerkAX0LkpCy2uy9WYwtyfJHPoBvdsQj+8KlMRY7S9FXiHjvvKyVtZVzlMiEjMjEDbf/jyVssuJcVwTmMQurl++aVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shtE3Y4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94423C16AAE;
	Sun, 25 Jan 2026 19:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769369517;
	bh=RtLimdViGHyHbvLW0327ccp0gvMCAQossj99eq7Uj1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=shtE3Y4ZnUXp6CNi3s4J+VJGLdpB48LLVoojzn9fcqYn9p5ClIBzAEChGz4Bqah/e
	 DS7mSsfebQDJbYxgK30mOA8ObrKMOMJlER31N+PAGmAq9eu+nBPKIW8TjixmE/Tj8T
	 D0mYKP2/SWz6/hgFJJsAC5DW9G9dHn+ynjLL/cMAfIPH0Nh8DSJsr2sSiSS7cbZ0Q5
	 MugbaBB8O1zBTzfhZY04ZJktqztVq5KVQ4lXhox3Um80qUKrz9M6sRxaHi9uBzi+61
	 2WMqeFfosNp8U6bR+yFXHYsePO3XBy48GTYwoG0xteqWza9qSNg/TsFFUKWjEZ6sMP
	 zPCWju/p6vbXg==
Message-ID: <4abee297-26e9-48f3-8ec6-2d99ba1f1839@kernel.org>
Date: Sun, 25 Jan 2026 20:31:54 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dummy_can: fix packet statistics
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
References: <20260124211704.16430-1-socketcan@hartkopp.net>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260124211704.16430-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6297-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB3BE8234F
X-Rspamd-Action: no action

Hi Oliver,

On 24/01/2026 at 22:17, Oliver Hartkopp wrote:
> The former implementation was only counting the tx_packets value.
> Adopt the skb handling from vcan.c to correctly count the statistics
> and fix the packet flow for looped packets.

My intent was to have the dummy_can's xmit() behave like the other
hardware interface: just have the echo skb. I am not sure why a real
vcan-style loop back would be needed here.

That also means that dummy_can would never be able to receive a packet,
but I do not see the issue with that.

> The CAN echo support (IFF_ECHO) is enabled in dummy_can_init() to provide
> a more realistic behaviour of real CAN hardware interfaces.

Ack. The IFF_ECHO is needed, otherwise the echo skb is discarded right
away and the tx_bytes are never increased. Actually, this is not the
only driver which forget to set up its IFF_ECHO flag.

So, for me, the fix would be to just add the IFF_ECHO. After doing just
this locally, the statistics behave the same as with my real hardware
interfaces: when I send a packet only the TX stats are increased and the
RX stats remains unchanged.


Yours sincerely,
Vincent Mailhol


