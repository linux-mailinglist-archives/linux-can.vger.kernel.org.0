Return-Path: <linux-can+bounces-6153-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 373D4D22F81
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 08:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 386D730274ED
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 07:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E883032AADF;
	Thu, 15 Jan 2026 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dcgrECej";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eP3Q0HCQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69427510E;
	Thu, 15 Jan 2026 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463933; cv=pass; b=PntbI5STtxXFQjNqgj8LBfEHxc4KYXdJyq5kciPhh5IV8RdU101Q2pQMrMC2zlRiqS/lHGiPwkt/KpcfoUpQiKjRVorgHfT9rU0+GzQfZ+rffT38BodEkCmGf9B528ldAmloYYpHn22Ec6OM9TxH2CcKMexpjtvMbwHjKDrLHBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463933; c=relaxed/simple;
	bh=MoeNflbbWlYF5eq/9m77OdK19Iz1rNy6ARrfCpHaBEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1E9mNnYcDNUHULYymt3SBw4HjvdhOLTvfMpsAQsK19TUFMbNnedVIpS28sDT7BdaZvuY4qNnLSLGUGaNtghFqWy4YPDpjBxYOVOvU4ajkkYmFdWKOLORyYBS4FjvFOT8MISKvnHYSF2b1nnBi0swXi8A+cy+AyP0i/YFIa4et0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dcgrECej; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eP3Q0HCQ; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768463740; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ToNQwJSXm+XEA0DiGqmZYglRnaptNjHFfr6vQv17U+oSAOGQQvgs5Xzk57MGTt5XNG
    q2JabWQC/AotAsJkr4CPBTldTXtXl/BY5pS90/ijASPoBOeacpyG0c5Y0jUSbwMCtJ4z
    4NUtuwTEhUb/E0WxuQQZITk+SDxyPaNi7Bhguz4vB4GV/20jr4eqUEz7usGTu1/qRUqG
    YYOSChacaC+GJFZLHcJM/ts6qsGx8jMqyMBzwz80mVXDQ8YcMd4rAjmG3o0krN2KfQ/D
    ZarK6A1Vntua9OWHflckTx3xQNZBWpRu1GNqzKMuquhsaFxIJy2JfodZ+xw8zcwclrBI
    PjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768463740;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=v4l7h6QpOQKdnefXElu8ErhAx3gzH37dPBsdYvviN1A=;
    b=FMYhc9QqV/sHquCPEiPLe6wDL2UlGj7Y3TtDJHs8iikwTE9uM0gRAMBcwZkMXVY7cq
    AOGrqUxPwyNUMkxePoDu+0W0oi9u8QB7hwSjCHIsFoVLwgEj2iWMUzr2jQ5Z2XW/nNyj
    tw0wzq3hTuTR1P1rVQliztBppQBdFJrvacYLmaY3cDyOgs0kMFNjQh5DbzLMC5xrwN3x
    2UpmwwbQyP8wJjYoiiyZPXBvYxzJ9GdjEEVhQpMPCbCLHXXRI1CuGEmrAgEfSXyfUJwA
    lvQ7JTS+LBQ4Z6EWvwAZDmUp6vEW0GQgqphIKSoB2FpYLtqhx9vMRxESt46wiMyBZw34
    f0xA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768463740;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=v4l7h6QpOQKdnefXElu8ErhAx3gzH37dPBsdYvviN1A=;
    b=dcgrECejicA3E6FnVH1gDvcFDVVphFMgIM0oXYEpUO7YSfR/uFA0mgNvaCFRG6Y5dF
    tLfluK1jC59XnZUxQQJwn9R0/BLL7a1Z63wzTePoR7l+OH5XSdCR8sm7Xy4nOIUAeh/B
    nstVPRfeuaXqpkUgUu5niJqpovSf0+d2FGLWrRDU80XfQpb5bBf31kZ30AVbMu5qSP40
    dC1YXvsWLjD3NHRo9ZgKHnWulMnakOK41pfwfK9+ZpL8tnyZlq6QC8N1TERmtWQSQ9Dh
    MwJ1WMG0uMOn+4FC8nfHKTmH49BX9xOJBnZX42vmIzT5Y2kfEQh/zPMGvpsofGq9Wwoi
    z+LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768463740;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=v4l7h6QpOQKdnefXElu8ErhAx3gzH37dPBsdYvviN1A=;
    b=eP3Q0HCQSxzb6BEZooRaLAHAEhTA/hysZVXImWPpTszLU7su4/U0UxFFyScF32393Q
    M6L3rsU4tSxrUvGFadBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20F7tdwuq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 Jan 2026 08:55:39 +0100 (CET)
Message-ID: <0636c732-2e71-4633-8005-dfa85e1da445@hartkopp.net>
Date: Thu, 15 Jan 2026 08:55:33 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] can: raw: instantly reject disabled CAN frames
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260114105212.1034554-1-mkl@pengutronix.de>
 <20260114105212.1034554-4-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260114105212.1034554-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

On 14.01.26 11:45, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>

> @@ -944,6 +945,10 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   	if (!dev)
>   		return -ENXIO;
>   
> +	/* no sending on a CAN device in read-only mode */
> +	if (can_cap_enabled(dev, CAN_CAP_RO))
> +		return -EACCES;
> +
>   	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
>   				  msg->msg_flags & MSG_DONTWAIT, &err);
>   	if (!skb)

At midnight the AI review from the netdev patchwork correctly identified 
a problem with the above code:

https://netdev-ai.bots.linux.dev/ai-review.html?id=fb201338-eed0-488f-bb32-5240af254cf4

An excellent tool indeed!

This patch has to be changed to not leak a dev reference.

Can you please change it in your tree and send an updated PR?

Sorry for that extra effort :-/

Best regards,
Oliver


diff --git a/net/can/raw.c b/net/can/raw.c
index d66036da6753..12293363413c 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -944,12 +944,14 @@ static int raw_sendmsg(struct socket *sock, struct 
msghdr *msg, size_t size)
  	dev = dev_get_by_index(sock_net(sk), ifindex);
  	if (!dev)
  		return -ENXIO;

  	/* no sending on a CAN device in read-only mode */
-	if (can_cap_enabled(dev, CAN_CAP_RO))
-		return -EACCES;
+	if (can_cap_enabled(dev, CAN_CAP_RO)) {
+		err = -EACCES;
+		goto put_dev;
+	}

  	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
  				  msg->msg_flags & MSG_DONTWAIT, &err);
  	if (!skb)
  		goto put_dev;


