Return-Path: <linux-can+bounces-7417-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLKwCfCA8Gn6UAEAu9opvQ
	(envelope-from <linux-can+bounces-7417-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 28 Apr 2026 11:42:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 959FC481B35
	for <lists+linux-can@lfdr.de>; Tue, 28 Apr 2026 11:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25342311444E
	for <lists+linux-can@lfdr.de>; Tue, 28 Apr 2026 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB703A5E9F;
	Tue, 28 Apr 2026 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hK88BCl7";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oDQP+k3H"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F93A63FB;
	Tue, 28 Apr 2026 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368784; cv=pass; b=ug4DniEgnrAzcUErROsNiGxUuTLrpKEVcufEam/SB9Ol6lKyKAyiIiJkHYMz/ho5XB9VBfGV66XKLwij6lZBNZVbGy9OfeTNwl1xmbnYd2BgxGEozqkskpt9AqrdUeoR7A94m5niDObJvOeNcEeIH5L7ZHA6SONGpMK13Zk7gbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368784; c=relaxed/simple;
	bh=Lu34uMi85lFQFjX75kvNojH/UZF+64AVSaW3FU2iwek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBCDU1VLe8GCUFBGKrVZ6llvlTmo86IaXkga4v4L8rxA3QdLvoAiaA5y9zHcAkxfi5QvcuzTnAc3zYvIApnLx8LqMH04xXJOkph0h/Yw0UEJtFqkKYdXISPkUpQ74dar+O8YsxIQr0H0zw9bawSmhitQgKaWSNr4X8rpYIzydSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hK88BCl7; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oDQP+k3H; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1777368780; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TqA5Ib4/ZyAduwriRlxtYZdxYc4OGqmtCBsQZSuptx4t2FqKIbo22XndTs8aNa/jXP
    Xc1PhxT5Pr0yAD53Ob6bRGT33+Wj4HIvOV3CdDqC0cMsSedzYwossr05+Eb29zjp7h24
    T4m6bwBP1JiNEYzcJNX0/gRomwtk1U7sNU3BYGPJou4cV0I+6EKgEoha5yQ8IBX7EsK4
    L8pn8C/h+pMVi2hNt47IxBtIaAWqoidsUgTMo7SSkaexw1zv1xkCrJjirLfegY97TVCq
    TJ0f/5ytDqAplmrcvsjoqEq6iwmNTh6QzEDZc0amwjv4NfdWAmMB+EbmaW7o8HESjUuK
    axqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777368780;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7Xm7JiEkjYA6g2bt0eSvSJyn5FJCC0ca3cnkvHUP7ak=;
    b=kYO7vEpuRALRs/wJI3w6ROUXlWLcv3SHaofcdS84YorBPs3a5cwerLuOkcd3Z/2AOs
    jH3kLS201ec7t0oa6UNoRqUZeXsMzOv/rNxy/JioUMzUWH4iTVWTJQ2JOp5AHMQx+AWo
    5p5LkoFwLvmrGQm6/ZpSAwaYO02v+5UtVdQvTqx53gHgiEttKjf8pXCkUqkLIrGhpmjw
    A9dhDpki7pGM7hFQkvEAhIoLD8T0Ep2gjcp/GO7jYVPkYXGLcqcwJDsyFaMeIKm1qwh4
    21s04ZhSOJINKf7CXdGBUG2Mfk8zq3Q5FE0PfBnOZ9nvd2LB1VOzL3FrAhjr8yWRkUob
    DPXA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777368780;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7Xm7JiEkjYA6g2bt0eSvSJyn5FJCC0ca3cnkvHUP7ak=;
    b=hK88BCl7P4pxcqVR2UxMk1HtdPQhYQj1xv+NoX7+94McMkujmryENyATdV+vi1tdm+
    5y2SYXrzNhw4xzZvS7NXhObhG9HkhHWCwoydktXHAbPtUq0N3vhwjGzeDBVwvc8INlKk
    8fVvLcEgeA8v0r1W6C1zYL50BGXK2S1IIq3Yn8+xrXkJh0IdTIJDqrIKYtQboyYmdlqv
    2rEF/t/Gy+bqjr5R1eu9bhS2wBJVvLYdc5lQPRGEAQ/1xajzgvmECnLzVwtLYNPhkJBl
    n4dKvFb15lfgXlijRZnFlfgT653L2OfQHN+q3snU3Y9mW/uz2328EHJCSAyw/3DUpD6Z
    FpZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777368780;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7Xm7JiEkjYA6g2bt0eSvSJyn5FJCC0ca3cnkvHUP7ak=;
    b=oDQP+k3HjLmtN+YbBJth3WRE7c8YgMnDf4+k826Pijf9yx3lBn4mm72fy1MsCAO2AR
    NJ+giv+kMeSjoJhgsvDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrJozOHkwxtwKntYe0I1zz8hIldN9ryOkQNQfIcej9HjqQwrv"
Received: from [IPV6:2a01:a380:9c0:a210:4e8d:f51c:9f4e:efc7]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d23S9WxyVZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 28 Apr 2026 11:32:59 +0200 (CEST)
Message-ID: <b96cce17-abfa-41b9-9a9f-a34454fec4d8@hartkopp.net>
Date: Tue, 28 Apr 2026 11:32:53 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
To: Lee Jones <lee@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260422102239.948594-1-lee@kernel.org>
 <6cc6eec9-2e8a-4a39-955a-0eeefc93fe97@hartkopp.net>
 <20260424-magic-snobbish-rabbit-0865cf-mkl@pengutronix.de>
 <eef6917f-38c2-4bb4-a5d6-98f5a71adf65@hartkopp.net>
 <20260427124058.GA8212@google.com>
 <dd5315a7-87e9-4754-9e88-34c0623aca99@hartkopp.net>
 <20260427-zealous-booby-from-avalon-c9753c-mkl@pengutronix.de>
 <20260428085739.GB8212@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260428085739.GB8212@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 959FC481B35
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
	TAGGED_FROM(0.00)[bounces-7417-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[hartkopp.net:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On 28.04.26 10:57, Lee Jones wrote:
> On Mon, 27 Apr 2026, Marc Kleine-Budde wrote:
> 
>> On 27.04.2026 19:15:29, Oliver Hartkopp wrote:
>>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>>
>>>> I'm a little confused by the SoB.  Does this mean you've applied it?
>>>>
>>>
>>> No. Marc will apply the patch.
>>>
>>> My SoB is probably not needed in this context.
>>
>> ACK
>>
>>> But Marc was sometimes asking
>>> for it when I commented and discussed patches in the past.
>>
>> The rule is: if you post a patch, your S-o-b has to be the last S-o-b in
>> the line.
> 
> Right.  But SoBs are an indicator that a given person was part of the
> patch flow; author, submitter, sub-maintainer, maintainer, etc.
> 
> In this context Oliver's SoB should have been Reviewed-by or Acked-by.
> 

Yes.

I'm author and maintainer of the bcm code - but Marc manages the patch 
flow for the CAN subsystem. That's why I sent my Acked-by instantly - 
which was the right reaction. Sorry for the SoB noise.

Many thanks,
OLiver


