Return-Path: <linux-can+bounces-4717-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A639B7ED59
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 15:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98D124E2057
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 04:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E393262FE5;
	Wed, 17 Sep 2025 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq2W9L30"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491422156C;
	Wed, 17 Sep 2025 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084221; cv=none; b=blhJ09QyEQoutrQG5RwVLktZN6B2w2Ru1anWp4wFIQ0se6VP94OFooI+uTgdiVI1gTdhRVTPd+QTypZAMgAgQHNZhQDBVWCpYPoZuMdwBj8kVQzWrdf4ntijrIR/+U5ZXXVlTCemk05UkayCbJARx3tDbg4iACpn/wgVDqabzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084221; c=relaxed/simple;
	bh=euatEuS4JOCf3MimDRThN1Ny67GVVL/UXJJE0AQfpuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8co/UBFNNDzB0X/RvSB6PnMEvOUfFlL9PiuiRPJ5Ox8K3lL+8/k+7B1qXW10mDcZ4+Ix3X1z1OYH6DwB/BMH6oh8vpar3qekV7h1n3qH6hG79dCGBWc1FIn8oFEWk34H/K6HeNH6f3mIYOxdJGJDSTwzdQGCmAEjjOEm54BJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq2W9L30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB896C4CEF0;
	Wed, 17 Sep 2025 04:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758084220;
	bh=euatEuS4JOCf3MimDRThN1Ny67GVVL/UXJJE0AQfpuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kq2W9L30A1Y3mTSW1xcz1qYO+dB3d7ld50Ej0BIRkOpSYyqOmt6ShTd9Nq/lgfbZb
	 y5itnC+JiHdyIWMW1h7yx7bl330zKA4B5lH7ZDuAzfrQ7Smac0fKIENJ9nP17KXObQ
	 TG9mvgfFWU1Tk7YzKla516VXSC2MFR5sO2vvw67WOpU+jqzJoKzvvhwTEu1ixkDUKp
	 Q+zFVxzJ0vvIrjIenyHmpgmJ7FncdmRqJeNjUbvtaPQS5lW9Myf+K14eLxHo7rSKoZ
	 FhZEDRm2XL8zL/tdPxCPuc1CQ+1pxtjFJ7vyd2odVeysgppuktaPMyJFddZbjtcEC/
	 rceMt6NdaPp9A==
Message-ID: <21193ce7-26ab-4c42-a84f-669ab57257c2@kernel.org>
Date: Wed, 17 Sep 2025 13:43:38 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] can: raw: use bitfields to store flags in struct
 raw_sock
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
 <20250915-can-raw-repack-v1-2-5ea293bc6d33@kernel.org>
 <ed2a1b51-782b-4ee1-be75-06a0a742525c@wanadoo.fr>
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
In-Reply-To: <ed2a1b51-782b-4ee1-be75-06a0a742525c@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/09/2025 at 03:35, Christophe JAILLET wrote:
> Le 15/09/2025 à 11:23, Vincent Mailhol a écrit :

(...)

>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -87,10 +87,10 @@ struct raw_sock {
>>       struct net_device *dev;
>>       netdevice_tracker dev_tracker;
>>       struct list_head notifier;
>> -    int loopback;
>> -    int recv_own_msgs;
>> -    int fd_frames;
>> -    int xl_frames;
>> +    unsigned int loopback:1;
>> +    unsigned int recv_own_msgs:1;
>> +    unsigned int fd_frames:1;
>> +    unsigned int xl_frames:1;
>>       struct can_raw_vcid_options raw_vcid_opts;
>>       canid_t tx_vcid_shifted;
>>       canid_t rx_vcid_shifted;
> 
> [...]
> 
> Hi,
> 
> just in case, it looks like bound and join_filters could also be defined in the
> bitfield.
> 
> just my 2c.

You are absolutely right. I will add these two to the bitfield in v2.


Yours sincerely,
Vincent Mailhol


