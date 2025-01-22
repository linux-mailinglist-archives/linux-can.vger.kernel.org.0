Return-Path: <linux-can+bounces-2675-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E73A1920E
	for <lists+linux-can@lfdr.de>; Wed, 22 Jan 2025 14:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742EA188C9B3
	for <lists+linux-can@lfdr.de>; Wed, 22 Jan 2025 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A2212B1C;
	Wed, 22 Jan 2025 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nUudyh7r";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LPoPxUWS"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39A20FA8A
	for <linux-can@vger.kernel.org>; Wed, 22 Jan 2025 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551271; cv=pass; b=k3YMAPHTxMCOcvgxOyK3w4+9Z0Hx1FpNQu/X/lMrIRHF/VWffT7mhpGTQZhlKxkTrmwqdtkmwa+1VX6fmsQhjfklHubnDCdPlcu9PVJYI38Ms4dI7qceWmHeoYJNLnB/oK/Q2xh/9QDt6ZdoYaq1Z1RgJoXGgDZgiWc0/cuJRso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551271; c=relaxed/simple;
	bh=96V8GNItChcPcKC5DNCBirLHZhET138sRl7hvPiybf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fgs5fbL3i2JYpjj/sZwTiQtmBas1M+B9HCrBAJgG07FlYqegEP+T9dmpcrNp7BrSnjesfK7e5DX68kT4lTISTFO7WChe6baq8aJ+HOiEB10O9jZhP6qZ4UALKuLkVrYMFvtqvYeEPKk8g/5JaCJfDgURX1aAV3n0GLXWDC8uaJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nUudyh7r; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LPoPxUWS; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1737550539; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fuPRVTFrDIaPQu+nkbufuxVSDF7A2v2fwBPJsRRl4PDOn7AStwSCCTJ7rph58iyZFq
    GDAVhOVWJfk8DALuiiUeEGKQneeqax1+EUf2/fG+VE82iKEbre88WhnloysR4+5IRztW
    Ftgsui4S1tWQf4BQWiRW4yIhpi0b2rvBwHCUxAffkA1RlvetmkOj7An0vWTwfMceJa3u
    nGVWxd69xiDoGKTB+ShptdTKJOMs0lRTrsE+XrWO7pdQjO3d7l5yOu3s3bKNIiWmVksP
    DCKsIl1lT9081/sBVUft2QUM/iUQwTY68y+dPcW3PrT2qnx5l0ozC1zXIabs2lORxRz0
    P7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1737550539;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=c4wa01ok3dgU5JzRzhjMUOvPwUVwN4eFo2ocnFVSVtU=;
    b=UT7uNBW//HkyGq3FWZHrRF/xL9h0Ri0E5gd8LG+aLm9nIM5p5AlJoMqlcZeNR5DKnY
    4uDpDm+UT+U2lzNbnCEAa0GQ02ZvbRjw56KmIUTq44JGVohklNGwxFlr3w8rMKNUPj8B
    N+pg0QQXA3kaeeVGLFOPq7ovWYsmIfaofpnSfxGDbFwVXr+XtNnKDBvwR5PqVwMxpzQs
    fNQgk1zjgtR5Kh0kTFl9NtrhjQoM5OlOHVMRG0w/R3MR/0g+NA4emZZu/vgujhMxRaTu
    4vqmKJpGKP/HoptFthTBTkXlIJwzmyanCWsrVYNTGr+YMa+9yRDkkWRb3X5WpzzzfKyq
    B+3A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1737550539;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=c4wa01ok3dgU5JzRzhjMUOvPwUVwN4eFo2ocnFVSVtU=;
    b=nUudyh7rG3/pHw+/SBdxi3kpQcY0fSi7O9/u0G703HaeLcpPyL5FwsZUZ0nk0DLVpA
    nJb7CbocyDjw1awgpU38D/TSvd0eoEHyohEwJNE4+yyyHFytbCWDhYLyZ5SnIaT4xLLe
    MVUmuW1dXX2SCrRLA45KwhRSym3C8uOGLCYUfQn84bpgfaIvjbvzB23qa36zCodzeueA
    iCGvb0YSedPg7MkQJy1ER0UVV6kD9RItWjDYmCOfaLO73mZrUPtTB188MrXFYPvJeyuS
    sFj0cKYDdrZt1/t8Z0irH2ul8M4LDfOpCylR6ZRhkGh6VtBXvk3NHksNzYnzWV1tN7pe
    0sdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1737550539;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=c4wa01ok3dgU5JzRzhjMUOvPwUVwN4eFo2ocnFVSVtU=;
    b=LPoPxUWSJd/vLDRqmQ6Xp9v4/dLXnJLfCNDyvW2SvntlzPCjs1L9kgiHUTUJThFKD+
    iMpNVQci6IxgJuqu89CQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 51.2.21 AUTH)
    with ESMTPSA id Ka08e410MCtdToH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 22 Jan 2025 13:55:39 +0100 (CET)
Message-ID: <c1cac216-c84a-4221-b7bf-5fa09fa1f9ff@hartkopp.net>
Date: Wed, 22 Jan 2025 13:55:34 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: canbusload and canfd
To: Sven Schuchmann <schuchmann@schleissheimer.de>,
 linux-can Mailing List <linux-can@vger.kernel.org>
References: <BEZP281MB2245032053822A5B4303317AD9E62@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <73bd2d13-6f30-4fbb-8842-77dea6231a33@hartkopp.net>
 <BEZP281MB2245AFDD4037A89E61194544D9E62@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <BEZP281MB2245AFDD4037A89E61194544D9E62@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21.01.25 15:31, Sven Schuchmann wrote:
> Von: Oliver Hartkopp <socketcan@hartkopp.net>
> Gesendet: Dienstag, 21. Januar 2025 13:59
> An: Sven Schuchmann <schuchmann@schleissheimer.de>; linux-can Mailing List <linux-can@vger.kernel.org>
> Betreff: Re: canbusload and canfd
>   
> Hello Oliver, thanks for fast reponse.
> 
>> or just without any options to get the help text:
>> $ canbusload -?
>> commandline in the form: <ifname>@<bitrate>[,<dbitrate>]
> 
> my version of canbusload shows:
> commandline in the form: <ifname>@<bitrate>
> 
> So I think I am little too old... will try again, sorry.

Not sure about your age but your canbusload definitely is too old :-D

I would suggest to pull the latest code from

https://github.com/linux-can/can-utils

Building and installing the latest can-utils is an easy thing to do.
(please remove the binary can-utils package from your distribution before)

Best regards,
Oliver


