Return-Path: <linux-can+bounces-7755-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JhalAqYlIGrGxQAAu9opvQ
	(envelope-from <linux-can+bounces-7755-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 15:01:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB79637CD9
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 15:01:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b="Pz/PQ8J+";
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=+1VDuUj8;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7755-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7755-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E17FE30FE3BF
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075F647ECE4;
	Wed,  3 Jun 2026 12:54:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706F2264A7;
	Wed,  3 Jun 2026 12:53:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491241; cv=pass; b=E1zMme4b55sEtweqt4d2S/mmHiIDZ1dRc2Dv9yeXZTInfOhoO/aajwzqagM82W1gbWBVxaNvVZifkszoOTWC7LvPgCB3TrnPoBT7jyHBl4GpZobp0IEgn8k8D5PFLS3I+2S8cXI5dDbjXdky55uMRcvRqhAxDjy6I1ysNRfpmT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491241; c=relaxed/simple;
	bh=N0r0/FJRU8FYET34La8UGAEpoLuB68ut3JwehoeYLqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlTgWB/zBnreUNsYM+nZ4/sI+2FNvISbkICiXX7+pcdWHi/b5ehr4b4KwkPQA5BmHs8kp8j02wtgpDYW/1ZXf2INcGHtTJDMluubSr2DUcqbd063RETxAXmDZfLjEzFBsVY7f8PxSuUQJQNQY3ZzqxEz8NZhBtRkokt6ZSyC9PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Pz/PQ8J+; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+1VDuUj8; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal: i=1; a=rsa-sha256; t=1780491051; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J7dM+qog8oZThHuDABETXOdQlYL3JZSGY1gkmGy4/FLV81LNQ5sdaK/pwKNMk4RwmG
    I3t3Tlez8TMij+HXaeYlSIinvDhm7L/U+5THZzdL94CeFClxQs7zfpC4dnLv/gqmxj7Y
    PFASXynBGhH51GjoiA8XwWl7exwyGfJsgIvNBOBct067CXMBGV40cOd/ckaq79+Mb6fH
    qlmWfmOr1x/Hr/QllD+OEn2+utEKbDCRIn8UkUoFgu5CTHibD7wcITcjEmBqkc5uPHLg
    13r29qBPP54TeMMUKi/mstLDPz0KDvrnkvxvXSG5c/ykeWQbNy/czsrVjDYXToDfzfJE
    QgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780491051;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rt+5p90dyAdQVIbs7nxq88gbTVhCl35Ll+6dLcBfYi8=;
    b=e21VY9cN1zpgR7frh7tL1XvVd2269Wh4iJ2PkqPGW1EXBrq7ZQrNrbLn0tRA3WrAjj
    qQIjx4J6veMq2AlwEgkNpoU5nPAzY6RUW3WQxCDm7pvQp8nKrmplA5bcs9UxEAwy1Hj+
    ZHSPotWzl0pIUaZut74Xtmp2rPAapN/mLLpwaVLFLZmP/D43WixEDivJe9SDww2Q3Y0C
    JbIZYpNiWVvmayNv07DBi8i+yO3xlPTD6HFBsZTZJDayysMaNDzZH/tvrdbAWlcogGc8
    17FHnVmSha73GyoYE4KBB7ZJWq3/PKEXcQ73Dxqm4Tv7nRavV9/IPwZCvoC/+XJnHN8s
    e0AA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780491051;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rt+5p90dyAdQVIbs7nxq88gbTVhCl35Ll+6dLcBfYi8=;
    b=Pz/PQ8J+ly4xXbKEIAX23i33HvPhVY7Kt9WaPFJUvQlwSnFKgM4x5uUeXj+TuK6/xs
    EBZbiEwQSCYZotNg92B9sZ6x27VdueymGXmVs3AZ0+x5E16gnd2pS1p7qRk/3CE99XP8
    v6Ur0tsuwWxV7l8RBgyHcfgsK5XkuXDoddV9bfmal1RFvXGKAczqdWsiajx9V3PYgDkl
    CcyLarhRJL0SOOKPUW4Xe5fwJ9yL9ShREv84BkgZYIpLBN1EwKMXJTLJ/dF+Kp1Pnqx7
    sqsgdV6OnbtjXJH81kK8dTL+cVdZfryuoHJo2L8qNGx2I1SiRIW18K5i3Q2t+ynTfg60
    wQ3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780491051;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rt+5p90dyAdQVIbs7nxq88gbTVhCl35Ll+6dLcBfYi8=;
    b=+1VDuUj81BzZJGBRyqhSiF+D+ZXlnNAvXnT9BFkWjagWwnXqs8tb02EiwqiFpQX+lT
    j23U8ZLtpDQZQjHai4BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.90.236]
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id Kba96d253CopWJ6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 3 Jun 2026 14:50:51 +0200 (CEST)
Message-ID: <f83e25e1-b9f5-4810-bbd6-fdb8d2a10c8e@hartkopp.net>
Date: Wed, 3 Jun 2026 14:50:51 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] can: isotp: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>
Cc: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
 <20260507-getsock_two_can-v1-2-3c2ae9edfadc@debian.org>
 <14d3ad71-ade2-4d2b-8a67-b0fda3eef2b7@hartkopp.net>
 <aiAcRJ8TBjWhlKhQ@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <aiAcRJ8TBjWhlKhQ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7755-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:robin@protonic.nl,m:o.rempel@pengutronix.de,m:kernel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:mid,hartkopp.net:dkim,hartkopp.net:from_mime,hartkopp.net:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CB79637CD9



On 03.06.26 14:25, Breno Leitao wrote:
> On Mon, May 11, 2026 at 09:05:07AM +0200, Oliver Hartkopp wrote:
>>
>>
>> On 07.05.26 11:34, Breno Leitao wrote:
>>> Convert CAN ISO-TP socket's getsockopt implementation to use the new
>>> getsockopt_iter callback with sockopt_t.
>>>
>>> Key changes:
>>> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
>>> - Use opt->optlen for buffer length (input) and returned size (output)
>>> - Use copy_to_iter() instead of put_user()/copy_to_user()
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> ---
>>>    net/can/isotp.c | 12 +++++-------
>>>    1 file changed, 5 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>>> index c48b4a818297e..1c33f09fbd338 100644
>>> --- a/net/can/isotp.c
>>> +++ b/net/can/isotp.c
>>> @@ -1500,7 +1500,7 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
>>>    }
>>>    static int isotp_getsockopt(struct socket *sock, int level, int optname,
>>> -			    char __user *optval, int __user *optlen)
>>> +			    sockopt_t *opt)
>>>    {
>>>    	struct sock *sk = sock->sk;
>>>    	struct isotp_sock *so = isotp_sk(sk);
>>> @@ -1509,8 +1509,7 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
>>>    	if (level != SOL_CAN_ISOTP)
>>>    		return -EINVAL;
>>> -	if (get_user(len, optlen))
>>> -		return -EFAULT;
>>> +	len = opt->optlen;
>>>    	if (len < 0)
>>>    		return -EINVAL;
>>> @@ -1544,9 +1543,8 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
>>>    		return -ENOPROTOOPT;
>>>    	}
>>> -	if (put_user(len, optlen))
>>> -		return -EFAULT;
>>> -	if (copy_to_user(optval, val, len))
>>> +	opt->optlen = len;
>>> +	if (copy_to_iter(val, len, &opt->iter_out) != len)
>>>    		return -EFAULT;
>>>    	return 0;
>>>    }
>>> @@ -1718,7 +1716,7 @@ static const struct proto_ops isotp_ops = {
>>>    	.listen = sock_no_listen,
>>>    	.shutdown = sock_no_shutdown,
>>>    	.setsockopt = isotp_setsockopt,
>>> -	.getsockopt = isotp_getsockopt,
>>> +	.getsockopt_iter = isotp_getsockopt,
>>>    	.sendmsg = isotp_sendmsg,
>>>    	.recvmsg = isotp_recvmsg,
>>>    	.mmap = sock_no_mmap,
>>>
>>
>> Same pattern as in net/can/raw.c that had slipped in via net-next last time
>> ;-)
>>
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> Thanks Breno!
> 
> Thanks for the review!
> 
> I haven't seen this on linux-next yet. Please let me know if there is any
> update that is expected from my side.

This patch will likely go upstream via can-next.

Marc currently seems to be busy.

Best regards,
Oliver


