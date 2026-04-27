Return-Path: <linux-can+bounces-7415-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDhkLgWn72mpDgEAu9opvQ
	(envelope-from <linux-can+bounces-7415-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 20:12:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C014D478489
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 20:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DD333024EB1
	for <lists+linux-can@lfdr.de>; Mon, 27 Apr 2026 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416933E714F;
	Mon, 27 Apr 2026 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ix6L1BLU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="453j0ZzK"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FE3C661A;
	Mon, 27 Apr 2026 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312899; cv=pass; b=Wo4DfdTrEOquw1hR6RGB65g3orMH62VZlitvML1E0ZOZ2cSu3ugbVW7QBhyXzmNOqhaXOPQIdM7x7pHQHA2ClmueBRW1tzFu+3GGzOPvXikz5SQ9bOzwLCnZ3rbEP1LhvPm7OTDoEVCyVoTiwWdkc9GHYGV0CVAvkc1NGBAeBfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312899; c=relaxed/simple;
	bh=8xFkX29ZyRmaZRdFBwAIYY+VmS+vI+4bYsEYps5rY9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVljUeTFqq/0SZ4fB9qOFwECCqw88T01VmyXrI0bFcWSAmEi8/VDfgGhlVl4s9Zr3V2AE0ffclUTyvOSXtWD38mUPm3V5xoP4e2g2LmLHmIvQrhIJQaqY9b7EVctPdSUjYFJ9t1iDeuSfand1H6praYkVz3uwWb4X5DWnw/QM8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ix6L1BLU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=453j0ZzK; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1777312710; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sWCWq/jqp89OOtadJLU31dj2OW/RvHJ4fQ060K3so7uHyY8ROAmBMoTD56hIE90MgZ
    CNmGEYPLZga9j1bqay0I0/iw8ycnkoS74//JWltb/ZnxutnQgzGHYlhrEz+osMi6fh2h
    hhjegffODxQc29SCmi6v9DpY9pXw4BTs749S6neoTB9rqHJw4KfmUP9w+O+qvp+SNsav
    ZxRmIByF5AX3vpyS+0bQcpq/x1jhn21OTVY37u7ezL5iVJCwv5skg0stn5gag8xVH5N1
    zC5rsmJeCFgnArs8RovXMbGjtax7oIsob4TukkX2eXJ2KgUSJyv9jjMHuxWOIILdOxZT
    Y8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777312710;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fgX6ZQWZ3GumLMNmQ4h3tZVVknrHLHlPHoPaSAxLqtc=;
    b=Z7bXMzVsf4vb390x09azyR/Sc/kV0afzqyhdNTUb5eM3UU3oEsTZby7/tHyqd26fjX
    qGfZAKTOcZmXQTbUxXvMHBcPv/I8SKO53TpEby1wP6VcHVlQdzn3KE8fwOIAeJDZRLaC
    xHoF6BNuR1XrB51La6ENanyR15PH41NVGFEys2vBMKEWdVEiJZn0rSW3vodGqtMmBHZX
    sfYdWA2VeiWDB98WKRnpcsQ0jBQlF249h9MlMkKDPi2QqpiyJA8hkszu/DFb1O581Ugn
    nmd6h9QlpUj60Uc21Rjpj7eLFKvwC5uMMeVLksvM+/+nwM2P4wMT1PxKX2O72FbAD213
    ESXQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777312710;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fgX6ZQWZ3GumLMNmQ4h3tZVVknrHLHlPHoPaSAxLqtc=;
    b=ix6L1BLUJJREN7g6yJ6D28fzjizxBkdzGbM5tHnN4jPY0h0pUxTBWN57Wy9EIUhdEV
    2dysZbhvbMqIeG7ijuPI/lAwrKApVjqgbaIZyGdnqY+ndQ5yF634RDy5KQyrJr6gz2qJ
    haQlrsJREGeZtOI8hAAUOwy0BLkTHxuQMAxNy6ec3izZT1C6jAWQtwwxo6CjHZVKSqmf
    DZzaEPuR1fqNZIt7kBidbfLSPL+8KXNUOSGxw12go0fhpI4TVOrUiofBnmvStwLh1kyV
    3ae+lZ1LpTbzF90cqAWwPkjztP8ORtVyjAhlFClKoP5NYCYOYMbJG6X+mk2nNfb2j0wn
    Rz3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777312710;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fgX6ZQWZ3GumLMNmQ4h3tZVVknrHLHlPHoPaSAxLqtc=;
    b=453j0ZzKE+fxkezFYV1jW6DzDEDQT3fmPjKdDcIBKkIT8kGMKTBsddtWFBOd55i5hA
    XdAUHoe0zobx5EXYLODQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrJozOHkwxtwKntYe0I1zz8hIldN9ryOkQNQfIcej9HjqQwrv"
Received: from [IPV6:2a01:a380:9c0:a210:4e8d:f51c:9f4e:efc7]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d23RHwUwOK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 27 Apr 2026 19:58:30 +0200 (CEST)
Message-ID: <befec23a-f4d8-4c05-81a1-e9b9ed12bd39@hartkopp.net>
Date: Mon, 27 Apr 2026 19:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Lee Jones <lee@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260422102239.948594-1-lee@kernel.org>
 <6cc6eec9-2e8a-4a39-955a-0eeefc93fe97@hartkopp.net>
 <20260424-magic-snobbish-rabbit-0865cf-mkl@pengutronix.de>
 <eef6917f-38c2-4bb4-a5d6-98f5a71adf65@hartkopp.net>
 <20260427124058.GA8212@google.com>
 <dd5315a7-87e9-4754-9e88-34c0623aca99@hartkopp.net>
 <20260427-zealous-booby-from-avalon-c9753c-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260427-zealous-booby-from-avalon-c9753c-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C014D478489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7415-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid]



On 27.04.26 19:41, Marc Kleine-Budde wrote:
> On 27.04.2026 19:15:29, Oliver Hartkopp wrote:
>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>
>>> I'm a little confused by the SoB.  Does this mean you've applied it?
>>>
>>
>> No. Marc will apply the patch.
>>
>> My SoB is probably not needed in this context.
> 
> ACK
> 
>> But Marc was sometimes asking
>> for it when I commented and discussed patches in the past.
> 
> The rule is: if you post a patch, your S-o-b has to be the last S-o-b in
> the line.
> 

Ok.

>> I also thought Marc would add the Fixes tag on his own.
> 
> If you add it in the thread, b-4 will pick it up automatically and this
> less work for me :)

Ah. This time Lee already did the job for b4 ;-)

Best regards,
Oliver


