Return-Path: <linux-can+bounces-6218-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C97D39527
	for <lists+linux-can@lfdr.de>; Sun, 18 Jan 2026 13:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E05E2302AADE
	for <lists+linux-can@lfdr.de>; Sun, 18 Jan 2026 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6962E32E696;
	Sun, 18 Jan 2026 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BrxklBTZ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ajyxqJXo"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34D32D0FD;
	Sun, 18 Jan 2026 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768740849; cv=pass; b=bS3fQQuJjnXVdLet5+WlcGqxvFdfUWFKi7pC5JfbalJfzwnK6VLawSLbuV7Sd2p3xvFFkw9bNoKE9Mx+VFEepIs8O4VwzuxQNPbXlQihbmCzjmA+wFQcyjmyiTGQw3Nga0TeS6g1VoZabSpKQt5IkBdsJmY/Rrfjd+T2gITO8SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768740849; c=relaxed/simple;
	bh=WSCk2+9J55rg98cNOSH4gCTL/xL2Y9fkhPcPq+4Pw/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYXPezlUxYfm+zVxXtbU/0efBjTk0GXd6MoB5tuYdd7/YizLE0rPyxUj9LKqaqxS2ZY/+fI8T1mJSwbi+uLe+aRBaTSuDdtXXdvS4N7kKFzVzCuQQ40rR04dbMzYlF9qi9zKrErV0oB8bglzTG2aMPQIjolyI/oMCB59UdpQ2Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BrxklBTZ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ajyxqJXo; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768740835; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RgYzCTobg30EbKRdIE5FQB44wEASQPN2Jt031rP5+aAy8bYZ3mzEXMTpyhahNWAff1
    C/28D9wqR50dbI/a9JWQ9rxnV5xn+djntP324rPG7sjokryKmhr5LlwaOuGimyXQp9Of
    cG5az2PVqtTw6TS7aZsMdO5CI/Q1Iy682pQdWElHJEfOw4mk28yfSE32LE8O9r1FVgCa
    l/aN3iG3uDWP/EA80kCOvuQYgGx5Bas7OpGYafrRh5jJ9UZoO01qoK9wMD/Uwyy2m0iF
    /bzr9nR+lVNUg+3T5jwgKs+sw/5+Y7hi68RjlFmiEqGuoFX+iPRqsAnOn+G8atLXinxs
    hUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768740835;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lpOdbUvayTjEL+7w/+S9lDkpcIMTNQxOBEL16QWQ96g=;
    b=lWkZIVQ8JfUID5zQ/c2Wz9pjk3PPweO0PL1QepOFIBYQw1aHQAUO780TrTVPgG8G2R
    2wfxkzooqqDO4iIQ5dQTB/pYIHdXt8tPDHVqGGL1+DHSr0Wmmbok99G4DPCO62jp9Ya7
    lytlGzP7oyUwZS+Cc/hhK+xvCAhGDtmbJoTeYVR2bknPW6G8abjXYWPEskTiTqI+SZa1
    zIjilNIBZm4gtSLh2GgAmrnJCT2gQHxhZt8LgeY112Vnhmz6F6hFRH+KOLc8K5PIrUZB
    IhahqI8hzuCqnlmDBRCOZ9BclBn3gj3cL13ZrLvDRwC0nunU1iVrmcfP5S4moc6CcHxQ
    sLeg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768740835;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lpOdbUvayTjEL+7w/+S9lDkpcIMTNQxOBEL16QWQ96g=;
    b=BrxklBTZuTep3YXu1phxqe520Ft9xbtghdcy8XoPqnFNjtGBpkUvU4IzNzD9E5aENx
    /+h/j153nlbLx9vKlxAD2pHhLiHe7PxZr9CXqkX4aza2+ha13L+td+UwN/z+zMmUPat+
    HmFwCQJkKS9stf/bmtrhBsU/qBUlKGrMvNx7LkpQPvOCwlF1LwUPZ10/zFSvxb4hM7qF
    StG08h/qgHfB7qM/kP6g1PodXyY+JsRD0h8XlacOGDLOIp9KdWAnrWfkII6MDs5+wcHh
    AXGxOPAyrRbUc6rgeTHh1dUM6xgs4+Fw5sYt0iKMFWmglrf+RiQEWDZdrr4q8f0zA6bq
    QosQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768740835;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lpOdbUvayTjEL+7w/+S9lDkpcIMTNQxOBEL16QWQ96g=;
    b=ajyxqJXoh49D1Z2E7lEm3jy+CWs7VdRak90mIL4dku5+ozzZs9QuPF57Aq6tczsyTd
    lMgRQQP48NeWrQ/0giCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20ICrsMrE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 18 Jan 2026 13:53:54 +0100 (CET)
Message-ID: <dfbcab83-095d-4ed1-ae98-baada95d4cad@hartkopp.net>
Date: Sun, 18 Jan 2026 13:53:49 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next 0/5] can: remove private skb headroom infrastructure
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 davem@davemloft.net
References: <20260112150908.5815-1-socketcan@hartkopp.net>
 <a2b9fde3-6c50-4003-bc9b-0d6f359e7ac9@redhat.com>
 <f2d293c1-bc6a-4130-b544-2216ec0b0590@hartkopp.net>
 <20260117091543.7881db1a@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260117091543.7881db1a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17.01.26 18:15, Jakub Kicinski wrote:
> On Fri, 16 Jan 2026 11:31:14 +0100 Oliver Hartkopp wrote:
>> Long story short: Using the common pattern to wrap a union around
>> dual-usable skb space is the most efficient and least risky solution IMHO.
> 
> The concern is that we're making a precedent for, let's call it -
> not-routable-networking technology to redefine fields in skb that
> it doesn't need. From the maintainability perspective that's a big
> risk, IMHO. I fully acknowledge tho that using md dst will be a lot
> more work. Which makes this situation an unpleasant judgment call :(
> 

I checked out more of the "destination cache" code, the dst_metadata and 
its users.

And also this scary union in struct sk_buff:

union {
         struct {
                 unsigned long   _skb_refdst;
                 void            (*destructor)(struct sk_buff *skb);
         };
         struct list_head        tcp_tsorted_anchor;
#ifdef CONFIG_NET_SOCK_MSG
         unsigned long           _sk_redir;
#endif
};

Despite the fact that the required 8 bytes content for the CAN skb has 
nothing to do with destinations or other of these above use cases that 
share the unsigned long pointer magic above, I doubt that the current 
flow of CAN skbs between socket layer, driver layer and forth and back 
would survive this.

My first approach to "just" extend the skb header space for CAN skbs did 
not work out because people obviously have other things in mind with 
skb->head. I'm sure I can count the days until something breaks with the 
CAN specific SKB data when attaching them to the next infrastructure 
build for ethernet/IP use cases for the same reason.

After all these experiences I would tend to add the required 8 bytes 
directly to struct sk_buff covered by "#if IS_ENABLED(CONFIG_CAN)".

Or save those 8 bytes by using the "inner protocol space" and 
additionally setting skb->encapsulation to false. Which is a safe thing 
to protect the CAN specific content against accidentally assaults and 
can be clearly proved to be correct.

Best regards,
Oliver

