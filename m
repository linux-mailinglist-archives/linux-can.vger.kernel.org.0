Return-Path: <linux-can+bounces-3709-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D3CAC5B2A
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 22:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E09189D5CA
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 20:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC041DE3CA;
	Tue, 27 May 2025 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Gkywb09K";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+Ubeiiuo"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08E1FCFEF
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376127; cv=pass; b=LHMQt+iniDx019frfB4Fia1oSeI4Vqp2TPazLT/5Y4UUJqYupc5FquCLuaTUkykV/Oq8kOfI9AmghMy1mwOdHAzw3ENtj/nALOuMJPIQwxZaYrKpl1SjSSbYyVT69S5P1WyhJLGJhnTLA/UCGLdsxfNO6vamq/q3KPpLv31mAJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376127; c=relaxed/simple;
	bh=L1e4b79sBjAZjdQ+urE4SVRFxbpRQBCUB5oXHFv7Xcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crLxOBGdIgP+JZzBngGmV09EVhNfP34Y2B0zy/Z8KmvuFJRS9O8SPZmSFK6/GSn96qSJBVOLIXNQn1fkQeudb4L0TWq/UTzX/XaVs9P+rWQ7HS6yKyfdEe2tkK56VDLfAwVtfsPliPvkhongciHOxnZmF58WY3yt6O9pmaiOnyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Gkywb09K; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+Ubeiiuo; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375760; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oQiNKFR8CUjchxceZjDQon2W+0OHeo6p17A9FAn7SloIkdIXPsTTTn+orc4jir23wK
    gSMnDjoa8mRV5EZkyvooKU7eg1d0MpJH5I12Nb8/KvHfG0a/lxSEc7wB4iICh1tKjeq+
    U3UphyOA3wfv+6Z/0gYDnIdPMouwT+v/i8M2rQAW9dA4NCPNyDeeqHKoR5yEtpHKuuzz
    mk0XcM1lFw8R/BAn4V9/DOyewpxHDFHdKKL2zrDDYFB8+g6YLj3Oks9/10waZtb+/oiw
    4yk5C8d67NQWHKvkAvP7TuhQ9BVeUFlemUxOsKutnCQ6jjdpHzZIS5a3FmeUnIt7rjRQ
    +xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375760;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VD3omDS9hc6sBbfoO5udJLfFEc8rzX/gcSdyj5FC7ow=;
    b=T6EfMkhx8tN/9HlkYrqJzR0/t+kKutTPryyzEJZToJ7gWMoyQZlSfvq5QaM0dHEAp0
    hdJqF9KPMyw07ocg1P+xjv46ot+tU/rQjrqL42hIobDNKot07eRZLOHBlZhMniBEz4y4
    2JkhF16P/u8/jMQnmfMt827AcEqPdvAm5UKPcbnxqotUhXbrZ/mvET4qkW4qs1qccEaU
    Za5HKm4DsVSJUnwiQuf7NXf6W+AuhS1be++KzUB7N8bGWFcRvZG2XzJrStleLuYDqT4w
    LF6MnMd9tWAqMNTBKSDMeAYkIKpnZ2jmwMnB4LO+Gkm2oue9/kBojJQ9fMb1LobZZJmp
    trjw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375760;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VD3omDS9hc6sBbfoO5udJLfFEc8rzX/gcSdyj5FC7ow=;
    b=Gkywb09KC6ytla+jh8ECTc2xFMJerrdTXepcYicuiWsRL0G4napplH5g8HVZ3CekH6
    SrF00gUlbF4SdqK9BZnTQNX+5MuTUmeDHueugTKYJkYeA5COpvoH9HENv2mpn+o8Enoh
    V/c+wVmXGrGmThZfPITyLB72hD58PRurBUiEL3SGso5w4VlO5vlbGgUUaqQGxIopC9b5
    7cWvx1RYGXRSn9SYkk16L0vT4zXBFVCdViHLh4i6R9hWXwinysxJbIFxpd1kHKbsCxr1
    2W+ubsdASglr3F844tnhxbXIoUaxtwVO8NqocDsVPQFBRW5LWOYM0NsOt0Sj7EgaD6dN
    dJZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375760;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VD3omDS9hc6sBbfoO5udJLfFEc8rzX/gcSdyj5FC7ow=;
    b=+UbeiiuokzW1tjcFMPPXEBQ3s1N7D1+kvHEDdrJ3cPLipDGbuNJQkgmkbtgQ+BSVB7
    Sj4cqpK5RtbA4YDT7ODA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJu0iVt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:00 +0200 (CEST)
Message-ID: <04a7058c-95c7-4adc-a447-423aec0e0077@hartkopp.net>
Date: Tue, 27 May 2025 21:55:52 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Latest patches - Re: CAN XL netlink AIP status
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org
References: <DBAPR10MB4187FB44B12BD9DB8B992256D4832@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
 <06bd3b3f-2665-4f19-b13d-581e57f54dfc@hartkopp.net>
 <AM9PR10MB4184729E14AD5C05ABC65718D496A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <1c502316-ddee-4f12-b0b8-3725cc522591@hartkopp.net>
 <AM9PR10MB418448751B1DA83EED7F50D4D498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <63f2f51e-3fbd-4c8b-b7e4-29cb55246eaf@hartkopp.net>
 <AM9PR10MB41846346BC291F7CFE2CB71DD498A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <49245439-9822-449d-bf2c-5626349d909c@hartkopp.net>
 <20250527-lilac-panther-of-destiny-a13500-mkl@pengutronix.de>
 <AM9PR10MB4184E0842D24A4D7A2FEE09BD464A@AM9PR10MB4184.EURPRD10.PROD.OUTLOOK.COM>
 <20250527-glistening-dog-of-apotheosis-293bd2-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250527-glistening-dog-of-apotheosis-293bd2-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

I uploaded the latest work on this GitHub repo where you three (in To:) 
are requested as collaborators:

https://github.com/hartkopp/canxl-nl

Additionally I will send the patches for iproute2 and the Linux kernel 
here on the mailing list for further discussions.

This is the commit message from the GitHub commit:

     Add initial patch sets for netlink CAN XL support

     Based on patches from Vincent Mailhol and Oliver Hartkopp.

     iproute2: patches based on iproute2 6.15
     linux: patches based on linux 6.15 (mainline)

     When applying the linux patches to the current net-next tree (6.16) the
     patch 0001-can-dev-add-struct-data_bittiming_params-to-group-FD.patch
     has to be omitted.

     The new features can be seen in the ip help text with
     ip link set vcan0 type can help

     (..)
             [ xbitrate BITRATE [ xsample-point SAMPLE-POINT] ] |
             [ xtq TQ xprop-seg PROP_SEG xphase-seg1 PHASE-SEG1
               xphase-seg2 PHASE-SEG2 [ xsjw SJW ] ]
             [ xtdcv TDCV xtdco TDCO xtdcf TDCF ]
             [ pwmo PWMO pwml PWML pwms PWMS ]
     (..)
             [ xl { on | off } ]
             [ xtdc-mode { auto | manual | off } ]
             [ xlrrs { on | off } ]
             [ xltrx { on | off } ]
             [ xlerrsig { on | off } ]
     (..)

     TODO:

     - clean up patch descriptions
     - maybe split patches
     - add recently added features to dummyxl driver (e.g. PWM)
     - set priv->can.clock.freq to the common value 160 MHz in dummyxl
     - PWM rework/extension

     Currently the PWM setting is simply to pass the three values
     pwmo/pwml/pwms to the CAN drivers data structure to be set into
     the controllers registers. These values need some sanitizing.

     Additionally the PWM values can be calculated based on the CAN XL
     bitrates. An new algorithm should be created to calculate PWM values
     when they are not provided from user space.

Looking forward to the discussions.

Best regards,
Oliver

On 27.05.25 15:55, Marc Kleine-Budde wrote:
> Hello,
> 
> Cc += linux-can@vger.kernel.org
> 
> On 27.05.2025 13:43:05, Stéphane Grosjean wrote:
>>>> This is probably the point where we should switch the discussion to the
>>>> Linux-CAN mailing list.
>>
>>> Yes, please do so.
>>
>> I don't find any reference to CAN_CTRLMODE_XL_ERR_SIGNAL in linux-can.vger.kernel.org archive
>>
>> https://lore.kernel.org/linux-can/?q=CAN_CTRLMODE_XL_ERR
>>
>> how to talk about this symbol?
> 
> Oliver, can you push your kernel patches from
> netlink-snapshot-2025-05-23.tar.gz as a git tree somewhere?
> 
> regards,
> Marc
> 


