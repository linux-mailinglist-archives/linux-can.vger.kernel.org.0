Return-Path: <linux-can+bounces-3613-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59602ABF3EE
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 14:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17473A39A2
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EABA264FA6;
	Wed, 21 May 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="nZQf6y2D"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F342221D8D;
	Wed, 21 May 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829678; cv=none; b=IH/DURN40t3/MoowjpMS4JBOKsqn0wk1A+vhJKPIoLUbjQ7dnivnSusLIkhm6O8/YKC3RGI1c86Qrb/7tYrxEH+NwVwmROkpgH20cgFi1C9f/snGQvSrVYtU2zRUloL1lHJ6voPUxgm1tl6JqZ83JmgV3q5OKSfthD1vGxeiWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829678; c=relaxed/simple;
	bh=jYHxqaFVXTDmKACrAKeH0s0kCrj27dHQEfoqXdtAXUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nu85Oy9unGygR7qKAJ3TA27MLCi0mcamiameOTYC+93LyF9MIe1rYUIaDqHm0uR+VVNqc2Kb/qNH1h5Qt+5CT3fgb+x5GcT9H4EEVOSEPC145IxGKZMubaCTS1T4KStFXN6WKdOyV0tp3i7hjwwlERdLQhi0/hRURsK8ieU/0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=nZQf6y2D; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id HiL5upFGFAiZ4HiL6uxpGd; Wed, 21 May 2025 14:14:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747829670;
	bh=h4DcQovfptu9scaQr7PaHj5iQU+exolK1M2m9CxTu/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=nZQf6y2D9LdRMhuRpaHzIUT7eBzs+pTIxOEETKcmQB+IM1cjnUGtTGG31Us9qS2CE
	 iNjAuwvHpRBx2qxuT4BcIF8zFGAityzIKUtCGyFATHuaETYQABqCBAIpwhFeAPWctx
	 C/ZpE5w1g6eCAG3VUXxGLI0GPRgZ5MxmAENNw+vQEG9ebaFwdbpAdkkevqNajfx+x9
	 T0KmS3eJgGcmF9CXh486kOtvPxIVJFX5O7hAlbHSiG7YLuhOpRNvAqqXCEf+KA3fv7
	 v+SlST8nbqr70CS6MDbM44NMqqnr/+vWAIBYhUFuHIm+v46292/SmMOsw6bMWJ8WMK
	 2ulIavhb5cUZA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 21 May 2025 14:14:30 +0200
X-ME-IP: 124.33.176.97
Message-ID: <4b5e3351-9435-4d4c-9553-98b7d0112fd8@wanadoo.fr>
Date: Wed, 21 May 2025 21:14:26 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: dev: add struct data_bittiming_params to group FD
 parameters
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250501171213.2161572-2-mailhol.vincent@wanadoo.fr>
 <20250502-scrupulous-sunfish-of-attack-ca0160-mkl@pengutronix.de>
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
In-Reply-To: <20250502-scrupulous-sunfish-of-attack-ca0160-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Marc,

On 02/05/2025 at 21:34, Marc Kleine-Budde wrote:
> On 02.05.2025 02:12:10, Vincent Mailhol wrote:
>> This is a preparation patch for the introduction of CAN XL.
>>
>> CAN FD and CAN XL uses similar bittiming parameters. Add one level of
>> nesting for all the CAN FD parameters. Typically:
>>
>>   priv->can.data_bittiming;
>>
>> becomes:
>>
>>   priv->can.fd.data_bittiming;
>>
>> This way, the CAN XL equivalent (to be introduced later) would be:
>>
>>   priv->can.xl.data_bittiming;
>>
>> Add the new struct data_bittiming_params which contains all the data
>> bittiming parameters, including the TDC and the callback functions.
>>
>> This done, update all the CAN FD drivers to make use of the new
>> layout.
> 
> Thanks for the series!
> 
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> ---
>> The CAN XL series is still blocked because of lack of information on
>> the PWMS and PWML calculations, c.f.:
>>
>>   https://lore.kernel.org/linux-can/68e8c449-a6ab-4958-af3c-852ece2694c2@wanadoo.fr/
>>
>> Regardless, the above patch will be needed at some time. And instead
>> of constantly rebasing it, I would rather have it merged early.
>>
>> The other CAN XL preparation patches target a smaller subset of the
>> tree and rebasing those is not an issue.
>>
>> ** Changelog **
>>
>> v1 -> v2:
>>
>>   - add Oliver's Acked-by tag
>>   - rebase on top of:
>>
>>       [PATCH v5] can: mcp251xfd: fix TDC setting for low data bit rates
>>       Link: https://lore.kernel.org/linux-can/20250430161501.79370-1-kelsey@vpprocess.com/T/#u
>>
>>   Link: https://lore.kernel.org/linux-can/20250320144154.56611-2-mailhol.vincent@wanadoo.fr/
> 
> As "mcp251xfd: fix TDC setting for low data bit rates" will go through
> the "can" and "net" tree, we have to wait until "net" is merged back to
> "net-next".

That commit now reached the net tree. Do you think that my patch can now be applied?


Yours sincerely,
Vincent Mailhol


