Return-Path: <linux-can+bounces-4625-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D57B50FBB
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 09:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BC217B5F4
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 07:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53EA30CDB7;
	Wed, 10 Sep 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru+PpJXn"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051730CDA8
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490036; cv=none; b=JAbmlK0Xt0syMH/PFGlcS9Qa7OyLZ5F0cQex0xzf2ZAxcj3bjNUTEgYVMQQbfmkcT6BJj85ni55Yh+DtpxZKX2865IlnvL/ZhUwH2lJOPRz+S0/tucRRuTtSSLrSKEGAVVKotQi4KQeVGjcL5byVxCRUSdwY5EjMDJZ9eYJ3/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490036; c=relaxed/simple;
	bh=Ml8NTp7KsG8b6D9mcypD7vS7eJPxgdxlSH47q+uPPH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q9lcucaV3BWuXeb8itz7N8wPvhQk7NqmN0jYFS1dtQjJBeBwrQDFUn1bkBj+d6mwCPm1JaC1nqNOWzgwYE8GKZ3xZkWxIy25UBFBG0tUYXdLkKCxORxzkdhysi2updp/xhLyMzepHZ+qzKO9In9FhJPWocokbLfp7/akdY6YzKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru+PpJXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF1BC4CEF0;
	Wed, 10 Sep 2025 07:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757490036;
	bh=Ml8NTp7KsG8b6D9mcypD7vS7eJPxgdxlSH47q+uPPH0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ru+PpJXnupzh3oUAF9mFdWFXEMdGNR3Ffda8JnZLak6fcwJ/tT8kpcRKLHVbaj19j
	 7FTVVPZPOh8I1zC6Z0cLSMQjQt8VflvLwmOWvGKLUNQNvhf/EZXCh/MjS6fPrKeWsj
	 gqkksH2BXlvJYSLkVIjFQfDR1To8kFAHijt9yASGjcXuR0Z0ouDkQ1GLrgFw/19DLc
	 TXeHKpLedY6xsL/aQH/U+cEciVf8M44RqcxZ9o6uuMb5dqEGqKIx2+l+/A3FReQf5e
	 HpIpxn4N4WKpQbuF9aZROD3OrtXX4YgegcjVHAyTRjypBklkr6sm4RwN0kRIdDSWS6
	 vH3AfziHVxncw==
Message-ID: <552631f3-15fe-4bb3-a512-1eaca57be5ca@kernel.org>
Date: Wed, 10 Sep 2025 16:40:34 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on
 CAN XL interfaces
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20250909092433.30546-1-socketcan@hartkopp.net>
 <20250909092433.30546-2-socketcan@hartkopp.net>
 <f7b59c7c-30ad-4cf4-ad0e-bff0e39b3337@hartkopp.net>
 <7578f44d-d85c-473e-8e7a-65d1fc974e68@kernel.org>
 <20c5c885-0bab-4c42-82c6-e98571a5d19d@hartkopp.net>
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
In-Reply-To: <20c5c885-0bab-4c42-82c6-e98571a5d19d@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/09/2025 at 16:27, Oliver Hartkopp wrote:
> On 10.09.25 07:13, Vincent Mailhol wrote:
>> On 10/09/2025 at 01:36, Oliver Hartkopp wrote:
>>> Hi Vincent,
>>>
>>> On 09.09.25 11:24, Oliver Hartkopp wrote:
>>>
>>>
>>>> -static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff
>>>> *skb, int mtu)
>>>> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff
>>>> *skb,
>>>> +                      struct net_device *dev)
>>>>    {
>>>>        /* Classical CAN -> no checks for flags and device capabilities */
>>>>        if (can_is_can_skb(skb))
>>>>            return CAN_MTU;
>>>>    -    /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
>>>> -    if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb) &&
>>>> -        (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>>>> -        return CANFD_MTU;
>>>> +    /* CAN FD -> needs to be enabled in a CAN FD or CAN XL device */
>>>> +    if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb)) {
>>>> +        /* real/virtual CAN FD interface */
>>>> +        if (dev->mtu == CANFD_MTU)
>>>> +            return CANFD_MTU;
>>>> +        if (can_is_canxl_dev_mtu(dev->mtu) &&
>>>> +            can_dev_ctrlmode_fd_on(dev))
>>>> +            return CANFD_MTU;
>>>> +    }
>>>
>>> I've simplified the above code and rewrote the commit message in v6
>>>
>>>>        /* CAN XL -> needs to be enabled and a CAN XL device */
>>>>        if (ro->xl_frames && can_is_canxl_skb(skb) &&
>>>> -        can_is_canxl_dev_mtu(mtu))
>>>> +        can_is_canxl_dev_mtu(dev->mtu))
>>>>            return CANXL_MTU;
>>>
>>> We might also discuss if we create a can_dev_ctrlmode_xl_on(dev) function to
>>> check if the CAN XL interface has CAN_CTRLMODE_XL enabled.
>>
>> I checked ISO 11898-1:2024 again and the relevant wording I can found is in
>> §6.6.21.4.1:
>>
>>    When error signalling is disabled, the node shall transmit and
>>    receive only XLFF frames. It shall not transmit EF, OF and RF, nor
>>    DFs in CBFF, CEFF, FBFF and FEFF.
>>
>> TLDR; Classical CAN is deactivated when error signaling is off.
>>
>> So, I think that we also need the same logic for the Classical CAN. The nuance
>> is that instead of using CAN_CTRLMODE_CC (which does not exist), we can check
>> CAN_CTRLMODE_XL_ERR_SIGNAL. Note that CAN_CTRLMODE_XL_TMS implies that error
>> signalling is off, so no need for extra checks on TMS. This is what I have in
>> mind at the moment.
>>
>>    static inline bool can_dev_cc_on(struct net_device *dev)
>>    {
>>        struct can_priv *priv = safe_candev_priv(dev);
>>
>>        /* Classical CAN frames are always allowed on virtual interfaces */
>>        if (!priv)
>>            return true;
>>
>>        /* When error signalling is off only CAN XL frames are allowed */
>>        return !(priv->ctrlmode & CAN_CTRLMODE_XL) ||
>>            (priv->ctrlmode & CAN_CTRLMODE_XL_ERR_SIGNAL);
>>    }
>>
>>    static inline bool can_dev_fd_on(struct net_device *dev)
>>    {
>>        struct can_priv *priv = safe_candev_priv(dev);
>>
>>     /* CAN FD is allowed on virtual interfaces if it fits the MTU */
>>        if (!priv)
>>            return dev->mtu == CANFD_MTU;
>>
>>        return can_dev_cc_on(dev) && (priv->ctrlmode & CAN_CTRLMODE_FD);
>>    }
>>
>>    static inline bool can_dev_xl_on(struct net_device *dev)
>>    {
>>        struct can_priv *priv = safe_candev_priv(dev);
>>
>>     /* CAN XL is allowed on virtual interfaces if it fits the MTU */
>>        if (!priv)
>>            return dev->mtu == CANXL_MTU;
> 
>         return can_is_canxl_dev_mtu(mtu);
> 
> The MTU of CAN XL interfaces might vary.

Maybe this is something that we discussed before, I do not remember, but how is
it that the MTU can vary?

MTU is the *Maximum* Transmission Unit. I understand that the size of a CAN XL
frame is variable, but the MTU should be constant, right? Why can it vary?


Yours sincerely,
Vincent Mailhol


