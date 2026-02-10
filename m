Return-Path: <linux-can+bounces-6537-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO60LBSCi2m+UwAAu9opvQ
	(envelope-from <linux-can+bounces-6537-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 20:08:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B2A11E829
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 20:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95CF83010BBF
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 19:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E202ECE9D;
	Tue, 10 Feb 2026 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQCPP7XJ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91862301717
	for <linux-can@vger.kernel.org>; Tue, 10 Feb 2026 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750478; cv=none; b=lWSwDvVALxn4veYLCfWLB9WhJ+BpQDeQgTYP9QO5HS13ajRaK3ZKGfS9PXQ1+LvlGtRNJWxTNnTapuoN5u7RmNIMBdIqfCyJ84yXlNMmj+uppizddPCkJdJCDn+ptg0kIseksLf3RY6FUjd9/W23nGly8hrTHzSmZl+Iee2kVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750478; c=relaxed/simple;
	bh=gM23mulkKgK5S2op8Itw0uK9DZ9PqtdYl6JtxdlBWg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DY7ieR+65qweeLhSDRZIc+WHWrpUYLqAgNKaQ+ZpU2uMc4D5qlnz9NZ+AP0uXFVCIc11FQXTao9n50O4atVdbJdqqPC/UF1p7zc/XHq8DSl2a20fZfwic8LwS6v2s+0HL3DqiRALHCewOLEwNPUFQwNvN3Eg+GSawzvbD54YpSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQCPP7XJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88472C116C6;
	Tue, 10 Feb 2026 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770750478;
	bh=gM23mulkKgK5S2op8Itw0uK9DZ9PqtdYl6JtxdlBWg8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dQCPP7XJmiaWEY1XVe+RrwWZKp/W6ShJc+yxSr73AUQHBMtSoNVFYxIeSqmIIaqiR
	 714x5rCIJzo+1x4stYtlzhn2bI0GGUJS0/f8Pcn0USHn/NbVouhIYzjVK33GG6mwk2
	 YKL01y/3fCVch3TjW8bhctDNAHktjrk+XbgvDR4bvKK4iHeD2+tJZuXcMdNRmuyalz
	 jws/S/mwuG58C4QQqNQvdoQa++AUizKm98Qt9Lw1FlH/88NQJwYiJrtGCdDLtiuGfw
	 iCPHGog3LB9GDtKBIS5Q9bapj2FDLvWk9kiqCBPvv184uBRluNo01Mau9kPYyfqud6
	 0upu+igK8ks5Q==
Message-ID: <ff49fb08-f97c-449b-ab2f-7f10bf7dc1e9@kernel.org>
Date: Tue, 10 Feb 2026 20:07:55 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: can: etas_es58x: full cleanup in the error case
To: Oliver Neukum <oneukum@suse.com>, mkl@pengutronix.de,
 linux-can@vger.kernel.org
References: <20260210145049.40995-1-oneukum@suse.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260210145049.40995-1-oneukum@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6537-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42B2A11E829
X-Rspamd-Action: no action

On 10/02/2026 at 15:50, Oliver Neukum wrote:
> Memory allocation can fail in the middle. Hence the cleanup
> needs to be called in every case.
> 
> Fixes: 8537257874e94 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Did you see my previous message?

https://lore.kernel.org/linux-can/CAMZ6Rq+TtQnA-vvmfKhRftOuXyxWOPNZ4uH5ObT884OLDZHyng@mail.gmail.com/

Yours sincerely,
Vincent Mailhol


