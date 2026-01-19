Return-Path: <linux-can+bounces-6226-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE410D3A19D
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 09:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25FF53014BC4
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 08:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FBF3385B5;
	Mon, 19 Jan 2026 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SqApSH4T";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="uDNZzNiX"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF52D541B;
	Mon, 19 Jan 2026 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811152; cv=pass; b=EMHab5Di/iOAVoSc3r98DFp60liUwVN0xQqGxdwlrOtetCiXkW12FoK0NCmaU/7BUq7kaMxpOEhbQG3bJaGBCIYsR7NmnO8b4oNJKO2tc5PNjp3U6CC0fPCoEbrmHbLOMVDSPKpMMc0Dp7Z7ZkOqUPdb7XqyMwZGqKg08MtvVSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811152; c=relaxed/simple;
	bh=6Nadp5YjJmJ0aVCbXhwQcELJ8Y5f8iHjAlXEic4S6tA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KeDmgEt9H32x9DG/cbgLEtJ1cLwzm6mJ+JchTFfLxVymiOd4V+UUUUNqEjSLtr0WnbbVtB2jGY7hCy4GZ+Gm28Io7Lutmtfw4dBfh+je6x0Zm0LOysKSncaPZT3IEfwDy7bu0X4C/Z3XuNuF1t2tLYkz641N9sOiuLDcloOdM3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SqApSH4T; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=uDNZzNiX; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768810966; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=S/f/6K6v7cg4oZ2L+atO0Tic/zcaRzLd+5GIPmRNox5IcVj6ISxkKt5fntGtvh/KmM
    dffJESS+Y4SRggOojDQsaXgwO7QDdj3AGVcWodSy5MkGLQQggtuqVrZ8ZjEywY2Zj99q
    fBzyN80SuJ8iZpngLaROE8ERgpKOieFr8o3/QjSJGmBlwnZQKbqYfYFctQ0x6qY0xLRL
    xT4ddGW7zNwJkDZz1nM3ydRQgBhmUAofk6q9Aq5A3v9dIvsOK7JZUfJ9jJm9FO+YwUKt
    eHphDz5cFwmzyQq7F6vXZYyXuiuGzkqcGx3qsT6hBUKecxwrCxn0M5qmiS4oKsfFscPA
    UKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768810966;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=uxxx3+0WS7RL1K3wiz/X/KFPjBdCfhrUNkTSAQHY928=;
    b=WfuB/eifSsIGEZAZb4YH4/X6TL1yEWMbT4Ds13TaqmoT9PQp7ajm5t5c24c7rHahcq
    9B6xZtB0Td2EDh0YB4uJXwAL+VQsNg5EvZM1WGHYG+TRglTlhjUcHRkR2anavzoUlkc/
    tKJFOlhHgavymjZBBPgb5N2AVBaFSQpJxWENec3EQpCKMua+NmS0wBn3t/we5M4TCRkU
    kTf4x4SPm8BEvp4x3He9sCuLQMBNooZ6mbkwnBELhH7TylfgNsI12uddlHFFel18SvUL
    cSPoYZkPnY0VuTfbaAdvggvs9NW4BCxJmwgrftCRwo8VWfpePraHgGSFVCzV8VaRrLnA
    CLJw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768810966;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=uxxx3+0WS7RL1K3wiz/X/KFPjBdCfhrUNkTSAQHY928=;
    b=SqApSH4T5KO+g8brMZQLQ8CxGuFkTFNHYh4qEyTmt2tY1aqL4WdzJdbisojm0qIg0c
    FRUECdOGie6IE01c+Q2ZOHoFHPqN6sgyAt3ZWp/nc36MPR7ruX8Gstoz8jpKW/D07z+j
    bCEKvdTf0coeTxE04MMCNzsFtaqdJjKBi3XshCE/hzsFYS2gLznyh+Dk+1dnq8CtohQ0
    eITJBJOEyXgR4CuRWqxGmvPm9H2dZX7JzPleZkGtTC/ZKysKLxH0hSsaYyWqq0k++j/T
    nvJFZLFH3NGBSRIaMLHXHj84jj2Af3ArClQ2MdaRDsiSHftTqCdd1XrE1OaP4AmyM3EB
    XNkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768810966;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=uxxx3+0WS7RL1K3wiz/X/KFPjBdCfhrUNkTSAQHY928=;
    b=uDNZzNiXARzkJ6+D0Xb8I3rWDKwrgbABh1FWabMVl2wb/3JzOq6Z4MfuvPa0I1sfnQ
    RDyE/n8tVDBqDUdxBXBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from [IPV6:2a00:6020:4a38:6810:ae1c:f386:228b:f98a]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20J8MkbPS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Jan 2026 09:22:46 +0100 (CET)
Message-ID: <4290af18-cd89-4d87-95d5-d24674fa2d60@hartkopp.net>
Date: Mon, 19 Jan 2026 09:22:46 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.19.0-rc6 CAN regression
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Francesco Dolcini <francesco@dolcini.it>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260119071753.GA14836@francesco-nb>
 <be555a81-9448-48cc-9b17-0e3f8c005ad1@hartkopp.net>
Content-Language: en-US
In-Reply-To: <be555a81-9448-48cc-9b17-0e3f8c005ad1@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

If you can't apply the fix or you want to stay on the 6.19-rc6 upstream 
kernel, it is also possible to make a workaround with the "ip" tool you 
use for the bitrate configuration.

The issued does not show up, when the ctrlmode is changed(!), e.g. when 
you enable triple-sampling, one-shot or cc-len8-dlc mode:

Instead of

# ip link set can0 type can bitrate 500000

try

# ip link set can0 type can bitrate 500000 cc-len8-dlc on

But the fix will be in the mainline repo soon.

Best regards,
Oliver


On 19.01.26 08:52, Oliver Hartkopp wrote:
> Hello Francesco,
> 
> On 19.01.26 08:17, Francesco Dolcini wrote:
>> Hello,
>> there is some issue with CAN on the latest linux 6.19 RC,
>> canfdtest fails with `send failed: Invalid argument` fails on various
>> SoC (NXP i.MX8MP, i.MX8QM, i.MX6 ... and TI AM62 and maybe more).
>>
>> Is this known and already being addressed? I have seen some recent PR
>> and patches, but I am not sure they are fixing this issue.
> 
> Yes, this is already fixed here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/? 
> h=testing
> 
> in this patch:
> "can: dev: alloc_candev_mqs(): add missing default CAN capabilities"
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/ 
> commit/?h=testing&id=375629c92fd842bc2a229bb34c4453f62e097169
> 
> The PR is waiting for upstream:
> https://lore.kernel.org/linux-can/20260116200323.366877-1- 
> mkl@pengutronix.de/
> 
> When you apply the above patch, it should just work again.
> 
> Best regards,
> Oliver


