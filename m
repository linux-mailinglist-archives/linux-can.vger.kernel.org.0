Return-Path: <linux-can+bounces-7354-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BXnDEqt1mmZHAgAu9opvQ
	(envelope-from <linux-can+bounces-7354-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 21:32:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C71633C3281
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 21:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DAE6302F155
	for <lists+linux-can@lfdr.de>; Wed,  8 Apr 2026 19:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966C3783C8;
	Wed,  8 Apr 2026 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="a9sZqD6o";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eiOXv7/q"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB5377EC1;
	Wed,  8 Apr 2026 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775676673; cv=pass; b=n3uU8UudpBdu0jq+nIKamwZ93M0U3XtBM6lYIh9IuXW6M22+gSIC28tDheYJ4jJRoxrsMoX90KuoJCPcWvJHGkBMneJzY4jYT8sEA0dSe5ep54BlUGLyn0F8Tkms7zTc5P/gH4L6U4F66prBT3hxlKNaB0svUg2kYjBQQfQEw7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775676673; c=relaxed/simple;
	bh=Buq2AsHVZb00VVwwEMMsOyvuFFxLm5wcoR2lEbwbj90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXNBzVMH+Sx2kT66pCaCR+ZAYNsqaqqIMGEYe3nwpCxKskVZtLrEO9H4+n+Dm1rnIsfoa5UeRs5pFI5pbGgawWnWyuusXqRmhuH+Ynv998FjtljG6jA1v4KQIqYXJ+On3xHsSZ/FT9nrOUCzhhOw2Ur8Wx/rRRS0kWVZ9ncms4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=a9sZqD6o; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eiOXv7/q; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1775676661; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a+PrACrbfnhOEpAOmft4ngKYneODmYy2WMI5Bw7WyEeDlEFMrT1wVl7V3fBDqFTl7S
    4Js7xKqPAJqXEaBiTD0zq2DHW2FwF9FniaZKgwrAcpGxNRLmRo0y9ev7nGvLzuFvpQHl
    b2IvF+N+SyYHVmuiP2/OaWGiX35sAqg9bIVplpC7t62Kio05lyVPrwHXi8Vnoi50cTiL
    fTswGJDeag7A5nCyK+0hOYOtI5aPeEVUEKmzt3/44bi361xfr1ialw5e3wu8Z6smkqX6
    x1YZ5o6DTPN1jQwJR8NieFWTLbQTtx3Snjj7Cr8TLQiqwuODbhhntxmNvX9Qn60ZJd+V
    mUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1775676661;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=m02HqMNt9VMoLgCmqs2Z45hlgc1IalOOpVZOqlf45kU=;
    b=oKfMWXwv3f13l2IPbRuYepa49u5Iq4n6DgBwMTvwaArghM5RKOntTNvv4HM4RP+7E7
    fIIXYsY0PcffVLYxHjZmpffKZ+d137csRJPfSSxi9KUFnfNKpKcG4CrHLazkXrYM0aKx
    1QbcYNRVPxQoLh3cCML/ZXLBo4XQlsIyR39ftTNDVaFRi5T25RiPlkZi4w1WTvL31vpt
    BkSnHwKXys55/HwfCvdAd60tXepEWloUbyQiP1RT0A6V3CtmqVBSTyhNTyfWPnrBx8Id
    Z1UZmpEyxSuhwd8+yKgfYguH9e0wry97OEiHQJeB0vlSxH6zctT+l1tAztyttq9ugm37
    cpwA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775676661;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=m02HqMNt9VMoLgCmqs2Z45hlgc1IalOOpVZOqlf45kU=;
    b=a9sZqD6oR4Gk6oDj4ucjfXRXUGVD3W/YfNuSYOebHE09r2NXcCO/no/Af1WFIvwat5
    puNTLb02mhY1knuJL7zLqeGuLQFTAn4CedfVYJVmhTP27rJwH8bVf8Yf+XQJPAYPuW6Y
    QtsgJMNsntEDgd67Ax8Sv1LCjwLbjwq6BjCLx8swfQoNHr3jBhPg/m4wAunDLn4/6neB
    9oeZY1kg996PKF+rUK8+smRtGuA2KXbtE4dj7yotykwiVxa9Fr4gN6OYQ4gwkTxOECFX
    3nS9Ilss8WQzqbJYziVenpJc2Xq2SZ1Y/erY60kOnJhGlR3Uhr348XE1tTNiXCRHYKh/
    0BKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775676661;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=m02HqMNt9VMoLgCmqs2Z45hlgc1IalOOpVZOqlf45kU=;
    b=eiOXv7/q7clVoNF25pxjEotgC3Q4BpxPUs79D7c2DmQNvlRe4UcpgweLnLqq9kdOBu
    mEO0s3tHdNIGD46MslAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRsLs5FrPm8xWJP2FLGj7g=="
Received: from [192.168.1.104]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d238JV1uWw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 8 Apr 2026 21:31:01 +0200 (CEST)
Message-ID: <0bfd04db-ae11-4a2c-9d3d-40d0a86bf4a2@hartkopp.net>
Date: Wed, 8 Apr 2026 21:31:00 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: raw: fix ro->uniq use-after-free in raw_rcv()
To: Sam P <sam@bynar.io>, netdev@vger.kernel.org
Cc: mkl@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
References: <26ec626d-cae7-4418-9782-7198864d070c@bynar.io>
 <c67d6642-8078-4144-8b21-f0e882ecd61a@hartkopp.net>
 <430cc8b9-21f0-4954-ae36-ec5e63f3ef9d@bynar.io>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <430cc8b9-21f0-4954-ae36-ec5e63f3ef9d@bynar.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7354-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C71633C3281
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 08.04.26 19:22, Sam P wrote:
> On 08/04/2026 17:28, Oliver Hartkopp wrote:

>>
>> Can you tell why you preferred the destructor solution now?
> 
> Thank you :) I preferred the destructor solution as it seemed to match 
> the socket lifetime model better and I wasn't sure if the blocking sync 
> in the raw_release() was too heavy-handed for this specific issue, given 
> raw_release() already holds rtnl_lock() and lock_sock(sk). That said, 
> I'm happy to defer to your experience if the sync fix is better suited, 
> I have tested both of them.

Thanks. I think rtnl_lock() really might create a performance impact to 
other networking code when syncronize_rcu() waits for its grace period.

>> And if I see it correctly the UAF problem might also show up with the
>> kfree(ro->filter) statement we can see at the beginning of the above 
>> patch.
>>
>> So either free_percpu(ro->uniq) and kfree(ro->filter) should be 
>> handled after the finalized synchronize_rcu() process, right?
> 
> ro->filter isn't accessed in the racey raw_rcv() path as far as I can 
> tell, and I don't *think* there are other racey paths but it wouldn't 
> hurt to handle it just in-case. I think this would be simple with the 
> synchronize_rcu() patch, as you mentioned, but I'm not sure with the 
> destructor.

ro->filter contains all the CAN_RAW specific CAN ID filters and is 
allocated if more than the single default filter is required.

It is last used in the raw_disable_allfilters() above.

So after the good discussion I tend to your original approach with the 
destructor ;-)

Will add my Acked-by: to the original posted patch.

Many thanks,
Oliver


