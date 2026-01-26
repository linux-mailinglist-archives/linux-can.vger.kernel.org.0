Return-Path: <linux-can+bounces-6310-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNg4A/q0d2nKkQEAu9opvQ
	(envelope-from <linux-can+bounces-6310-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 19:39:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5EF8C27B
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 19:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ABB230107D7
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6E2367B5;
	Mon, 26 Jan 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgbXkuTy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5FE29A1
	for <linux-can@vger.kernel.org>; Mon, 26 Jan 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452790; cv=none; b=ROI36z9nt/YsLzut1iTLHOagrSCUuS551/XdCFwP56ylhdtYH/RNn8pYXPDZYASbwTnr62g9UMonO5Du9Hsxqo4DIO7MxmH6p9CBpwXsoyGo2cO0U0w46G4TJ6F+/oLXQxduVmmc2aDZxXRGkI8UWuy3ihxkSxqgp10bC2gW8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452790; c=relaxed/simple;
	bh=kSO0AThG3oYr+/FQYaVQPJPjbVZUHwsGousW8FtfYSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hrJIKNmS1f70ktqa1EYsDuTE6ax6twUBUNRcwZMzer+96dybH4jx0ZeBRKF31UiZRCn7nEIt8dA2mJkceOy6rya/va1FhSU/Kzfno05Xi4ws+AL2UI10/CiGHmFJXW64I9ajVfYzPWrA2CDwnzABJa8HHN0XwixaIE8iy2/PQP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgbXkuTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD6FC116C6;
	Mon, 26 Jan 2026 18:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769452790;
	bh=kSO0AThG3oYr+/FQYaVQPJPjbVZUHwsGousW8FtfYSQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lgbXkuTyQBOVuVeH0M/t7oINf2eMULHKu5t4+VP6dKrDWt7lm4WWS4l1KahLNhnCd
	 FBLL2SlAhFL/YpSNO/a1UWjYn4RHu/AsFm4qi5MlaoeQ5jg/71L/LT3cqWiZSuFRyk
	 x8+6cKWsBYb4DAdTU7wc/76AKYwr4NJtJxdoS8wvX15Njg+W7pGc+k7rcLSpEy7vCl
	 QkY9NZ9DfY3wELFLOUnAtu9HEV8K4lWJ86zcR2LuCS8ZYTUUUck9iVO48eFX6F9xGg
	 NlpVJWzFKlnAuJILyfICdU8exHuq91yxHUksOBNzc6rQMi4DhrTf3GCg+Lvd/yjp0a
	 dIXDBbfNc/ITA==
Message-ID: <dcd84641-e4bc-405b-ad0b-03dd60fd9e9a@kernel.org>
Date: Mon, 26 Jan 2026 19:39:46 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dummy_can: fix packet statistics
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20260126104540.21024-1-socketcan@hartkopp.net>
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
In-Reply-To: <20260126104540.21024-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6310-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A5EF8C27B
X-Rspamd-Action: no action

On 26/01/2026 at 11:45, Oliver Hartkopp wrote:
> The former implementation was only counting the tx_packets value but not
> the tx_bytes as the skb was dropped on driver layer.
> By enabling the CAN echo support (IFF_ECHO) in dummy_can_init() the code
> to put and get the echo skb is activated and the tx_bytes are counted
> correctly.
> 
> Fixes: 816cf430e84b ("can: add dummy_can driver")
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


