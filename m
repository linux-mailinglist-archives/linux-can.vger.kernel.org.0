Return-Path: <linux-can+bounces-7398-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKhVAvS262kJQgAAu9opvQ
	(envelope-from <linux-can+bounces-7398-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 24 Apr 2026 20:31:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD0462712
	for <lists+linux-can@lfdr.de>; Fri, 24 Apr 2026 20:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D2DC30060B2
	for <lists+linux-can@lfdr.de>; Fri, 24 Apr 2026 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0172DD60E;
	Fri, 24 Apr 2026 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fxu7cgeR";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="yygaXGi8"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496E23D7C2;
	Fri, 24 Apr 2026 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055468; cv=pass; b=LnX5fV6zr0xRS4ZivdjdpP0BKZexDUgIHi2lWak0FhENlaUBe8kiyclGTco3yY50cRWAUeC4pWncT8cK5FzOxHOH6MYewIBWK7TT9AAQvxU7RgfvtjDLFSG6EUdi++7pvmZ1YEppx0TwhsO7vP8fkt4vbFs2zsUnkdFtL7yyQ3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055468; c=relaxed/simple;
	bh=8UFXQ9+IIlyZAxi+DOyhrzD/wbcHW6F9AQF8JuL81mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSxd9f9Cuw+UvXJ/rb8k++JUpoE4iRz2JGdBu5BeamK+y9eVKH8zpx6GaEWy0JqFgHwiAHN7adV376xjqzyHbaQ75JEz+GxIUj6dHe8QamgP+EqThYh8/q7vpppPrYYh+j2+eq0HtQrf0PEII1QOJAPfq5P+m1xTlUViAV5gJDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fxu7cgeR; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=yygaXGi8; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1777055458; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G0h6ESaR8+cAymOtrYKq2SzMQy6sjIjdmmO2HYPPZ6j2rLoVRAXjCNGGMs9tKmoKhe
    MpHo5SiAw51nQNnwpJ+1EgJ+30V22KhfIXIvzC3bxwqFYnHVmyE7Y5ERYgEWiT3fYhlY
    ToD3/j9gJnmDqeDgHmV+NFnOMzz8zeLdUbJfRc14S73x5v+Hz7b3J3MheAXpJ515eJiX
    1j7NJfH0mXTeE6+K69CRfxlWXWg9bHqE1vpnNFEweEBCxPTq4BQDpXVQKvcw+2HbHSVM
    MOnLOBUQvNF1nHdgQjADHs/ZuaWZoe1eEkIyKQpVX06R9YMsQ2DmSV9fwXrZRc8sjHXO
    2XDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777055458;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I2/R/qHEFom66RiLpTQoWQh/pDQ5W4FJAJiRD+vPSZI=;
    b=PlnMtMKB8CYKLHmvKWBRjoKRA328hjzdU5yFLLvRy583yvNhedS0t8I8f1wyavIFvK
    4XfliolwVYZrXWyINUXHoNpuKONngbYqevrrxN57eoBxAeamv5zqfGynnSBG7tlg5w52
    ln0viKsbNxJrWZrnYXAvY4tyIOlU7eCbtBBGYNwtmuqo2/My3Ln/jucG+lXD+nuboHgm
    WF8kVtsTO1inoaXSoQEX0Ctyryz+9hul1tTFfwTxGDSbasMn4Qmx2OByXfcXIlNXYNd9
    vUV42ykfNmT2/YzJjuoiReR/a7QBVlFOY8ZhkBmNPEmW+2yS9P8iyHf8B5wvra+LU6q2
    F9ig==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777055457;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I2/R/qHEFom66RiLpTQoWQh/pDQ5W4FJAJiRD+vPSZI=;
    b=fxu7cgeRGVC5RKm/a2ZvPavn97LSsy3qTaEqACgWK9THa5XEiBdtprZ2OyeO73vcue
    g2dPQDMep84+Ux+Hg+V3qO4y4D4rHTExVKQ2zKcgh/nY3R+fLd+10qBuywvAxm9+rymA
    t44c/d25MDQiTAES9rjVj2KcOBdGExTbBoIHGEogGlIbo56M+il5d+reqRaNA//cbbye
    +mlshTlPcNQGh6xtmnHJoEf9072OF52TEZkVi3t8TbmoKOQwXU991YJantgxidtJsJVr
    7KPEyOK3rNfk1n/vh7scxqtQz9h+0JOn5wK8zSzxx2b0LuuWxlN7cEqAcFPacEPL2TKv
    GXQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777055457;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=I2/R/qHEFom66RiLpTQoWQh/pDQ5W4FJAJiRD+vPSZI=;
    b=yygaXGi8e2H+b1Wnl9cRLqukL4a9w91yrhcePCdEgvElLf5RCmX3HRdQ7hbBnbVfHf
    5hkSD/KIfrRAWG8w+TBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7tgYTqjtr/gWT0HtAFTmQeHuqmWZQ=="
Received: from [IPV6:2a00:6020:4a38:6800:f493:fb24:b10c:c543]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d23OIUvp27
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Apr 2026 20:30:57 +0200 (CEST)
Message-ID: <f7db8780-dec9-49ed-9a6c-b679fa1dc311@hartkopp.net>
Date: Fri, 24 Apr 2026 20:30:51 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] Potential order bug in 'drivers/net/can/vxcan.c',
 primarily in 'vxcan_dellink()'
To: Ginger <ginger.jzllee@gmail.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAGp+u1ZUNzJaiGNBrOoHARe9zZ=UNgpBYmmgTTtgywgq6tf8VA@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAGp+u1ZUNzJaiGNBrOoHARe9zZ=UNgpBYmmgTTtgywgq6tf8VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0CFD0462712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7398-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello Ginger,

On 24.04.26 17:24, Ginger wrote:
> Dear Linux kernel maintainers,
> 
> My research-based static analyzer found a potential order bug within
> the ' drivers/net/can' subsystem, more specifically, in '
> drivers/net/can/vxcan.c'.
> 
> Kernel version: long-term kernel v6.18.9
> 
> Potential issue:
> T0:
> vxcan_dellink
>      --> RCU_INIT_POINTER(priv->peer, NULL);
>      --> unregister_netdevice_queue(dev, head);
> 
> In T0, the priv->peer field is nullified before the device is
> unregistered from the kernel in 'unregister_netdevice_queue()'.
> Considering that many other kernel functions rely on the existence of
> the netdev and dereferences 'priv->peer', e.g., vxcan_open() and
> vxcan_xmit(), it is possible to cause null pointer deref in concurrent
> executions.
> 

The code in

https://elixir.bootlin.com/linux/v7.0.1/source/drivers/net/can/vxcan.c#L282

is copied from

https://elixir.bootlin.com/linux/v7.0.1/source/drivers/net/veth.c#L1931

which contains the following comment:

	/* Note : dellink() is called from default_device_exit_batch(),
	 * before a rcu_synchronize() point. The devices are guaranteed
	 * not being freed before one RCU grace period.
	 */
	RCU_INIT_POINTER(priv->peer, NULL);
	unregister_netdevice_queue(dev, head);

So I'm pretty sure this case is addressed.

Best regards,
Oliver


