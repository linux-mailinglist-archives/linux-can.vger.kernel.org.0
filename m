Return-Path: <linux-can+bounces-3603-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C73ABE008
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 18:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CBC1BC0200
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAA926A1B9;
	Tue, 20 May 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Zcimjkv5"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F7268691
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757340; cv=none; b=fN5LzPLGcjyHuZF+tEVDPAxxvN2q3omtuEZ96UF4pb8ghF66OUUFZWAWSuyWqmHDsQnj4vOIhoTeWKnbt6z5hHvDpa94ZBh0PYaZZWZMbVEnhPQXDUyOYlBJvDPHFx37OHyLglaPmhTpFaWXGydJtQLO/GQBJuX6H+QhUrrYOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757340; c=relaxed/simple;
	bh=OPl7CH6F3U8B91TAfz6DCj28TFQl4WKQxKHfavFCzdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRFbyUurg/OTcjoKYDvsS3XE0XTJ7YWfLBg0RtbzmjsaF21qRC/ufglfvo8UbWwMBb7JUwPS4j8GvgU+Bzi10SZr954UJNUr/luFWYzamjFvGgA4TWml4p2uTUHqmA1327WufG+ai/+GdNvFAw/3oqM2NIDDSkmXFOS8Q5BV+pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Zcimjkv5; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id HPWPuA3tlFfBZHPWQuCy7v; Tue, 20 May 2025 18:08:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747757336;
	bh=lVJBeyZnT3Y+pShmBLunxP0Mw5a8lA5ymsWzCE8fswI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Zcimjkv5R7EA8CmLx/80i8579w36OF8Wptuq2Gi3ZIWkptdREG5gRwqUDs1fvktZn
	 GH7oUyPN9ICvPVBmyrGrWjmUUFLlaEJkoCNu+fazzSTfsN3U0TyrhJMZPdePb2Uk6I
	 O9d81MeUypYzkNfn+jUY3LVT50XPkrjyNWpCHl3jPmNaxvnmENuo0T0npBlJnrN0h/
	 ueyUya5AQvCmOZ0WW6uclF7ARDGp6KRKEYr3IKQ47bp3wGWfSW6SLLZ3/Sa5BWmf1H
	 zrrVciiLmTD28JHazwsEdumR/4cIw+tvWzceNk9L9YbPu8FkIgzNiB9/kyAXG0CPTS
	 vcaZqhdU13u0g==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 May 2025 18:08:56 +0200
X-ME-IP: 124.33.176.97
Message-ID: <f4e376cc-4c78-49ab-a123-8553845a4a2b@wanadoo.fr>
Date: Wed, 21 May 2025 01:08:52 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] can: slcan: allow reception of short error messages
To: Carlos Sanchez <carlossanchez@geotab.com>
Cc: linux-can@vger.kernel.org,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
References: <20250520102305.1097494-1-carlossanchez@geotab.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250520102305.1097494-1-carlossanchez@geotab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/2025 at 19:23, Carlos Sanchez wrote:
> Allows slcan to receive short messages (typically errors) from the serial
> interface.
> 
> When error support was added to slcan protocol in
> b32ff4668544e1333b694fcc7812b2d7397b4d6a ("can: slcan: extend the protocol
> with error info") the minimum valid message size changed from 5 (minimum
> standard can frame tIII0) to 3 ("e1a" is a valid protocol message, it is
> one of the examples given in the comments for slcan_bump_err() ), but the
> check for minimum message length prodicating all decoding was not adjusted.
> This makes short error messages discarded and error frames not being
> generated.
> 
> This patch changes the minimum length to the new minimum (3 characters,
> excluding terminator, is now a valid message).
> 
> Signed-off-by: Carlos Sanchez <carlossanchez@geotab.com>
> Fixes: b32ff4668544 ("can: slcan: extend the protocol with error info")

Thanks for taking my suggestion and for removing the magic numbers!

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


