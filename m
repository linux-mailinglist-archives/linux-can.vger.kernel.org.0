Return-Path: <linux-can+bounces-7671-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EFgNsGyDWo82AUAu9opvQ
	(envelope-from <linux-can+bounces-7671-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 15:10:25 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD658E891
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 15:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A5330530CD
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E8823BD1D;
	Wed, 20 May 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sGdNG4HH";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LljXYtbL"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023E23B61B
	for <linux-can@vger.kernel.org>; Wed, 20 May 2026 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282158; cv=pass; b=MMLRv+jVqmPlk98xYOU2vWhDoKguBEfip+VwGbjBYW27oOO0nUsiNyCW8C9qRZRaJ+8x/dPSqd0I/6oGMlbz4rlMVupqUzV3/eQwMYN9FX7Xs/qUqXHQAsnKGdvnnfE9bSq/KdvaJscQUTowlyXOSpzCEYl2HiMx0S8vT7wA5WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282158; c=relaxed/simple;
	bh=0S3JxLBNiJ47Ro4DhUZT1VKIRgORM07lDIkVPoAd8Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYJi72pPuWuhv27d411Ly5l2O4y8m7LKFZ608rq9J2g7oz4VbHfHMq2UwRVmNz/ClBvCPVHvWu/tO6zWkjuwWjx+xGE+ET0ASarjPxx9xNDN5tjWFzpbh3ZWuSh311T0HIp1wDzC/4IDMOZS1+ZKuJvwRuo1nKQYgWZ+lYRindw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sGdNG4HH; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LljXYtbL; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779281971; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m15h0U41kq5brcnD8RwiX3romvuwJKxVnBG52DuuyXNweKyFQl3rLdSnD4OAf3fOUz
    +C4uqiKp9GY0QKwH1adzYVUAlexeajhhdpaN4YrZuLzvv5x+I/V7jp9Nm+Q5RrCQ/swh
    4BLcJyKDp0XmxDlBJ6IVvaFXN8d4zylwHjZ1tM/dfUlZCvPZF0Ox4qLH8yy6gDpoVTpa
    pcEdxjwedl8EzGn19r0ODwzxv5RX//Ho3rCeWIlig7WbfhJPT5tNADsWPHTh2Cmu2Cdc
    Rfm2HhPT6KGrL3UBH8lCSvzvtrb/4yGDRZJTSyLLi9aZCvGNFHw4obPwZks0nq8HfGXx
    hOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779281971;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CV6fV3lbUd39/0ykU2bOT0K9M40NSD404A7ry9UrQ4k=;
    b=Wmql8uPIaFJuUowfp4A0KZFmuvVh8ETG4kBMvi6zZ6d7Mxxo+R8bbekLN0V7C9zBIv
    E50L5ASJrOgrUEtAnfbNzd6Ln/3yfSPdftz+RKzbljbR9AxqstRA/IgkihkFuW0vS4Xj
    KO/8wGekGcZIu0DEc1MDXGbdKSMIA6iVzNV1h9HAJrbNiAQVeOpovUkZmdTlqEZkGHPk
    Xc/xqiCR3hDwN5VaROASi4PLmnwzvm/4Tg2s3G8CqG4CIaUE4cK5pM1oeUYo0KerW2kM
    4QpIZ+fRV8WeM31/oTRY9Lnxu9/DXBtns+b6FYYjsjS7aEstWv41Y+EBAwzkP4iY9Zb5
    jVZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779281971;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CV6fV3lbUd39/0ykU2bOT0K9M40NSD404A7ry9UrQ4k=;
    b=sGdNG4HHeInXZ6WSYoKUKlS+Sc2BxXxdNHy7H1SVumLrfVALQg53PIzGQbUr0692En
    5oflDYmOlmsQTRu7orEU+7yWyn2nX4F694X7WFCdlENAHNOFFfjjlsWb4hD6DYc+XQve
    O/rhCeToB7gnjbNDAyiCFOOK/mnBz1/kUghefP3hJ7Jqhy5Aad13K77H7LVaHMN/xONA
    YJYWd8lipXGePE7KsnhszGkdVomf1DwAQAOn+I4deqcjea2eJHIrNY/UN6G8ZiWzoBYu
    wcdqlRYxFZNjHAHJ0vLcXccXuk8nS1Mdov12oB5FN4+Lu90KniGCvijKCO/Oe/1nkdK3
    htsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779281971;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CV6fV3lbUd39/0ykU2bOT0K9M40NSD404A7ry9UrQ4k=;
    b=LljXYtbLHOlaepZYZBANUHbs+Dgaf1A5p/MgCD1iiJszeP8hgTXHcUSgIAUs+HgLOJ
    w0kdtBAN2FXocONOY5DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24KCxVLS9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 20 May 2026 14:59:31 +0200 (CEST)
Message-ID: <477e064f-766d-4db2-887e-11c53e804cbd@hartkopp.net>
Date: Wed, 20 May 2026 14:59:24 +0200
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
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20260520124758.GA305027@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260520124758.GA305027@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7671-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: 5FFD658E891
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 20.05.26 14:47, Lee Jones wrote:

This:

>>
>> [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to bcm_release() before
>> removing the CAN filters following the bcm_delete_rx_op() approach.
>>
>> Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
>> the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
>> potential code reordering of RX_NO_AUTOTIMER setting after CAN filter removal.
>>
>> Signed-off-by: Lee Jones <lee@kernel.org>
>> Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> You did?  Can you add a note saying what you changed please?



