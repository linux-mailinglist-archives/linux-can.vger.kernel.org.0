Return-Path: <linux-can+bounces-7413-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCo1EQCc72kbDQEAu9opvQ
	(envelope-from <linux-can+bounces-7413-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 19:25:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 057CB477763
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7704A302D5B2
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 17:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B6C3E4C68;
	Mon, 27 Apr 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="llfbgdtP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="70BsfrRk"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6873E3DB2;
	Mon, 27 Apr 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310330; cv=pass; b=Q15pteoOO0MDl94xHL8SzAm6XjUMXfS40P5RSh5uyLZfY3C4RoMFMfsC43V/hXCiUwzRmjCMbsm/pEzvSu0X/5uuTEbxqMXBzY1wsLwPlkR5uAgPLMcSMrSbIZUwAEAohYidtU0noLLG91RFnnSUAGrDL4agm+x5DMXoJ0GJCQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310330; c=relaxed/simple;
	bh=NpzzVe+38KQcPjS5xP/nAfgavUOsxtxQ9551LGxlxGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlMskFfPZHTTaamXWd+rjZ3/UH9wUhzCpOy37T38PdIZhWXfrU75x0bya+ZedwWkJMDEOqfr06PocqQUQG5I48cs31UBQsyK6gXox4bDUXTfe/XFD9woLfKpYluNQs7hRplaJVJCIEXspWdmPVq+koknkcptDYNptTzSUfwrgeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=llfbgdtP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=70BsfrRk; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1777310137; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PSBDnBtn8qg73j7Exet34zCU5fkueJJwk50ZA/Fd7slazn9hb9acwOUxrDEDUkS7mU
    C5z73BvSxV8UKmwY7wHIfl/z5GClKoh8UzHl5auEz4Mpj3Mm42R8hMpadird6I/Q5B9g
    GH5yukqtQt3K3BNv+4o+Akw22gGAPtvtINQUn/Qa5wjGQKO+LJIVkjqDXy+0aMsE7qfq
    kiKjPA+bXpmeq7b281tzqjVcqxTFFCvEstdN5R4FQ+SSk62Z1SCK7YTw6UCCbTTfAAZH
    3PxTyiJ4iV3XfmQ9qo+S0W1CBa0QRrX8Pp8KUoIwO1pN7h3wqxVyw/49Es5uhGlAawiy
    Oy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777310137;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sWkQkUdVwPL5ia+ETWE805kdE/5m54yfAMXuKNuT0Zw=;
    b=lm9+GUeiDyhR0GG+h7MNqoKBP2wtj3VrU4//iLM6pt1u6XYjTiLBboS6EnMNcfe+pK
    NaaAdGpvuhVge4LK5INapYTXRLsxYQIXaVtwKoMXGxm8aoIYGL1QRDKxGS5PJ9Pk20C0
    GBIN3HjDO94yIBAYadlKMm3LMTg6u3sMRDcbb3vEkmKHmqcWbB1AJt8wZYfXwHlc4rog
    x3KKMdEPsIjhcKRbpDmT11Z1N676U1gVY+55jpMY7tyTwyxfJv57PG0yJNaFYzCUPON8
    w6EnWhFi2druu66lwEepJq0hKtRkwfsDslsjXeFKedSWzxHHCND9pBQJ2o4D3xrarz7w
    jKhQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777310137;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sWkQkUdVwPL5ia+ETWE805kdE/5m54yfAMXuKNuT0Zw=;
    b=llfbgdtPWtXoTtdFSveVVS9KGl4tRMaW0m+jSkx2r/Cer7PihAqc729IPncgQjrBxq
    rrv7vOCIWs+f0UyURdedxZAJuST5C1khkhjn4TjQ6dKh7Fx3bqgFeKtR6mFGmKmYwpk9
    Qwt6L7gjKmS8RYAzVncsFT+0S7i5KRKe2wMBZZ3kswtqYLdniZeupxCQABrQ1GSr9Vxz
    JDKcXT89KHqBjdzqkkv6ZTKqB4uNBUec53KSHqMv6Irc3BTA3lcpMwLEk9Uz/tIFklt9
    MvNtIv6N0K7Ev8U57GudgR43vm0UjG270+z8TiD/Aij5WKgSCs/EjATj5w9oTZKLHTcl
    1gow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777310137;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sWkQkUdVwPL5ia+ETWE805kdE/5m54yfAMXuKNuT0Zw=;
    b=70BsfrRk8GIa6x1YNpsXtAGv4JXBf33WwJXUFc2RYx8h7aK4eF/xtTYpFPerEJNqF2
    QDfgjlqIbcd7llnyo8Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrJozOHkwxtwKntYe0I1zz8hIldN9ryOkQNQfIcej9HjqQwrv"
Received: from [IPV6:2a01:a380:9c0:a210:4e8d:f51c:9f4e:efc7]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d23RHFawIh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 27 Apr 2026 19:15:36 +0200 (CEST)
Message-ID: <dd5315a7-87e9-4754-9e88-34c0623aca99@hartkopp.net>
Date: Mon, 27 Apr 2026 19:15:29 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
To: Lee Jones <lee@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260422102239.948594-1-lee@kernel.org>
 <6cc6eec9-2e8a-4a39-955a-0eeefc93fe97@hartkopp.net>
 <20260424-magic-snobbish-rabbit-0865cf-mkl@pengutronix.de>
 <eef6917f-38c2-4bb4-a5d6-98f5a71adf65@hartkopp.net>
 <20260427124058.GA8212@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260427124058.GA8212@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 057CB477763
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7413-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid]



On 27.04.26 14:40, Lee Jones wrote:
> On Sat, 25 Apr 2026, Oliver Hartkopp wrote:
> 
>>
>>
>> On 24.04.26 21:08, Marc Kleine-Budde wrote:
>>> On 22.04.2026 14:55:50, Oliver Hartkopp wrote:
>>>>
>>>>
>>>> On 22.04.26 12:22, Lee Jones wrote:
>>>>> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
>>>>> synchronize_rcu()") removed the synchronize_rcu() call from
>>>>> bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
>>>>> timers from being rearmed during deletion.  However, it only applied
>>>>> this check to op->timer via bcm_rx_starttimer().
>>>>>
>>>>> It missed the fact that op->thrtimer can also be rearmed by an
>>>>> in-flight bcm_rx_handler() (which runs as an RCU reader) via
>>>>> bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
>>>>> bcm_remove_op() has already cancelled it, leading to a use-after-free
>>>>> when the timer fires on the deferred-freed struct bcm_op.
>>>>>
>>>>> Address the omission by checking the RX_NO_AUTOTIMER flag
>>>>> in bcm_rx_update_and_send() before starting op->thrtimer, effectively
>>>>> preventing it from being rearmed concurrently with teardown.
>>>>>
>>>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>>>
>>>> Many thanks for the investigation and the fix!
>>>>
>>>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>
>>> Can we add a Fixes: tag?
> 
> Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
> 
> Do you need me to resubmit or are you okay to apply manually / with b4?
> 
>> Yes, we should.
>>
>> Thanks!
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> I'm a little confused by the SoB.  Does this mean you've applied it?
> 

No. Marc will apply the patch.

My SoB is probably not needed in this context. But Marc was sometimes 
asking for it when I commented and discussed patches in the past.

I also thought Marc would add the Fixes tag on his own.

Best regards,
Oliver


