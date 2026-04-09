Return-Path: <linux-can+bounces-7357-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAX+C2TJ12k/TAgAu9opvQ
	(envelope-from <linux-can+bounces-7357-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Apr 2026 17:44:36 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 842583CCF06
	for <lists+linux-can@lfdr.de>; Thu, 09 Apr 2026 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC90D3039837
	for <lists+linux-can@lfdr.de>; Thu,  9 Apr 2026 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEF317745;
	Thu,  9 Apr 2026 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="q0nCCLeq";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QmHra0BW"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1239E176
	for <linux-can@vger.kernel.org>; Thu,  9 Apr 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749245; cv=pass; b=lDfucYGoMlUbkhl7YpRLS6xHbGXTdANqjPJzD1LAvyzckNRyRZwwkeHYLbcOOZ/8jyoUll4GbTaL/9OxsYuya2hoUJQ51q3ZeMIMD+idgGB4RDMVnnrum2LCX5rXloXOl2hD4ab1mL0430xWvlaopqcWydTmaA9KMveMijpYFto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749245; c=relaxed/simple;
	bh=G9oQa/fsb3R1kwqCah6lnyhTHtFoBQyhBHYJZl2nzb0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=Y9MMoI/uihIGPuQ3VZL2KCaK2la+Hy9+Hmaszep8AL8EFbSW8hDeepqmCUd6FRy5Q5kzmRg+ehpnMFbI98+AhrUdxCGQp+0t1rWvvurSG7IZfacs0kD4JNLpCWBKrrNHIExjIbSXXuQ96J4Pxcifqhsfv1wEgw2fHFPcyBsPn3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=q0nCCLeq; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QmHra0BW; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1775749241; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OA88baG9Stwtau3ubRtUeFD+oI1cz9ulwqxm+j8PMHfHIgbSd70kLEwnrJKgS8fQ0n
    XFJrwIW6rS/pnjPAyeDFIIx5vMQhpiRTmsZiium/allgMVFWv3v5Uw1T4vaNkSL9YLkA
    QSuebfePQoARbfDaP7LUB/LJxTEFmTnSREj8M6pW8PZDwBXY7OSzERto3awP9V1qduJa
    aIQ5MXB+Jk/65fCYxi6DBjhDOWREGondMW40vXnTbhZ/CuuH0azL8kFRTq90e2OGKN2/
    SaV1qlAX4Km0wAGYmUBdD60saUwo/WyFfjMKAynQi9TNIGSnM4y5IwqtSSl6rGR4U/w/
    cpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1775749241;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Cc:References:To:Subject:From:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZabLTRomNEOdYfaSKn4Fnue7WzTZQdPW3I+wTbtUKqc=;
    b=BilmNWNbb0sff5B/7jkgD2Nuu2f+OILY8q0F1QBosrrYQKPlVXVKbkdZqkFrnGaK/G
    O7ZNZwjr4dI7jD97V2DkQv+DxVZgtqBZoC5Riik2Z5AQY1r4JWX9jgyc/GjcGne/9lJa
    NJP0XrvS5BM1IjGDcoY7r0C0dGPkmG9t7m+eD4MS/8y9rwdvEcMy/Mk5g1CQE9CrKj1h
    YJLA2pouN5OVsVSLR2rk9xdemfrY2xdEgTqc9ZOoDfx1BiO2OXqZCm02G06+Zd9obCTM
    P2iTjfIj5MsczV3MuXMB0nyX2a+mho6nvNUEiuMN0a6dQnf2T26Wz/Sig23dw+03X7F9
    F5DQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775749241;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Cc:References:To:Subject:From:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZabLTRomNEOdYfaSKn4Fnue7WzTZQdPW3I+wTbtUKqc=;
    b=q0nCCLeq0VMeA4Lg8ys941kizK/XeKxlk/FRmWVoGgwhUcboc9buxtwWsTDVdH3c6A
    y3mXNoxfE5IXFbd0c5qolNbX48prAReuoMH4RNPhd61h9ZpeILNieOwpt5PBlZJ82508
    vMRJ2smgeGzGGd3OQgjZHffhgJgNcIbx7IqaTmp83fGl9YQ6hF/O/mLoqKzbgrCNyXql
    o4FpK75/9MoiMd/AjPtli+naoGfqAox5pebgqBCiF8xX+sa+xhJDc4luoZXvqwrFRIVE
    26qdDDqB+T+fNBa1nGiwcKY7d/Bo3x8TBXBjw0vflf+oxGjI55zX7N81DFw2kKtzEPuD
    1TSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775749241;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:Cc:References:To:Subject:From:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZabLTRomNEOdYfaSKn4Fnue7WzTZQdPW3I+wTbtUKqc=;
    b=QmHra0BW4yAl9REYTN/gWtrnwXYMO2hXb1oSJhk20X++sWMY6I9kcJnNf01mdR9cZO
    lE4E85Ulxy1X9acpKRDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRsLs5FrPm8xWJP2FLGj7g=="
Received: from [192.168.1.104]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d239Fefxul
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 9 Apr 2026 17:40:41 +0200 (CEST)
Message-ID: <1b7e62a3-a63c-4d0b-9d12-7dfc986bde05@hartkopp.net>
Date: Thu, 9 Apr 2026 17:40:33 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net] can: raw: fix ro->uniq use-after-free in raw_rcv()
To: mkl@pengutronix.de, Sam P <sam@bynar.io>
References: <26ec626d-cae7-4418-9782-7198864d070c@bynar.io>
 <4fe2b2fd-e3f3-445f-9e06-411bfd9dd906@hartkopp.net>
Content-Language: en-US
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
In-Reply-To: <4fe2b2fd-e3f3-445f-9e06-411bfd9dd906@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7357-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bynar.io:email]
X-Rspamd-Queue-Id: 842583CCF06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 08.04.26 21:32, Oliver Hartkopp wrote:
> On 08.04.26 16:30, Sam P wrote:

>> Fixes: 514ac99c64b2 ("can: fix multiple delivery of a single CAN frame 
>> for overlapping CAN filters")
>> Cc: stable@vger.kernel.org # v4.1+
>> Assisted-by: Bynario AI
>> Signed-off-by: Samuel Page <sam@bynar.io>
> 
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

@mkl: The patch failed to apply as it has some text formatting errors 
and DOS line breaks.

I've re-send the patch with proper formatting and included my Acked-by here:

https://lore.kernel.org/linux-can/20260409130814.72175-1-socketcan@hartkopp.net/

Best regards,
Oliver


