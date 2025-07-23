Return-Path: <linux-can+bounces-4069-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E314B0F282
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E56C3B5CFC
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7644256C8A;
	Wed, 23 Jul 2025 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OzwacLq7"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A42E36E3
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274781; cv=none; b=Y7KOTYeU+JEVT7tyoUfUN+dH8Hzix4aKDPVs5i5N+VNRQ70pWkGvzviXtMTLkpeEK1WIRQq7WYEtAHV34nyD6JReQnC1sBr9TiH8P7kfH8aPIsX91jNXigGlhi2oePNAuScK+dxcn4ipqaWT+sc4YfL3Ce/8UhKHKTa0dbdK3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274781; c=relaxed/simple;
	bh=C2wIM1s+Co/zWZg266NQ4ae0L1dGIuAGNaaw/YsM15E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVtMpEZBy7zKBPNRwzIDQVNU5ZM95/o0ebTLFV6zQDGlRqVdzrjV76DpC4mwkiH4hyCZuAiJluEdbLPjvRCRi6gauis1aYegALxVO7btQL3tFdGWe0yQ1kEF15lan37pzR33aotHE9SMxj4BaZYed5U5F/1UY54oe0omxbO+xv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OzwacLq7; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eYrMubrZ8hFqEeYrNuLnsF; Wed, 23 Jul 2025 14:46:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753274775;
	bh=RUUGM/5WH6g2Aw1cSlyH1Wocp/hOkVJ7ktS0R0VzLGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OzwacLq7AhiX8uW6qBM5J233t3LTvdwjUkya5o4RZLEavy7XzUY0pbjKNZZd0/LSb
	 OD7QmYoI+JgAP5tuHz4OoGk2b07kNBfC5ChJKtfx7XDqKmjkiz5fNOIuvjJm0w+94N
	 vlaqc/F8eJav+5727ik8imdWv0350XUe8cAtPRHZO8Aw2BfBZw7ebQ0t9lIQH34Reh
	 kCGhz65MzNvoqJXaMHRNBbxvYTYnd4NTPhIV+nuP94GVij+u+0Vj8d5czckBBQCbEw
	 4vPDgFvlY2fD9X5vTTeDywKQQAAVCuzR7zEIIXEscnyn2VJ1Ue5Mul4ZrNapanrMxU
	 7HXQ/2CwD+k0Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jul 2025 14:46:15 +0200
X-ME-IP: 124.33.176.97
Message-ID: <fc2ba877-3bd8-4e29-9b78-12da68ad9838@wanadoo.fr>
Date: Wed, 23 Jul 2025 21:46:11 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] can: kvaser_pciefd: Add devlink support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org,
 Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20250723083236.9-1-extja@kvaser.com>
 <20250723083236.9-8-extja@kvaser.com>
 <642e30bc-b79f-4d14-b20f-141000939555@wanadoo.fr>
 <20250723-bold-partridge-of-agreement-5f7ce1-mkl@pengutronix.de>
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
In-Reply-To: <20250723-bold-partridge-of-agreement-5f7ce1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 at 21:36, Marc Kleine-Budde wrote:
> On 23.07.2025 21:31:31, Vincent Mailhol wrote:
> 
> [...]
> 
>>> diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
>>> index 55bb7e078340..34ba393d6093 100644
>>> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
>>> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
>>> @@ -13,6 +13,7 @@
>>>  #include <linux/spinlock.h>
>>>  #include <linux/timer.h>
>>>  #include <linux/types.h>
>>> +#include <net/devlink.h>
>>>  
>>>  #define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
>>>  #define KVASER_PCIEFD_DMA_COUNT 2U
>>> @@ -87,4 +88,5 @@ struct kvaser_pciefd {
>>>  	struct kvaser_pciefd_fw_version fw_version;
>>>  };
>>>  
>>> +extern const struct devlink_ops kvaser_pciefd_devlink_ops;
>>
>> Nitpick: I would rather like to see a kvaser_pciefd_devlink.h instead of this.
> 
> IMHO 1 header file is enough.

Ah, I thought this was added to kvaser_pciefd.c, not kvaser_pciefd.h my bad.

Let me withdraw this comment then. It is fine as-is.


Yours sincerely,
Vincent Mailhol


