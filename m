Return-Path: <linux-can+bounces-8398-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F627BeEcVmpCzQAAu9opvQ
	(envelope-from <linux-can+bounces-8398-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:26:25 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61340753E12
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:26:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b="kncN/l0S";
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=UP1mg65E;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8398-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8398-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F52C301BF57
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E07363C60;
	Tue, 14 Jul 2026 11:24:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF237E2F3
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:24:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028271; cv=pass; b=mxQrW1sHkP5pfOxXUeaVHd+vM/T6b7yxK5ebtGsTXyPsoCNdAnA/ZKrHItzZ0o7RMbDT8DaXQrJl16ZaMKwqlEasOdM4QWoqEV4tHA+4Dpq7dn1zeyBqCSCa8hYRJMTCpHrmFK22Mek9sMbTt6vuWyzUrZ9YtGZfyPGRve39pPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028271; c=relaxed/simple;
	bh=qy01gl33+o7QGsogD1M59ES6AVntKgfFAJawEwR+XpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4oGaEAwDdAXm+sH6hW3CLHIHy4koz1SssOPT5hag4UNzn+nmZ6GSDOVQxG05wmVHkMSosSZJeH6mdt9wdiJpoQDvp+mEUKxEQXLxE7zYkoG5kpOBcKtSwqyfoav8p5p3OBv2tScNO4bU6uMIOoCE7i0iq/bVImKGenLuHkq9SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kncN/l0S; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UP1mg65E; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal: i=1; a=rsa-sha256; t=1784028257; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=F7l/wehERLPl+X3K3EoT8B9E98S0ljlX7QasDE+ZHBmCizxv2ruevNizt2IWgNB7K1
    JKO5QpMelZXpj9rQPde8eZrY/FMJxfPCypqb7UEazBmZbV7ilqPoIZdNb8SwJ6w68MPl
    NFfqukwx900NZAJZa4tRXM6ZUCvKTk+M6/9q/tD7QB27nToaK0rXSqQ9+YvKTS1FN1FB
    gfGCVKs38WT4zPGjj+fA6Bag5hQ36d7hdYm9htN9K5601qdI8eWhRr71narKxrlihBRe
    DrXQXcaYKtfBWPYyD7qxhLAzUWujKwpwbzUPe9mjHCp7eTbF/Qx6wW+DCMF+Dn9hm6TJ
    pBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784028257;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=he0ai37gbv22+tD9V+UTfe4N1VSqk66b4OVe0q8qgic=;
    b=XF6WglbMd1QyZhViYvcf/X44jW/+1yxY765+XA7sTULjvQZiuP6oJg302RnOu33H1F
    S03cm+ul8EQuc0UaHzdNI4GJAydZ3chaI60lwMjnmaLOLHCW5QamxwscfpzgJ8Tjq/nj
    HVGkx7dEONsa9c6ApNFb1q7Y1VRBBhQdA6E/SOX1Jh4Rnet6/NokFGAkhD+wFXL51A0w
    P+nA1AmvkzQRkoYiQGRVtbkqYn71XVAzfJ0aSnJRXAnxtPPHtjsTpzdo3KFbJ+V1NdEq
    U2Bx86ys+hcvKjJGAL5xrMaA5J96F+5DLMzS49cgt1Yoz2Xp2QJ0X7sfqHdFaZiV6Nhv
    O35w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784028257;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=he0ai37gbv22+tD9V+UTfe4N1VSqk66b4OVe0q8qgic=;
    b=kncN/l0SBuPxRWzyT8nY/q7pIkpj4QtywkZN4hzwqMZ3MddrFvvYiCwSdFf6YYfZnF
    3fm5JWDqcLcab88XNM1kVUxGgEacRztd27ar+GWQgrgKxHu8Cv50uspUqXcw20mF9SdK
    iwBrJ6z7o7jGpNuwglzoTMHzUBH5785kmCg0OI/bf7MQNY/f62HrghLcYwGj91A1AB2C
    g0wHy+/1FXbCtYZJ3k2fRY9QMw/BQPH/mKWpmk8aO1zyGackBpV8G5vQyKvjprQZLQ+H
    6hW7HciL+b+E/Eo/YouPjOukML0wjvGciL0IKpeZi0WCmf31E6PtIlfhN6KKRfsLUI0p
    WEGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784028257;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=he0ai37gbv22+tD9V+UTfe4N1VSqk66b4OVe0q8qgic=;
    b=UP1mg65E8+ikazFysZrGPzPjvPVo51LbCHC2FkYCsFYNB2iiUl8uYyF8xRTENSd7UX
    ay5KonIIkDoPfxv16MBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EBOHjgB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 13:24:17 +0200 (CEST)
Message-ID: <2c2bc659-fd26-4c48-a5f4-e9e6a3c43003@hartkopp.net>
Date: Tue, 14 Jul 2026 13:24:17 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device
 removal
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-9-fd667c61099a@hartkopp.net>
 <20260714104431.65C751F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714104431.65C751F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8398-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61340753E12



On 14.07.26 12:44, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unprotected concurrent access to op->rx_stamp and op->rx_ifindex in bcm_rx_handler causes data races and torn 64-bit reads on 32-bit architectures.

Fixed in patch 10

> --
> 
> --- Patch [9]: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device removal ---
> commit 7ac0666664aa8f0bbda8367494a6678c948d2082
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: fix stale rx/tx ops after device removal
> 
> This commit fixes issues where an RX_SETUP update could silently skip
> registering if a concurrent NETDEV_UNREGISTER occurred. It also ensures
> that cyclic transmissions are stopped when a device is removed.
> 
> Link: https://lore.kernel.org/linux-can/20260708094536.DDF821F00A3A@smtp.kernel.org/
> Link: https://lore.kernel.org/linux-can/20260708154039.347ED1F000E9@smtp.kernel.org/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 5660165cdf0eb..10dd99ecce70e 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> [ ... ]
>> @@ -1483,18 +1495,32 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>>   				err = -ENODEV;
>>   			}
>>   
>> -		} else
>> +		} else {
>>   			err = can_rx_register(sock_net(sk), NULL, op->can_id,
>>   					      REGMASK(op->can_id),
>>   					      bcm_rx_handler, op, "bcm", sk);
>> +		}
> 
> [Severity: High]
> This is a pre-existing issue, but is there a data race when bcm_rx_handler()
> accesses op->rx_stamp and op->rx_ifindex?
> 
> When a BCM socket is bound to ifindex 0 (all CAN devices), multiple CAN
> frames arriving simultaneously on different CAN interfaces trigger
> bcm_rx_handler() concurrently. The handler unconditionally writes to
> op->rx_stamp and op->rx_ifindex outside of op->bcm_rx_update_lock:
> 
> net/can/bcm.c:bcm_rx_handler() {
>      ...
> 	/* save rx timestamp */
> 	op->rx_stamp = skb->tstamp;
> 	/* save originator for recvfrom() */
> 	op->rx_ifindex = skb->dev->ifindex;
>      ...
> }
> 
> These fields are then read in bcm_send_to_user(), sometimes locklessly (e.g.
> when called from bcm_rx_timeout_handler()):
> 
> net/can/bcm.c:bcm_send_to_user() {
>      ...
> 		/* restore rx timestamp */
> 		skb->tstamp = op->rx_stamp;
>      ...
> 	addr->can_ifindex = op->rx_ifindex;
>      ...
> }
> 
> Does this cause torn 64-bit reads of op->rx_stamp on 32-bit architectures,
> and can the interface index be logically swapped with that of a concurrent
> frame?
> 
> [ ... ]
> 


