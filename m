Return-Path: <linux-can+bounces-7863-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vr9ZCmVkMWqniQUAu9opvQ
	(envelope-from <linux-can+bounces-7863-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 16:57:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F64690B48
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 16:57:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="U/Coqgx1";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7863-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7863-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0330A301ECC1
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8553B71D8;
	Tue, 16 Jun 2026 14:57:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EFA35201E
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 14:57:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621857; cv=none; b=IuU8MSmpmX4cBM/1l9xSyaCnat324FdvF2PDE1/2mEfNMYCi1en47sYXgHnrcn+L0oi3Mw77JYx5yabY5eEtkLW1t9vkpkT7G45RxZmpOUuLQXDeA8afLecavUALDwlZt8RRv7o/PE0qUpJFfx4ehNAAkwH3hyZJtUCUzL73Xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621857; c=relaxed/simple;
	bh=VLW9/TMGyN5UPEP8rmOjNnUTBMcUDk592XQ8GQC/dTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9TrYbtvdX2cTMr8tgROsnLWekE+3ogDiZFdPcEqGvzT/Z+o5oQdXks8Gh3mjinEMNZg9Jn5O7uwmDlPCQPgg5qcUEqZNF1UiYum/0a7l2MFSETOOhMfeVeVv+GYXL6Imcd0IOj8/yl/+Z2WCHLSdEtQqjllImGPHwLew4Na3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/Coqgx1; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4600ddc4017so3539594f8f.0
        for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781621854; x=1782226654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7jptHSgz5KByLhlfc5GhmGAlIi/z/XUa5yhD10TU3Y=;
        b=U/Coqgx1M4ITwq+W/aZSFfyV2D1ARnEZ/ogx6pziWlaqCOgoc9Iaoe/rK4y3huY2ZM
         9TAK3WVTT0AMsMmQHvVFf0X3CvS4lgRAjUdN4y6ewT+Z//53qoWyK1fKmSqpRfSdk2zb
         xUVJc6zw5gNS3++DIqjyF5VFLoGdyOhGl38DKoDvojv6pdqGwk0FZ3dKbcAB8+Tv5uRm
         tI4bPIgfP+Apl2cwT3rTBUvXWaPiJ2p++IQld6yKb5b3F20RcPCG6DFGjsT0dHNTGRw6
         KNb39s/cnILb1zEwzC1wRSbOpnfv686lOVRbLz+BuNDRH4Z5WNJ5iEYJJ2kayrKNNv1l
         9reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621854; x=1782226654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7jptHSgz5KByLhlfc5GhmGAlIi/z/XUa5yhD10TU3Y=;
        b=TyU2yAYGZ0TiTpqnFx6ybXE8Eg0nc0lssa9zLBlVUfI7TOG0ux/n78JKbZyUhiwT7l
         dZlZEH6RRR0peYS0ZFdRWNnsI2FNrptZSahtKqLhj7dFGQMNqmrPS1pV8qOW1Lcn5ME9
         QH7DetREr71+62mtjBypwoUFueicJf3Vwy4QCvCxfZvM5M/Xg02I5uMRYyoiV7WQHaZR
         DTjzHSv88yM3HcbvZ5f0zAIz56iS2JE46BpDbk1SLVD90ZDUdJsAHhcO3u7cCNixQRby
         GNaYk8ClmqdznurQJ3NAF1IGy3scYRGjMGx4NBDG09YTZObuXl0LVHCt0bcTmO10bk8X
         vPUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Muk1Edcm9zHls2MzxK9sBE+fVLmu1Ayx8uMwj/WiiqMjGsdDZ2cexQK3GF4vbT7j5aGzIyPQp/Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJmSnqrm2Rvl+DTQDmltt4GoOQ/hJeUwgZOVNZM4xqjaoQ5TW
	7i/xJP0jK7DkLjv+PXCb+v+VIuLHFHnGgYounYLB7B/6mtWZh3CjhFQTZNbd8DYMOuc=
X-Gm-Gg: Acq92OHmDqxxR1xyezmJ/MmyepDwkvwMT7AiHfbaA9Qg/mDwn6/pGbV6XgOxuTrKPqN
	fij6X5kf6Au9to9h4fLb1yUblBepfjGYUvWrcJOrrgK4Nw9qYr300ldzNr/IFN9Gi2L5t8C8KHg
	FauyysiCYLVWnpNaCQEGiWIIU1AVX/u5GJfIU9Syz34zeQbsvAsfsSMIiiwKWBF5/6FzqG3tnAv
	/0x3WUcmLoLV9QskqCJRPRkONAtj+bSNzj2IM8RORUZA84yxaGLrYOT55faKeDfWCFVC5nAWxx4
	JfHvn8lw3K0cAUXV4Ihs0/pu3DCLMmRUD1E/i7BjueK5X7pANdxCgtx2nC3QVrIcZmCFYfuTRTa
	5yuf5+WeDxQaClyR8OA0bPR/Mp/0NLrZ7DV8aSCpU3JNp/KseNXaEu5ZIueSsxc7AKCZK9y5smG
	M6Tg6wxOxC0xcWKjVf4R/GHdT8oacb+Rt7ygeLiwMtzjYE19oMbquceCvhxAgEzMqAXsLhLyKec
	5xRdRT2SQwwiB1nCw==
X-Received: by 2002:a05:6000:41f8:b0:461:f237:ebc2 with SMTP id ffacd0b85a97d-461f237ee93mr1837167f8f.29.1781621853866;
        Tue, 16 Jun 2026 07:57:33 -0700 (PDT)
Received: from [192.168.178.24] (cgn-195-14-216-63.nc.de. [195.14.216.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e6a8fsm45654287f8f.37.2026.06.16.07.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 07:57:33 -0700 (PDT)
Message-ID: <18f16dc5-a61d-4499-849e-7f1f7c8364c0@gmail.com>
Date: Tue, 16 Jun 2026 16:57:32 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: isotp: hold a reference to the bound netdevice
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260616123915.674534-1-vasilisalmpanis@gmail.com>
 <20260616125350.B7A371F000E9@smtp.kernel.org>
Content-Language: en-US
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
In-Reply-To: <20260616125350.B7A371F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7863-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[vasilisalmpanis@gmail.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasilisalmpanis@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6F64690B48


On 6/16/26 2:53 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Calling synchronize_rcu() while holding rtnl_lock() introduces severe latency spikes and potential denial of service system-wide.
>
> Pre-existing issues:
> - [Critical] Skipping synchronize_rcu() in isotp_release() when the socket is unbound leads to a use-after-free of the socket structure by re-armed hrtimers.
> --
>
> commit da93bcd8877d85ffe0b043e3045c3374b10e38e5
> Author: Vasileios Almpanis<vasilisalmpanis@gmail.com>
>
> can: isotp: hold a reference to the bound netdevice
>      
> isotp_release() looked up the bound netdevice with
> dev_get_by_index(so->ifindex) and only unregistered the socket's CAN
> receivers if that lookup succeeded. This is unreliable while the device
> is going away.
>
> Cc:stable@vger.kernel.org
> Closes:https://syzkaller.appspot.com/bug?id=58676a0f698531996a42612c552e894a55b9732b
>
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index c48b4a818297e..308d18040b6db 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1219,27 +1222,22 @@ static int isotp_release(struct socket *sock)
>>   	list_del(&so->notifier);
>>   	spin_unlock(&isotp_notifier_lock);
>>   
>> +	rtnl_lock();
>>   	lock_sock(sk);
>>   
>>   	/* remove current filters & unregister */
>> -	if (so->bound) {
> [ ... ]
>> +	if (so->bound && so->dev) {
>> +		if (isotp_register_rxid(so))
>> +			can_rx_unregister(net, so->dev, so->rxid,
>> +					  SINGLE_MASK(so->rxid),
>> +					  isotp_rcv, sk);
>> +
>> +		can_rx_unregister(net, so->dev, so->txid,
>> +				  SINGLE_MASK(so->txid),
>> +				  isotp_rcv_echo, sk);
>> +		netdev_put(so->dev, &so->dev_tracker);
>> +		so->dev = NULL;
>> +		synchronize_rcu();
> [Severity: High]
> Does holding rtnl_lock() in isotp_release() (net/can/isotp.c) across
> synchronize_rcu() cause severe latency spikes and potential denial of
> service system-wide?
>
> synchronize_rcu() blocks until all currently active RCU read-side critical
> sections across the system finish, which stalls all other network
> configuration operations while rtnl_lock() is held.
Okay this is indeed true. rtnl_lock/unlock is not really necessary as 
now receivers will be tracked
through *dev_tracker*. I wanted to mimic *raw_release() *but maybe too 
faithfully. Just dropping rtnl_lock/unlock from
*isotp_release* and *isotp_bind* will be enough since they are 
serialized under *lock_sock.*
> *[*Severity: Critical]
> This is a pre-existing issue, but skipping synchronize_rcu() when the socket
> is already unbound (e.g., by NETDEV_UNREGISTER where isotp_notify() sets
> so->bound = 0) appears to allow a use-after-free.
>
> If synchronize_rcu() is bypassed, isotp_release() proceeds to cancel the
> socket's hrtimers and drop the user reference without waiting for concurrent
> receive operations to complete.
>
> Could a concurrent CAN receive operation like isotp_rcv_ff() or
> isotp_rcv_echo() executing within an RCU read-side critical section
> unconditionally re-arm the hrtimer after isotp_release() has cancelled it,
> leading to a use-after-free when the timer later fires on the freed socket
> memory?
This is a pre-existing issue that is not touched by my changes so it's 
out of scope of this patch. Its true that timers could potentially be 
rearmed after being canceled and *synchronize_rcu *should be called 
unconditionally but I would do that in a separate patch for it to be 
fully bisectable.
Looking forward to any comment reviewers might have before sending v2.
>>   	}
>>   
>>   	hrtimer_cancel(&so->txfrtimer);

