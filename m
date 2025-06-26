Return-Path: <linux-can+bounces-3907-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39479AEA212
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0484E4D5C
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 15:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6BA2F2C61;
	Thu, 26 Jun 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rUAEo/aO"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3652F2C68;
	Thu, 26 Jun 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949764; cv=none; b=UBjAKL+RYnNSnlYBoqPN0dGBU9lkQecfGoAIOVczFlr+dEEOO3OIEkzQTt+Gxw9XZxMSzt41GWjnPtFIY6aXEgqRd0UPMCA+Zc8CSd7siB4l96cMWM2Ybk+str2gSCOAOriZGecDb/nnT3ClT9MTTuSFqRFhNdWd2b4IGlqri2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949764; c=relaxed/simple;
	bh=+l25+Op5jJAkjiBkLDfgy+PH6MvcCFhwsbcfAsrGjLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5KMIcxGcAmAovMoWAy7DoV97Opx80mjcnhdACELAmVkjGGgoCXgpMixSk/17/ahqJNKZ5+vgc9lQQP3R9ninlGr2BA+OYHgvRvslqxX1SE1UZb9vcnx6Wf7wch4zQkK/JWa+8urC9yZ6QI37vMOqfSoqKNwnQXg2TltoS76w2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rUAEo/aO; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id UnsNuEGNIyAmSUnsOuG3Rz; Thu, 26 Jun 2025 16:47:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750949220;
	bh=m8PuYT5ontmtHo/xXQjB2LiSJfjPbmVQ8L3XGrqt1rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=rUAEo/aO6tk0GIB73NQPKJWG57JZhvmpEwDDcB52Ty6TtXe+3jT0nO9MxmVMNQxh2
	 Gjmqih+uLkn1iE70COh45OhmQ4rQNHdBo9w0ckgKr3Z1jVJtFGhMtmoSgsKoJjZwpd
	 yyIYz75xRdwmFcr8MzqkUsKQixKVzFMEbyBvQTTpMFn9wlEZDwEeCHQ+tusiOGAAoV
	 RchCUfr2/Jgf44ZIZU5rCoI87ohx5+pvNkVzC4+cr/BfgLId+GfrFC8YsWx+Nb9Jg6
	 tChtChdyjmuPHZk5YZX/4UJbQ9Lvg5KUNi02DNx+fzfTAD8SD2s31lW2X2xAtOSSfZ
	 kXPlkEEm1QoGQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Jun 2025 16:47:00 +0200
X-ME-IP: 124.33.176.97
Message-ID: <d2447a4f-abcc-4d97-97d9-85737dd954c5@wanadoo.fr>
Date: Thu, 26 Jun 2025 23:46:54 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: m_can: apply rate-limiting to lost msg in rx
To: Marc Kleine-Budde <mkl@pengutronix.de>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Fengguang Wu <fengguang.wu@intel.com>, Varka Bhadram
 <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>
References: <20250620-mcan_ratelimit-v1-1-e747ee30f71f@geanix.com>
 <d855c26a-1982-4fc6-9333-93df4a5a98d9@wanadoo.fr>
 <wldhiihvxg42yqaccizms4xfupfv2c7w7jec7jy6iht6dbnr7k@os6f2gyrr45m>
 <20250626-rigorous-gentle-foxhound-d864c1-mkl@pengutronix.de>
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
In-Reply-To: <20250626-rigorous-gentle-foxhound-d864c1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/06/2025 at 22:57, Marc Kleine-Budde wrote:
> On 26.06.2025 13:45:09, Sean Nyekjaer wrote:
>> Hi,
>>
>> On Sat, Jun 21, 2025 at 11:13:33AM +0100, Vincent Mailhol wrote:
>>> On 20/06/2025 at 19:00, Sean Nyekjaer wrote:
>>>> Wrap the "msg lost in rxf0" error in m_can_handle_lost_msg() with
>>>> a call to net_ratelimit() to prevent flooding the kernel log
>>>> with repeated error messages.
>>>
>>> Note that another solution is to simply remove the error message. The users can
>>> use the CAN error frames or the netstasts instead to see if lost messages occurred.
>>>
>>> That said, I am OK with your proposed patch. See above comment as a simple FYI.
>>
>> I'm up for both solutions :)
>>
>> @Marc what would you prefer?
> 
> If it is my call, then make it a netdev_dbg();

I am also OK with that :)

Yours sincerely,
Vincent Mailhol


