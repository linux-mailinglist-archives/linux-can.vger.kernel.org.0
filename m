Return-Path: <linux-can+bounces-7162-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHSrEPoVvGnbrwIAu9opvQ
	(envelope-from <linux-can+bounces-7162-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:27:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD032CDB7C
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 254C230041CD
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B1A384229;
	Thu, 19 Mar 2026 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oTC0ciUp";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UZZ4ekpn"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78632470F;
	Thu, 19 Mar 2026 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934068; cv=pass; b=cUNG3PWG36IYrpXjUq3WPBtb1Nsv8OnLx47jkC9Ews7mz6yLfFmwWt52K/p13jhrJkU7nvR/yCxVWdFX6yE08BWFBiHiVhFxVgbCM75vn1jb5KtwWEfYEiUh0JHxWsiOQ0lZoWi4wCapO6wcXFIFaZV64XyBgr8in1uXmfUqRew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934068; c=relaxed/simple;
	bh=fGgqyow+j2PisCoGJS/o8cxhFgyom10247BQmP9sXdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFNqRd/BklFpZ0EeVnUVZVllZtxRmF5Ajpt0qJfvaV/jF0MW02wyMwqDUhGy8OC4OKMXswUzFxGueKArdvbSGtHiau37Xy2i2a0apd+4NyoK0rZd+ccB0u40ydjljQLumb8fFCaNhH0GwL6tBgCyjBfw7SANsZ5TvVymwJ9iIXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oTC0ciUp; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UZZ4ekpn; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1773934057; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I6J+PhXqlK0t3CdSS3hnRp4nlLiFcCcZ9sEn8SQnerBHTakrdd9bNDjd7ij+P5yjOw
    UrP2tcMWOysCYFCZ6VLIZtcinA9TF8BWv31uAZp0pVIU0avyOimpwg8rWrRsKgKf/yuH
    58zSPl2TcWdX6J0IKHIProYiiJUeSNYd3NzIavjhzYy4SA2JEIXbgazjqp6Bvscg2o1E
    1DOXBIrJOzMwW+5ur9nEd18MHcvi/u9n8aFoJALB+ULNfrpN5myt4755sLaSYwlr+4Tf
    HEydep/Hnqm04+BsR/po041guE1aTV+espSFd7YGsyNfvTtEHax8wD1J0+mnpdPr/gNZ
    wd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773934057;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zo63icyaEo2fVkkofEjMNkniDx55Lk0om29nYrq1gsI=;
    b=aYXEhNtRlae/NYBPlQT9H+EeGrNd7OhpZiQoEypOl2iHID9iIO6OQFWl23bQzBcPAz
    cop0UuryzjcWPfQnm2IC8tl+PqbF6h79sSUr2pSi8BldrA5DyICUPdUaZgVNUAgYXdXe
    9k9t0Uarsa8K6wgqI+MRQWvXeLhcU9nAXBssVs/vPQj73dZg92GhuXTbSueEfgbDkc4r
    ot2JOiSenc8qP2w7Ijw2xUPLClMopGS6nHoYy1GyZf0FE8SdM7I0gICfikqwTe3SIq0F
    QuY5N1Brvgi+FMnuhNca+hXV2bfbNt4TbMWk15bAW/HVyraxUVHmF8Z8ufVrNqmyQ38P
    sOeQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773934057;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zo63icyaEo2fVkkofEjMNkniDx55Lk0om29nYrq1gsI=;
    b=oTC0ciUprKaHYqyz8GFXNLIZm3846imAAQEKguJSW33alRM/R9KqNbo08Z1mF+O6EZ
    NOW2fZW5Xjd4T4i2Egy/oaNMsjjflWMuVbrDKVktQ4cajE5cer7NdVZEy5ozMGoWVdas
    OdUEGggbj9K5V+LIrNSB54dzSlf3UAsUATP4UGla2NHvwaDO1eRAO3WXvYNG3pELRoyN
    /GGjN5FbRmlnv3DIlwND3ITpXSCCXUaZCRjBbadGqc3BLadUjeE0rzVUbAXbTNqOzt5T
    slaL48vvMuGQQEZDTT+izK8Gt6Zxvi3PubNzSaCdN+aY0xhhX56/PaASwNDBj+HKNddl
    5Edg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773934057;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zo63icyaEo2fVkkofEjMNkniDx55Lk0om29nYrq1gsI=;
    b=UZZ4ekpnD33yabAY/arGtzDYQMgSyFKpLePV9j4t6DOZ8m0SVHy/YwMSY5J0bkXw3j
    RtY7h9/+U2sdh4DIBYBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4NqH8="
Received: from [192.168.90.131]
    by smtp.strato.de (RZmta 55.0.1 SBL|AUTH)
    with ESMTPSA id Kba96d22JFRasaf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Mar 2026 16:27:36 +0100 (CET)
Message-ID: <77a79f13-8ef0-4768-9d73-993e7fd46bbb@hartkopp.net>
Date: Thu, 19 Mar 2026 16:27:35 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
To: Ali Norouzi <ali.norouzi@keysight.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
 <20260319-dashing-scarlet-angelfish-dfaa67-mkl@pengutronix.de>
 <DM6PR17MB2874C391FCF90B09562B4F52934FA@DM6PR17MB2874.namprd17.prod.outlook.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <DM6PR17MB2874C391FCF90B09562B4F52934FA@DM6PR17MB2874.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7162-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[keysight.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:url,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid]
X-Rspamd-Queue-Id: CAD032CDB7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 19.03.26 16:10, Ali Norouzi wrote:
> Hi Marc,
> 
> Sure

Btw. I'm fine with it too.

Thanks,
Ali

> 
> Best,
> Ali
> 
> 
> ________________________________________
> From: Marc Kleine-Budde
> Sent: Thursday, March 19, 2026 15:58
> To: Oliver Hartkopp
> Cc: linux-can@vger.kernel.org; stable@vger.kernel.org; Ali Norouzi
> Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in isotp_sendmsg()
> 
> 
> On 18.03.2026 17:51:20, Oliver Hartkopp wrote:
> 
>> isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize access
> 
>> to so->tx.buf. isotp_release() waits for ISOTP_IDLE via
> 
>> wait_event_interruptible() and then calls kfree(so->tx.buf).
> 
>>
> 
>> If a signal interrupts the wait_event_interruptible() inside close()
> 
>> while tx.state is ISOTP_SENDING, the loop exits early and release
> 
>> proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)
> 
>> while sendmsg may still be reading so->tx.buf for the final CAN frame
> 
>> in isotp_fill_dataframe().
> 
>>
> 
>> The so->tx.buf can be allocated once when the standard tx.buf length needs
> 
>> to be extended. Move the kfree() of this potentially extended tx.buf to
> 
>> sk_destruct time when either isotp_sendmsg() and isotp_release() are done.
> 
>>
> 
>> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
> 
>> Cc: stable@vger.kernel.org
> 
>> Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
> 
>> Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>
> 
> 
> 
> I'm missing Ali Norouzi's S-o-b. It was in the Mail that Linus Torvalds
> 
> forwarded us:
> 
> 
> 
> mid:CAHk-=wheQ2o0B_-EV5H3w=ZZS2huESOxrvTaub_EbrbAMbgi4A@mail.gmail.com
> 
> 
> 
> Ali can I add you S-o-b here?
> 
> 
> 
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> 
> 
> regards,
> 
> Marc
> 
> 
> 
> --
> 
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> 
> Embedded Linux                   | https://www.pengutronix.de |
> 
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> 
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
> 


