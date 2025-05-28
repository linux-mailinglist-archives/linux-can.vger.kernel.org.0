Return-Path: <linux-can+bounces-3719-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CABAC6D50
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F861BC7D4A
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACED28C864;
	Wed, 28 May 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VmdQVMfT"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EECF1CEEBE
	for <linux-can@vger.kernel.org>; Wed, 28 May 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448014; cv=none; b=tn929Hk+uzIjLFCdn6D5nEhnk3RpcLocdmyPaPYiFv04Du+/L4/IYZnF8qrgDpx7M0VmbkZM9roIEzrBsGbzWmNLRYw0Aazk46MkSJfcl8sYTVjXffoC2zF4/Lw7SlkQencZ+EQSeJSDqgRsf23Ch+6gAZlJUhH5rmZVDIHO3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448014; c=relaxed/simple;
	bh=eXMyyRxWdSott2TwTU/40dA7mPE3CVZO3Y+Pn97FM/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjNFx3u8MQ5P6XitemLdv/DkMAGxITXEb0V6WKXXlntY+3VJleJxrtTqBzfsv/dMRfi3MpIPoztX4zgAvPzhLCNVIbobca15vn9b+gfioG4eDvd0HnCQWAAYZqHKASvfpU4qUiVMmKr1oJbU+5abX5E8yKSgX0iO6Hh+8LDF0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VmdQVMfT; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id KJ3hu3EOrrkFfKJ3iufvn5; Wed, 28 May 2025 17:51:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748447476;
	bh=c+S4JOjB846XczA2l0HRGp3x1Du6NgVlTd5RLGDx96Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VmdQVMfTGvoK75LkeB/f5hbs0VoAEWMwADbn3xiNUchJxx4inBk8BfGhjtbPVsdb4
	 LgnVsrz7yaEVfAnt3lzuxZXGtyh2tJd47uKA7tagklJYV0R146TqS/hNGvxWo62YtN
	 Bv7nkuka45MEwPArHxJs6cZk+78iIJHTZU5cEmW5rAXY4dMPhnSRBVBd27QlAhOKR1
	 RoA/7Aj26jcl0TLJPOMLIbuvIBbS/D4Lwqzj8iBQLC5gyoL3noVMkiwRsQECdLA02t
	 sWwiLQAd4nXOUPuG2A6BULycLy2zX1cJj+LST+5KoT7qL7pYgyHdokoUpK61MHsvha
	 jLK4NqtVdK5Hw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 28 May 2025 17:51:16 +0200
X-ME-IP: 124.33.176.97
Message-ID: <77c5a904-8b2c-4a78-890d-2777ddefe250@wanadoo.fr>
Date: Thu, 29 May 2025 00:51:12 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-2-socketcan@hartkopp.net>
 <20250528-quirky-ultra-hawk-37000f-mkl@pengutronix.de>
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
In-Reply-To: <20250528-quirky-ultra-hawk-37000f-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/05/2025 at 17:47, Marc Kleine-Budde wrote:
> On 27.05.2025 21:56:16, Oliver Hartkopp wrote:
>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>
>> commit cfd98c838cbe ("can: netlink: move '=' operators back to
>> previous line (checkpatch fix)") inadvertently introduced a tabulation
>> between the IFLA_CAN_DATA_BITTIMING_CONST array index and the equal
>> sign.
>>
>> Remove it.
>>
>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> The patches 2...5 look good to me. If Oliver adds his S-o-b, I can take
> them for linux-can-next.

If you prefer, I already submitted those in the past in a dedicated series with
a proper cover letter:


https://lore.kernel.org/linux-can/20241112165118.586613-7-mailhol.vincent@wanadoo.fr/

Because I got zero answers, I split it even further. This is why only one patch
got merge in for 6.15. I was planning to resend those clean-up patches anyway,
but if you are OK to take them directly from my previous series, go ahead.
Nothing has changed for these since November, except from the first patch with
was merged separately.


Yours sincerely,
Vincent Mailhol


