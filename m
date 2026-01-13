Return-Path: <linux-can+bounces-6126-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3DED1A4CF
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 17:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89BA93002952
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2530B501;
	Tue, 13 Jan 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bxWRDD06";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gPULQ4cB"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100330BB8C
	for <linux-can@vger.kernel.org>; Tue, 13 Jan 2026 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322080; cv=pass; b=CW9v5LUuwqsTVfc4fPIbdHRG/jR9dQjLUd+Bue+w1fViQ272pEFuPBeIOe1OoM5k1RHk7yfYODZjDM6oHVn05hm4jkRsU6xOri/dpFyfcWSz3UCsPJBjr3kFUq4be/Wkw+GIHWDOTzZAIqz3yh0OwItCOloMdc6t4swjAPW14eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322080; c=relaxed/simple;
	bh=/L2Fb/EQFLdkTfqe5pkr7A3ESaNQsE3rTEqS5an/BTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJmfxwt+IpsF95ERpyAMGHLM94d/E7gYBu9z0M/bS+DuBLoZHMpeTKznk6g6SphC3Y90gvjc1mAQlOMdyjY/wbn807a5hNQ/aYxbXF2W2BTJSjOdpMYNLUTsROlReusgKKGZFOLB27wZjH1SJU57OltGrDfdAbA6uW7R+KmNMMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bxWRDD06; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gPULQ4cB; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768322071; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iYyZUO4neE8PF/FupHwWy33Kqktj5CR9G/gtBVjYS8FOpgpImbGJisB5gfbdFAHwum
    SeQXkDhzY/1F/+tDTv4pQVWJSIiHJGdjIhhAVNtsN/SdxdE80VO84RWFSV5KsgAy9Sz+
    pGCPSO6SPpT3QDjR7mGhvzf0aqmuzaCB7tme6VVI7LpAgLomT30ARVeoHk11uTONLJjA
    D2VzaWmLxWcah16lyse0/SaMXh4y4DgFu31TWGlcfVFauDJExIra0Wk3GRSxTL9Yvv2E
    nZwlxFV/0GV6LY2jiH+GVwZZ0Kf0tslmPgLQr/qb8PgxJEmLLuzIwsFjP+T/eZEbJvGq
    syWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768322071;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2jJSIr0HA0os2M+7OeXMCoQnDvuXdCX19DTaFIfovxI=;
    b=Rf8hVVBG0u8Ml6eWWZiRpAL1LHhhKzn3f4rRfHi6HReQJTH6huVKbFL6ty4GKJDjk2
    IS4s8koaeZpkZrQLUBc5TzSlTPe+wHcntj1AhlJz6ZmmEMOgfHRNWaXtd/VU4iu617oj
    3Uu/8qVC7CiRa4PZA7rH3yAEfFySgb+yas6gaOC2G27Cqh0d+wHq06DgFSB0H1gQqTHa
    qitDbshlpvVrt6r+n/CduSnmHJEkESZ//Km4VcnttBxuQnYaiIMbX/rPGBM8c5bopeTc
    LkLke8qeDX5D4QbdlFR4jsawh2n2HUGl+up3V2t96vAGlxShLy/8MKQnbotDV7rXOT/T
    YO+g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768322071;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2jJSIr0HA0os2M+7OeXMCoQnDvuXdCX19DTaFIfovxI=;
    b=bxWRDD06KNg2dS/nTl/8SqATA2oXpqzNptnKYKIo8IZlsWD9/p+Lv4i9Yl8qZK0yAQ
    0UvW4is6efjdqZ2nxoTkml51c1xZUAexTdUCZJWeYZW07xYWKkeZXldNp9LBnGdzRIHH
    vCXhDXq1UADcVk42l5z9pwMJHmVYcEWhxWhKYTjxBlYvnEM39GRB1TIJmYyQXovxXWNQ
    YtuPIyb0nv/smWPKL6xsfsXPOwn/dfB9YFjK2iSNqwa76/AWbHQ6U/ymdu4b9hrgNksY
    qPYHr0wQUpSK6igGBDIM4fgT+EnnG2AY1xwDRmKVmX5LpTQzoHuxtszAq3+WZG5xmsjx
    2I1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768322071;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2jJSIr0HA0os2M+7OeXMCoQnDvuXdCX19DTaFIfovxI=;
    b=gPULQ4cBfpK5Hv7TghTx6nyzu76DSsrczXLT0qmuav8SqvTCb4wDUDdId8aKEQcVGx
    9sWtp2SUNc2SNWuZr8Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20DGYVoBH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Jan 2026 17:34:31 +0100 (CET)
Message-ID: <7181f618-ea88-4445-bc0d-e8e3b15bbe5d@hartkopp.net>
Date: Tue, 13 Jan 2026 17:34:31 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next 4/5] can: remove private skb headroom infrastructure
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260112150908.5815-1-socketcan@hartkopp.net>
 <20260112150908.5815-5-socketcan@hartkopp.net>
 <a9af2a4c-340d-4246-b35d-6fe42a419086@hartkopp.net>
 <20260113-subtle-meerkat-from-hell-678184-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260113-subtle-meerkat-from-hell-678184-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13.01.26 17:33, Marc Kleine-Budde wrote:
> On 13.01.2026 17:27:59, Oliver Hartkopp wrote:
>> unfortunately I missed you in CC for this patch set:
> 
> You are so sending so many series recently, might be a good time to have
> a look at "b4". You can automatically populate the Cc with "b4 prep
> --auto-to-cc".

Ok, I'll take a look.

Many thanks!
Oliver

