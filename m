Return-Path: <linux-can+bounces-5761-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CE4C9056D
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 00:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5183AAD4E
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 23:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E02F2909;
	Thu, 27 Nov 2025 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dKSDJCYf";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="wDpUBTN3"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FB6149C6F;
	Thu, 27 Nov 2025 23:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764285931; cv=pass; b=Ob1U2JlElrpmHOVF3zJQ3M8bp4O9+Mt60duRRCuChHLg716pdV28sNhH5fxlE1CCBwTMxhzGx7z0YoPQBnJcI838JcRH/BWPIGOW28u88sv8OpFFcILu6TBEHT34I1CeXeIx4n9IQbEK1ZZtozzfw2QUZ18Oj6krcC/J/yaW5Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764285931; c=relaxed/simple;
	bh=88tyCruRWiqo0VwvCm2Wn+kJPLYwOFXZfLD/t53L6BY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uDzznXL04R7ObWDxp6sv8pla/ra4hk/GGx5fqneWDttRfyWpny0qJrSRsh/3EldnpYtRvOE6/GcwbgnKDdd249yCh5m3H9MEQ9883o3cTIOG7v0MIloFsRam7t4WcnLqj67JfG3RC1lcuP8vYXI9axy67AINMearGeMvl2hVcDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dKSDJCYf; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=wDpUBTN3; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764285906; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KpBQKmS6pOhDXmZQWE+rmfSWQSp32Wc/3vhgFlHfcbVmbOgHBMkUw7Y9nnAFtsUTzZ
    GaLCOeVptXT80+pTTj8OtUGnMLblEbVYjCDmL8dzAXSRgBipRpdGjrTUgwprpsSFHnG0
    Rh4oAJlugJpZ6xYLlPuegd9wfYbCN0dFs0Rb4yM2Imh9AlhC9DpFV/++w/4lNgzTXY/r
    cNVFUTuETnTMcy5HYMINfMi2yd+HB3SKdDDBRUSI6SNrHQUJsMuA1L1DQ0THQZCndffB
    0BQQCaHrsr61/2PkCQun5zornrKSt4WqzerqVOMK2Fxmpgd0zpdL1efpPGY1lKQlXaX2
    Prjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764285906;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=TCNQl6EGE2K/tmfppiAkaglEsuvq666I86EUwx15N+E=;
    b=tKbKmApwAD3G+q37Ia2gY3wXuOYw0TINAr3dU9gs5nlgO4CTyR30xrE10D2TQtiqoe
    q65rPCm+Iw/8YHKkwuP5zCjIp0kHfgRuaxW1RGofIAOK1CTuTHQox4pjPlidZ/47XY9R
    DlhmE2OO9rQUn9eXZiT6nI6+XjeOy38XPSnhjAqVrZn96G9WVJN0fZ5d3ASpsyhtwYIW
    /sd2+vBlMsxPcVNChPuN3sGWXqIeE5D0pEUzFa1Kj309QZYs+MjyoNwVoXOlXopRt2J9
    FKJrbDJIKSysYRRG61KgJ983CBNgbomcgIdTodDQlenewcho4j46p0flL7eree3FZf76
    J6pA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764285906;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=TCNQl6EGE2K/tmfppiAkaglEsuvq666I86EUwx15N+E=;
    b=dKSDJCYf76nO/DPQT+E5kAfijs8CgOmcKVlnkX7g9y3G/ndJ2pfQyh5qdvCXA8MrcG
    pPBUrldKgcUqMpOgdF+9gwXCf2ZMOrXvQ6MbbxD/RcFSbq9hV9Czx4imHuZWcLRmeCja
    LaygUQ89foC8htc9Z2Ofp9zBvbaHKDxYN63aNcP5oMC6qlkrqWmyfWaEmUkJcjLkE8qg
    RdIIRzMoTnx5YHZtfWrIgmkgsusx5HtRyUyv4rwSd7paxznmpomh4Gqg6+aJBuvkPWIt
    yx/tCwk5VWlj7dpfRp7GhFi3aR7GBeORffCMyquDsn3GQLHk3V0tKb65T2pW1WYId12j
    Z/3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764285906;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=TCNQl6EGE2K/tmfppiAkaglEsuvq666I86EUwx15N+E=;
    b=wDpUBTN3pGV3T/ex14g3XdPhzfl4u9/LCQ0O7pEeZ2t23V0KS9RqwuHjKKcJ/xxh70
    +c7uEvIHdhrN/vwbghAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ARNP6dMy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 28 Nov 2025 00:25:06 +0100 (CET)
Message-ID: <9b9d6d81-be16-4cbd-b691-6a7b16d85c4e@hartkopp.net>
Date: Fri, 28 Nov 2025 00:24:59 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] can: raw: fix build without CONFIG_CAN_DEV
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
References: <20251127210710.25800-1-socketcan@hartkopp.net>
 <20251127-inquisitive-vegan-boobook-abac0e-mkl@pengutronix.de>
 <f3393f50-02a8-4076-9129-6e8a1b8356f2@hartkopp.net>
 <20251127-hypnotic-platinum-snake-041707-mkl@pengutronix.de>
 <7e2f6939-2528-41c8-aa55-6631ca0b936c@hartkopp.net>
Content-Language: en-US
In-Reply-To: <7e2f6939-2528-41c8-aa55-6631ca0b936c@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Answering myself:

You were right (raw.c built-in, drivers as modules):

ld: net/can/raw.o: in function `raw_check_txframe':
/home/hartko/linux/net/can/raw.c:933:(.text+0xb2c): undefined reference 
to `safe_candev_priv'
make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
make[1]: *** [/home/hartko/linux/Makefile:1242: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Maybe its a better task for tomorrow ...

Sorry for the noise.

Best regards,
Oliver

On 28.11.25 00:03, Oliver Hartkopp wrote:
> Hello Marc,
> 
> On 27.11.25 23:43, Marc Kleine-Budde wrote:
>> On 27.11.2025 23:35:48, Oliver Hartkopp wrote:
>>>> That's not sufficient. We can build the CAN_DEV as a module but compile
>>>> CAN_RAW into the kernel.
>>
>>> Oh, yes that's better.
>>
>> It's nicer, but it will not work if you build CAN_RAW into the kernel
>> and CAN_DEV as a module....Let me think of the right kconfig magic to
>> workaround this...
> 
> No need for it IMO.
> 
> I built my kernel with the CAN netlayer stuff into the kernel and 
> disabled the CAN_DEV stuff.
> 
> As you defined
> 
> static inline struct can_priv *safe_candev_priv(struct net_device *dev) {
>      return NULL;
> }
> 
> in
> 
> include/linux/can/dev.h
> 
> this function is now inside raw.c which compiles excellent.
> 
> Building without CONFIG_CAN_DEV is not a valid use-case anyway.
> 
> It would only make sense, if someone wants to create an out-of-tree CAN 
> driver without netlink ...
> 
> Best regards,
> Oliver
> 
> 


