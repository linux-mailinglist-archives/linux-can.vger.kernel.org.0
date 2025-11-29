Return-Path: <linux-can+bounces-5773-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF6EC93E57
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 14:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1B3234617F
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69A2189906;
	Sat, 29 Nov 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="beR4eqAv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Q2WycPIR"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A97288A2
	for <linux-can@vger.kernel.org>; Sat, 29 Nov 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764423859; cv=pass; b=Jrd94XEpCyIOQSwXgLt5ylvjikGzTeE7QHkLgIwwkJQYv4pEyhPDYDmkjnHtC2SgC6yIKryZUOPYXTQStD6RorZZe3IiMdnEAGtqMddWel3OUEj9gz29fKgLoBfXKdVr+iapL9IyvanEAvce3TwghXl8oAZ3Awb1vI307xaUqY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764423859; c=relaxed/simple;
	bh=9LB2XBPbGJIw28UL9986Zihq19GMIDQkfCuraD/1YPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfisGswNDISZYhJEajk8e6VX6zYp4ghdiJ4SlAU5caPFQgKt9w1iOnwLRhvtP7J9h7zWtutdRkFjCA0AeX/VkgeZNs4ISzWz8Rvg95ZFhFtzsL/gOYv+enFaHgx5YPvA01RSu3lXwjUVr1iR6QTVjikDhrHgq2b9ngzdoqz7wEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=beR4eqAv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Q2WycPIR; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764423848; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Yy7cfU/CY+Rb3dtvIlo8udVsyF9BG8+sdEZtMODVMbC2ShQNp4XmsEsnWKP6FCs7dG
    k9gLUvbXmTnuHoyNMnPx/MzOrhIYssOWIFSxi1K5Ye4JuOWEcMdL8Ea5Y1Ncf+KFOWXU
    mqKeN9+RbAuDcZFL+NMda8TG4Yy9R81jcqlbrmHo5tK7GpF9erO0/SDCS4YPfxRPNzSQ
    quXl2E0N+ppYjGw80yGRG3BrRQFSMChocxTO9n3oIaa0+ILNd+W0osdWiXLQPOM+aj7u
    6TRjCbeKbey7uabuP0ecILLj72dgsiXYqr+AZnL2NsfgTLoMNLkTfP5nP7TY390M3X3R
    31Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764423848;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XnfVwgMlURsXf4Z8Q2dqv5ZzESLUAxF1DEYhb2lbUf0=;
    b=OK2EFgqck23DN88iHgL5Ir9ksNA3jasatiy8r7GdjZWrJiunNbE12BrcGi4z9U5o7E
    H1W2ANNzRIimD24+VyxlkAFu+mjFGgNHi/hWvHYBmwfP7VB8HJPUYfl6iTc8kTLSiNEz
    NM1pmvTzdQc3HgyNVGiaMsAMAWQ7750V8Oec7R8awzsNz9F4+X392oA5I29iTmhNRuCl
    e4qfvFtjJIvnrG4+wC2mPeXd9dN18DApwYlIZi97J1PPoDBavD8zvbLTLlE7RTbVKonc
    uLP7nz9wopTPSVtLasA7rD+pyxRk2Dggbpbzx76UnXB5iZum0Pui4ybpTR9FtGk00H+Z
    C5KQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764423848;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XnfVwgMlURsXf4Z8Q2dqv5ZzESLUAxF1DEYhb2lbUf0=;
    b=beR4eqAvOO7vkFkxomiVLJai0LRUevAQOGUBLlGGEZSvszcaSuO5FFSoO0DpBr90BS
    RnSoCrdQZmZ4bb1kk/ZiZF+eqbyb/YybHOWV+lN8GvHXEjd0MYPHxhX5SUXtcRVRslm+
    y3pWOA4jkQMeCv5hXh3n0LF91byTSFIRAPWmWI+6s0dn66cmls8kG8P+0TQBxeA8Xm+Y
    VugHjS0fhIPWoLB+bD2QhmZqETiURni4Vx+Oawy++RQoV+IBbn/GQddbwkDLfqn2Kj4a
    F/2t3K4rzRHDAng6wTpfaves5CPaOtvAfIM/oTAZRc6oUL3pTiplCyOSCLX/sTc5m/t4
    WGEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764423848;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XnfVwgMlURsXf4Z8Q2dqv5ZzESLUAxF1DEYhb2lbUf0=;
    b=Q2WycPIRI77Uf4HXaOFDm2x59+nUnk8xZXrw0MGvh9vnnlD6PU/n+L+0yciygo8hiM
    KwqMvykvTqOm2UkakjAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ATDi8jIN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 29 Nov 2025 14:44:08 +0100 (CET)
Message-ID: <b4b90146-cd65-40f3-a3ce-038123f63e71@hartkopp.net>
Date: Sat, 29 Nov 2025 14:44:07 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next v3] can: Kconfig: select CAN driver infrastructure by
 default
To: Vincent Mailhol <mailhol@kernel.org>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org
References: <20251129090500.17484-1-socketcan@hartkopp.net>
 <d9431d8c-5050-4b38-a61c-cba980255c4b@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <d9431d8c-5050-4b38-a61c-cba980255c4b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 29.11.25 12:09, Vincent Mailhol wrote:

>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>> index 13b25b0dceeb..2514a5c942e5 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -109,11 +109,18 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>>   #define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
>>   	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
>>   void free_candev(struct net_device *dev);
>>   
>>   /* a candev safe wrapper around netdev_priv */
>> +#if IS_ENABLED(CONFIG_CAN_NETLINK)
>>   struct can_priv *safe_candev_priv(struct net_device *dev);
>> +#else
>> +static inline struct can_priv *safe_candev_priv(struct net_device *dev)
>> +{
>> +	return NULL;
>> +}
>> +#endif
> 
> As far as I can see, safe_candev_priv() is only used in raw.c. I think it would
> be cleaner to just move it there and turn it into a static function.
> 

safe_candev_priv() has been introduced 13 years ago:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bf03a5379cd3492fbeca4

And obviously the user (inside some notifier code) has been vanished due 
to some code updates.

In the end there's a new user now. IMO the location in dev.h is pretty 
good as it belongs to CAN devices and netlink. And maybe some new user 
will show up in the future.

Best regards,
Oliver

