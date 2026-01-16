Return-Path: <linux-can+bounces-6178-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8050DD330FF
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6C7F31EA609
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A0D3358C4;
	Fri, 16 Jan 2026 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DksEGf3Y";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="J2CWrE+6"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B394D23D2B2;
	Fri, 16 Jan 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575108; cv=pass; b=EeP8Dd8Ip6OLolqQqjGsQMVWLe1bbB1SSClQCU88RZCbJYNWE6h4uK6tMx2CogF36W4xYNFY5ss0LiwNUA8n1VTLOOKzHUrjOSwNB7bO7ufvMn8JjtuCn3aD+d7ulqHb6l5vk8f6W7qZ05uie1JSeRz/O8H36FyXmIM72O2i48c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575108; c=relaxed/simple;
	bh=qaFV9G3lnOHzP1c0fPatekJbYqwALoVUvhiHTD5HKQU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FXjzkaz+JUIJXCoZ+L0++t4tUmmcjm1aoNAFZpKXw+hk09iX4HOEeypl8ec0LQNoZga1GF47z1m8BqbNKediQgEhK6Qm3YFDtsg3u/1nzO+o5FR2G1B8gciVVbpTX+oyPXW3cfFO9TPwN7HzO6T0Ppm4jSDRxlmgOtWFaiPwtyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DksEGf3Y; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=J2CWrE+6; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768574737; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hvb2LpJ3JQ4Fy/h5ZYsYPlUER0vtCkRncM+ILB/Khil/3iYAqMdiMwo782XkdirRU5
    0eYX5tjH1UnlMEjTotaYSFlcP8QK60L23WazeZpqBJd4vpk4lMkv+Vc/My8gA2Wo1E6m
    9PHiPAQdKhBUPB+dB6BezoX4OaWDb6lBPYqWgiCHjhVPBb83jUnAq8v0J8fP1LCr+93K
    YUcdVVoxNU7f7dtidtRhbU/5BoVDaBWDLKTdMx8/hlXWB6iIRNHGWpKV14ne0mvPK3jQ
    6krreG9Avb2XSiojuFipLmnhvlPkaryaez5TYe0IFfJ/PBMrkAQTAHETZIOhHMBeobbV
    9Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768574737;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VO0TOLzyVpPlyAwWu2JxgkH3mIolU3aCLKKagvHFcsA=;
    b=YJVMASUHX8h2k7Yo1GTr8CWfouUv5upPA9B2Tl+OPaLKB/aDfQwYL2DqB9XW+Dk7jy
    Nbm9fe1vG3PXNdVypuzsLy2K9yJsMP0b7alvznAOKehyfJXaJvPZMDRboWKOq0AqvgJ8
    6/G729sWaLO8GtVL49EfpvcvhraRG6w9BL5WPFjycA7Bto/s2Wu5M9qpnpgMmPwJvq4h
    hDb+MLJSMhXBDYBgeqnFWfAwpGvM537/eYJ7fyJ9/h0Jh4S8YE35FbIt3jzOUntQcfCk
    cyn+1zcSQ7/aNg7LevzpRqGKHfXNsr0b5Z33FbbCbIrQOoYgIRg2Nh8FqMNffmNJ9quc
    OMQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768574737;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VO0TOLzyVpPlyAwWu2JxgkH3mIolU3aCLKKagvHFcsA=;
    b=DksEGf3Yfuv0oA1hZBbFSAXU30xxdUektU4MkRU9EjH0d2k0sx0qfoXpJXxJtIZtOm
    w2iFD60NmF6rG0EnKJ0kDKaWhUkv10DGdKu1r58csB3usAbgtICESK2VRW/MiVIVlCZ2
    MvBKg5RTyTBLmf3cBnPx1F+vWWQqw8WdRz7iwbe9PHjQfe4nIOvhK2uXcWnmkVkDmRNW
    tsjoyMhIg4Rporf2gQsX3xNDPU/ExFfxTONpe6QNJ6GWbOUyHv4Ep6ZegPm1oUqsPto5
    JWMslwIb65nheGgm9id7IkSdC16gQDpJ3wThWo7pMG7Jw1b1unfBi3apqCmFH/vPeC3/
    RflA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768574737;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VO0TOLzyVpPlyAwWu2JxgkH3mIolU3aCLKKagvHFcsA=;
    b=J2CWrE+6Kom9xNUcqfBJOCiIBp5xWfpe3sN1N2VKQtA1+yyMlKb426mXoYQoYF8lKb
    1ZAAUXwLJ0bRyWF2c9DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20GEjbDeD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Jan 2026 15:45:37 +0100 (CET)
Message-ID: <137dcd58-32eb-45f0-888d-33573eb78f58@hartkopp.net>
Date: Fri, 16 Jan 2026 15:45:31 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: dev: alloc_candev_mqs(): add missing default CAN
 capabilitied
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de>
 <fc7ea750-78bf-42a6-ba3e-4db53a24ca25@hartkopp.net>
Content-Language: en-US
In-Reply-To: <fc7ea750-78bf-42a6-ba3e-4db53a24ca25@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.01.26 14:10, Oliver Hartkopp wrote:
> On 16.01.26 13:44, Marc Kleine-Budde wrote:

>> However, in commit 166e87329ce6 ("can: propagate CAN device capabilities
>> via ml_priv"), the capabilities of CAN devices are not initialized.
>> This results in CAN-RAW rejecting all CAN frames on devices directly
>> after ifup if the user space has not changed the CAN control mode.
> 
> Ah! It's about setting the bitrate without changing the control mode.
> 
> Sorry. I tested multiple configurations several times but missed the 
> most simple one as initial test :-/
> 
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>



