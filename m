Return-Path: <linux-can+bounces-7706-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uInZAmmtFWpkXwcAu9opvQ
	(envelope-from <linux-can+bounces-7706-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 16:25:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 611515D76FF
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 16:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970BD30A55A6
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4E73B9935;
	Tue, 26 May 2026 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QMs4ONC8";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rC8wXz4S"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0439B97B;
	Tue, 26 May 2026 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804983; cv=pass; b=e8SeyRH37VnYB+ZCigYO8rXvafvmath4IX39oNCl6olkqui0fdjKQ+Ngy/ucsuLM/wEjcVYyPf3ud0Ax0fsIpAu24Q3/4IkbJDjua/TVY8Bu6pDhjjHJr6w489ecOh1ScJ5yhR584RWcuCHTMOUIUw9PHSf2xjwsOkcLzR7e7cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804983; c=relaxed/simple;
	bh=mAr8FXNf74QdPPTucdO2WeER74ejdM6LT7lfWu4ZMEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvoU1pKngPHzekB36McjiW7h30Hr62nnrAhoKSSaJmMyWwQZn8UloXIea+pys/XsNEHfG//bGSyvSaL/sb1i/glQ9cPg/2D9eHWCvbgEbc9HxXNbU9VxYXdfgs3tpdh5/MgnTIG7coVs+gb6WRUiePvtwXzn/qaDtruEwIgIp9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QMs4ONC8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rC8wXz4S; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779804975; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WRLU10xdPFJm7up7qyDFujkJphANMyWxRXRL4sheM0C7p9G3mfwiKVgldplkt4s3Cv
    6sDzYCr+K3kpydn2Ik3P1p21VN6u0PB8DFjVcXZaaqRS3gj7cmQE0yTT5hgJ4bi13T+z
    J7snQjXVJz2UeWzxtFl9+veO0zC9EVqg6lwFT7R+P1AskluQDjoOZpHZS4mHBZj0Kc4z
    tz/6bfwE95YLHounKSuaMSgf9PhCjLZpcm7IvmyeyGNENk+VyzubuKgfOXwf+nrR9dUy
    Yypa4GQaLO0TMoTozKNH5P9zxFTjvZWxHEax6eK0QHSe6NbY3ksZlIzLkiob8MdgVkFx
    b14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779804975;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wNroAQZEc5Vu5580qCLfd2xd6CbtwldOENcIuckL81c=;
    b=JJIsBoku3o+qugfaLGMp/cLWPqWpQPfZfnAks22ndRidzWF4vIZ+Ro58Q6gKd4pOUE
    k32Z/d6qs9Y+W0L9k7oL6ct6EC9KIX+6w/frUwfh8g5cPZlJAyrNZhFoUrtm+MOzNpmH
    /vo356V86OCATmnlfSrirwju0ALnpBylHxkWrQ69Uy+TQY6+HM8ZGzhFMbUMR7ErVG0s
    CfyRjm8l31MNFO9EdOCwBvtb6derXu9c1Iv2iyWToBybqteleyvPiwk/64OhYGH8Ibtv
    2dqYjrwfh6n+8vpM3R7X1sHgKeQLoiHMFLLG29CZph/AIunNZyI7N21rfASyeX8mH1QX
    cm2g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779804975;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wNroAQZEc5Vu5580qCLfd2xd6CbtwldOENcIuckL81c=;
    b=QMs4ONC8qQ9XlpAic4ScGmfagmRUMomcdRbBPqU9pwqhqQFdAXrUI8JIqUVqyfNhiS
    pjDfDuIkwZW7rTFpvz4pyfw3aql9rkllxJY/Yvjc/ycyutgIg/ohN2cmHyHwZNHzIeed
    SnNAOk+cOeDdyZQgP/ReUtEDMQbfXHivGvpC/VpBpzmYy4xypp9Ry5zg5idRhZ4xi8xO
    9UJz0jPLEvwH2bMh3UZRAVVXSjkFskCJoXGNz7Thc8IvgTDE2EXEXjRI6flChMQFtgOB
    P2RaCu3um9lmQEjU0l5FV8wq6xPwnZOBri+shuAhrFRvo97Zb5aTDnrWkYAwWLVNUhvb
    NpQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779804975;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wNroAQZEc5Vu5580qCLfd2xd6CbtwldOENcIuckL81c=;
    b=rC8wXz4SZ4KO0suK5U/u3kOgRuG/XxkeOvuv73mpbiCNb233nvQhDZS3qKFgCQyNtj
    Ga5nkYL++MfKUzH73JCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24QEGFdsX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 26 May 2026 16:16:15 +0200 (CEST)
Message-ID: <95496603-2ce3-473f-ab26-ed6ee0f966c2@hartkopp.net>
Date: Tue, 26 May 2026 16:16:09 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: af_can: reject can rx unregister if dev is not can
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 mkl@pengutronix.de, syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <d80a783d-d6b3-4a70-944e-8eb9b0000e11@hartkopp.net>
 <tencent_59FEDDAE991CCFC48D9A25A48D82923A5D07@qq.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <tencent_59FEDDAE991CCFC48D9A25A48D82923A5D07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7706-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,8ed98cbd0161632bce95];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,qq.com:email,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: 611515D76FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26.05.26 01:46, Edward Adam Davis wrote:
> On Mon, 25 May 2026 20:15:21 +0200, Oliver Hartkopp wrote:
>>> When a user binds a non-CAN device to a socket, the vulnerability reported
>>> in [1] is triggered during the socket's closure and release phase, due to
>>> the inability to find the expected receive list.
>>>
>>> Added checks for Mid-layer private and type during the rx unregistration
>>> process.
>>>
>>> [1]
>>> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
>>> pc : can_rx_unregister+0x124/0x560 net/can/af_can.c:537
>>> Call trace:
>>>    can_rx_unregister+0x124/0x560 net/can/af_can.c:531 (P)
>>>    isotp_release+0x500/0x9d8 net/can/isotp.c:1232
>>>    __sock_release+0xa0/0x1d4 net/socket.c:722
>>>    sock_close+0x24/0x38 net/socket.c:1514
>>>
>>> Fixes: bdfb5765e45b ("can: af_can: remove NULL-ptr checks from users of can_dev_rcv_lists_find()")
>>> Reported-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=8ed98cbd0161632bce95
>>> Tested-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
>>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>>
>> Hello Edward,
>>
>> many thanks for your investigation an effort to address the syzcaller issue!
>>
>> Btw. the root cause of the problem, that the receive lists can not be
>> accessed is the bonding process that the bonding driver mutates
>> and modifies the network device states to fit an Ethernet-like
>> aggregation model. Which destroys the can_ml_priv.
> I noticed the "bonding" aspect, but I haven't yet delved deeply into
> understanding why a vxcan interface cannot be enslaved to a bonding
> net dev. After testing your patch, I observed that sockets previously
> bound to the bonding net dev are no longer bound to that bonding net dev.

I don't understand this last sentence.

With my patch the CAN interfaces can not be enslaved anymore.
As Syzbot is simply doing whatever is possible, it get's an error and 
this error path is closed. Of course Syzbot can still test AF_CAN sockets.

Regarding your observation the I assume that the bonding driver makes an 
interface down/up cycle or something similar which might have such an 
effect.

But in the end it doesn't crash anymore when the bonding driver is 
trying to fiddle with CAN interfaces.

Best regards,
Oliver


