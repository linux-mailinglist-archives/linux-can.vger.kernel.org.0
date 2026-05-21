Return-Path: <linux-can+bounces-7686-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEjlDe9JD2ptIgYAu9opvQ
	(envelope-from <linux-can+bounces-7686-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 20:07:43 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA10E5AAC6D
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 20:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 065FF317B4AE
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12323F1662;
	Thu, 21 May 2026 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dmK0bOru";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6c0owUit"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC593ED3BB
	for <linux-can@vger.kernel.org>; Thu, 21 May 2026 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386286; cv=pass; b=q9B8FN09n3C/s633YYTMIJ63sugqwFuMaVfE09LBukxJHIUPI4gTyZ866oKYagMmYy4OVeB2gGvfGl5AajELx74QI7mu1J73i5/J6lzHUP9PTcg/RS5SrKWoJRtPAd/iuA7dJ6AKKK57i9zTuJOcX48VVhbNX79l+uuxgOZCK30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386286; c=relaxed/simple;
	bh=zu7DJsRjqM8X2tld/hIIHCt32286SR0/es4/Xo1kwJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDwzohT0+59N/ARXxGjnlONdsihaIFTeq3SK/wkyu7WpGJm4h77IXSxsq549nvu4KbTXJc9ejXT5OMFL3PRC3jBAYpdxsNOHrLfJqQFnVEo7w40wgHJeeHVeWwImBJaiHYSAZyYULsBb4/VA+NYZyFO9/l/+SmjV5sAmfp0yJbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dmK0bOru; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6c0owUit; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779386282; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=febh7dNdjTmF+scCZvi4CINEIFLOFCAfKdqzXU+RZLXQeKPDfCG7Eeghk5r7KAPem9
    ZrpfmsEsGsrCgziHfvBrgi1q6z280lTwIeqKCFY6Td08giq1i+0ZXRbMvtfW4EirrQno
    pK9c8vCJOxzRsrll/8xVzcx/kfd+BIFaXGrqId+2xQxZwlykVswqPi+QRH4/WxQK58Ab
    l8dhP8oiD2nwRTxHCY4gPh8An7AGBRfcE7sdkiZof4mSmPgnEPsW9KxRlddx/hQUU/n8
    GXsOW0//YRz5jcT4a3GMBMZ4hcF0Y9C+srU8i1iE8P9A/eamnGGSXPCrnsVPtd1EJ0q2
    gGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779386282;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Kpe+2QONHLYhS+l8ASCPXDNRCIekxCFmlW7WsoGjZvE=;
    b=CLT7WTSRXnNQ+xI7gplP20ldxClnOhWnD6/U5FHsBICKXCA0H7rygW58Z6mHte3uAY
    v//sI8+GU4eU+2Rotr1GKSVQuz+I63+ntaiA85mk6CJbNVRBAR4m8ml8XNSi7OpwoNLk
    LRjBda4gXU3ueNfeInYlq3bar6JxCNnUSDMHSydmiouW/tSerzAAllkVijAp9yem591Y
    T4RekX2WIvXxn+9bscXBMXCK7G+W/6mvceS2+UNkjudP7mUttCV//9VTaLRmBU6eSLrG
    XWoXMaVhdKcipZrm+FDU1x4msfCLHJ0a/z5Snc/iAWeuTzRiI/0iDBuP8v5S1NzVs9p5
    2VnQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779386282;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Kpe+2QONHLYhS+l8ASCPXDNRCIekxCFmlW7WsoGjZvE=;
    b=dmK0bOrujVfNFAilRLBDEuTAGT7gDgL1US2S6C5WBF3gSNkzrnOZmmxd93z1VyXJd2
    IqqHZIPE4IdDtlJtqU9HEqFS+AiR5Cw4BsFM4UGIZgTkwyExzDjRVN9dkRguGdIYBj74
    vLYvwtcQChzGnqpcYVImSz7L/JBRXS3odDy+Tu8SyJnC0cNDCYeFN+88u1CQq4W3phmR
    vR9UzSRa/PDu9lEhqZ2dHJQg42TqTvUg5Z7jFb427y5qP4/kkic2JYvxHNzmF11pI8+j
    Xax5yldC1utF0kVbFo5TrUPTqgAnTkTNyrRh5ZxWcQT3q0khkDat7MqD9QXz/dI4mD2W
    6kxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779386282;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Kpe+2QONHLYhS+l8ASCPXDNRCIekxCFmlW7WsoGjZvE=;
    b=6c0owUitW6bYna+HVup2VZQFvxIJqeo6+rd5eMA1etA0bHuvUAFC8kEPk4GmVbXfzs
    C8qTa5D+JgZmDcBs5uAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24LHw2QBh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 21 May 2026 19:58:02 +0200 (CEST)
Message-ID: <4cc46930-650e-485e-ad26-a61df9808214@hartkopp.net>
Date: Thu, 21 May 2026 19:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
To: Lee Jones <lee@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20260520124758.GA305027@google.com>
 <20260520124907.GB305027@google.com>
 <442a92c9-5810-4fcd-ab05-5b0acd0f345c@hartkopp.net>
 <20260520134032.GA2767592@google.com> <20260520140657.GC2767592@google.com>
 <24a20c37-5cac-4a38-a8f1-ed98b38f7e1d@hartkopp.net>
 <20260520161308.GL2767592@google.com>
 <7d21ad57-3de9-4eac-a51d-15b6dfaf3bae@hartkopp.net>
 <20260521110708.GC2921053@google.com>
 <80f98c44-e9f3-45e2-989f-32f1a7c2c38b@hartkopp.net>
 <20260521135141.GC3591266@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260521135141.GC3591266@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7686-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: BA10E5AAC6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 21.05.26 15:51, Lee Jones wrote:
> On Thu, 21 May 2026, Oliver Hartkopp wrote:

>> https://netdev-ai.bots.linux.dev/ai-review.html?id=9e8842e7-59a2-4ec5-9f65-1df7973c6170
>>
>> says this:
>>
>>> @@ -1870,6 +1891,7 @@ static void __exit bcm_module_exit(void)
>>>   	can_proto_unregister(&bcm_can_proto);
>>>   	unregister_netdevice_notifier(&canbcm_notifier);
>>>   	unregister_pernet_subsys(&canbcm_pernet_ops);
>>> +	destroy_workqueue(bcm_wq);
>>>   }
>>
>> Does bcm_module_exit need an rcu_barrier() call before destroy_workqueue?
>> Consider this sequence:
>>
>> A socket is being closed while the module is unloading:
>>
>>    bcm_release()
>>      bcm_remove_op()
>>        call_rcu(&op->rcu, bcm_free_op_rcu)  // RCU callback scheduled
>>
>>    Module refcount reaches zero, rmmod proceeds
>>
>>    bcm_module_exit()
>>      can_proto_unregister(&bcm_can_proto)
>>      unregister_netdevice_notifier(&canbcm_notifier)
>>      unregister_pernet_subsys(&canbcm_pernet_ops)
>>      destroy_workqueue(bcm_wq)             // bcm_wq destroyed
>>
>>    RCU grace period elapses
>>
>>    bcm_free_op_rcu()                       // callback fires
>>      INIT_WORK(&op->work, bcm_free_op_work)
>>      queue_work(bcm_wq, &op->work)         // UAF: bcm_wq already freed
>>
>> The RCU callback queues work to bcm_wq, but if the callback hasn't fired
>> yet when bcm_module_exit runs, it will try to queue_work to a destroyed
>> workqueue. Before this patch, bcm_free_op_rcu called kfree directly without
>> using module-global resources, so this wasn't an issue.
>>
>> Should bcm_module_exit call rcu_barrier() before destroy_workqueue to
>> ensure all pending RCU callbacks complete first?
> 
> I hadn't seen it (do you get notifications?  If so, how do I enable
> those?), but it is legitimate.  I shall send out a v2 early next week.
> 

Thanks! Looking forward to it.

We have this AI bot feature inside Patchwork.

Linux-CAN Patchwork
https://patchwork.kernel.org/project/linux-can/list/

Netdev + BPF Patchwork
https://patchwork.kernel.org/project/netdevbpf/list/

And your patches (with AI bot checks) show up there:

[1/1] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

https://patchwork.kernel.org/project/linux-can/patch/20260520080523.2513957-1-lee@kernel.org/

[1/1] l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()

https://patchwork.kernel.org/project/netdevbpf/patch/20260520134837.2780050-1-lee@kernel.org/

(which has some AI feedback too)

Best regards,
Oliver


