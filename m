Return-Path: <linux-can+bounces-7207-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO9HA0b+wGmiPQQAu9opvQ
	(envelope-from <linux-can+bounces-7207-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 09:48:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB7A2EE706
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 09:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B9D63010B9A
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 08:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF2E35C1A1;
	Mon, 23 Mar 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="It4O2xAT";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1aMtFbF2"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F23112B2;
	Mon, 23 Mar 2026 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255681; cv=pass; b=bLNslZtO9jzFi28NChXpERyu+rQh5HSB7CK5RpEQdt3O4YRzjIRt2UTtLdX5WfsDZSYYy1d93jMJmkQ4vt0jHmHUuY/PTnhO4yC3ojpDkC7PLq9Y7UJj1d6LstSf96p0uG3P2/BSUYtG6HSkbKiF5PzVeqMwxlmzoYSMw9YHhBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255681; c=relaxed/simple;
	bh=l5rWZo340dCoJMUzR9rF3O9wYPWZuiUCO1HXqAmr7Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvf8yEJuqo7g4v8CCWKfyYNSeWNwa2Y8fzm+sycZlCu795t9cynUYilZ2ocJqPVqP4hGcn4EJ/sMVJRkzP4q09nMUgGfAKWMmH1GqtwugOXnWYRMHuFANHucfYdWZvinfrupXdul4fArx9kI3sa2y5jPJ9X1hQgK6WC4/RqRTLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=It4O2xAT; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=1aMtFbF2; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1774255670; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kMwHuGcWrlY1766mKTIRxd5ER/LOAUoXmA+YTZ3+5SsB9+1FHjtBwt3QQ8is7T6idY
    cSPCTAWzpL7NDnHeEE6RCE0Sy4Yy7UGAikweeoS4c/F565IRwm4/ba8JjBvG2oAjfQFf
    ivWsz9y0kuScLpSOqrd/M3brqjyOCUfhOo4iLEXElU+QIRMBfZ5O8bXq09D8CJUH9Wro
    EskXhKuCKAfP9AckOIGO4GuaOqjqZOLmifUh8itNYUROJ5s8dJHMAzJwNKVBuytUr6t4
    S83RzZnEny46zLYBbC5im9HbK0ireFojcNHNKigWMQJAzpnartaMmVKzadxs4fRJVOrg
    d/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1774255670;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LSR0DeH5RDF5iagrVyd/tBSrkgYzOhJKl4KJzyxVvxI=;
    b=hFnH/q0z5Tzcym1HG5kcaEpwqPcMOf6P7bpuwaFgrjbv/EhajNKtsw/3csgSUlyNxf
    1TD5z3VTmwPLhKxI3CVjIBu+g7WLClD/7fb/C08gbhUhFT/hIShhmzRz5aauxa81FHQt
    OA2iAsW4FFfHBjoSI28KuF4Rv/xSMZIKuoaENXpFbdOrU7HzMrCLw5sTsESgsGIJGPgo
    c9PtaY6/kb0LhKRDjC/lf7mKI6Bf2YDzoilf21L2L4BHjAz6hT66JrIwTmAHPLnIidgs
    0vvg5fInuHH2vtHVv/YjqXEdBPJ3GxG2uUbAP7+zRPHW+xnJrwX+SJW5oKSy9X3ZAvJd
    9HFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1774255670;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LSR0DeH5RDF5iagrVyd/tBSrkgYzOhJKl4KJzyxVvxI=;
    b=It4O2xAT9UrHdhUWdfMteHdjDsqqXxEhNxo7bfYWpFsK2Fv+tuwT05mPsTxwSOdoxp
    Z+38rC13abwGnJsBx2eJ6XO6gw0aJkYd8stAzvt4zDVrQCmRqERsUVhyR8JrbcSL0en6
    1pSTcdnBOb+RGk/A0RQiDBYQgCehroesABDK9k9P5lJMYKw//0F8dRtLgvUTzpxYQT7y
    tcRyHR0Gg8SO43CpaO1HOgJTIQGNT22zLhtXTcHxkAf4eZgniF+PLZISWy2x0TAzmeoV
    3wSEyEMuxWwP06x2W+f5SHrTdPzu2B/bflHBIxWZtSbB1Y3XrZso4L0XBgMBve9IK/Uh
    XKSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1774255670;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LSR0DeH5RDF5iagrVyd/tBSrkgYzOhJKl4KJzyxVvxI=;
    b=1aMtFbF2Pm1FLcck2NX5JiBBpMjIhmpiNko898/RmsFh0ZOxiEIR1ztGn7pqi6+UPA
    gGK8OJwoS9lRP4cu6ODQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d22N8ln1jL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 23 Mar 2026 09:47:49 +0100 (CET)
Message-ID: <0f635f0b-6380-47e0-959c-b887461c15d3@hartkopp.net>
Date: Mon, 23 Mar 2026 09:47:44 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Ali Norouzi <ali.norouzi@keysight.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
 <20260319-dashing-scarlet-angelfish-dfaa67-mkl@pengutronix.de>
 <DM6PR17MB2874C391FCF90B09562B4F52934FA@DM6PR17MB2874.namprd17.prod.outlook.com>
 <77a79f13-8ef0-4768-9d73-993e7fd46bbb@hartkopp.net>
 <20260319-fuzzy-premium-mole-4031d8-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260319-fuzzy-premium-mole-4031d8-mkl@pengutronix.de>
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
	TAGGED_FROM(0.00)[bounces-7207-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:mid]
X-Rspamd-Queue-Id: 8AB7A2EE706
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 19.03.26 16:50, Marc Kleine-Budde wrote:
> On 19.03.2026 16:27:35, Oliver Hartkopp wrote:
>> On 19.03.26 16:10, Ali Norouzi wrote:
>>> Hi Marc,
>>>
>>> Sure
>>
>> Btw. I'm fine with it too.
> 
> Thanks Oliver, thanks Ali!
> 
> To keep confusion at a minimum, I've send a v2 of this series with Ali's
> S-o-b and the corrected Fixes tag
> 
> | https://lore.kernel.org/20260319-fix-can-gw-and-can-isotp-v2-0-c45d52c6d2d8@pengutronix.de
> 

Thanks Marc!

Do you expect some additional Acked-by or was this just an informative 
message?

I'm definitely fine with it. It can be up-streamed as-is.

Best regards,
Oliver


