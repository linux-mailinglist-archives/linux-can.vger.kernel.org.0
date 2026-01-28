Return-Path: <linux-can+bounces-6322-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCOXLkLKeWkezgEAu9opvQ
	(envelope-from <linux-can+bounces-6322-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 09:35:14 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EAD9E43F
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 09:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 296BB300C82B
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 08:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39A327218;
	Wed, 28 Jan 2026 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="S4dWOUJW"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8542E229F;
	Wed, 28 Jan 2026 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589310; cv=none; b=J5GdZ9hSdsoyWICfCsTB2opqg6mEIr/syF3+JTwi8AqwOFA6nj4oDapJp7xPuVZXwkhMCVu/JZLczab3ArRzqT7N7PyilK5tFyOtjfFCFLhc9dGrGUOWts/rlbAYYeMD0ukSvNALPntVweMjgL6suUr0HHQNEA7JysGNakpyfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589310; c=relaxed/simple;
	bh=u7n4BK5mb9uf7qoFzv+BHOmfoPb4EHRhhut00h7FOSg=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=feL1JEKkEe3czaEyUGa+YHCdr11RDWPaZ3AfXp7lj3F3EikBsCvOwXAkmVpzibf5LyFkfDDLeQgEjK8bJhm43UtBq29M+hY3vTEyE5K8lmmQ2RgADK9t4K/p3pCOe3h1Vogo0pBsslOF6f799S3fMVJvX4PBgcycH9zdPQijc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=S4dWOUJW reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1FvY5HMYz1DHbd;
	Wed, 28 Jan 2026 09:35:05 +0100 (CET)
Received: from [192.168.0.5] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f1FvY1CB3z1DDXS;
	Wed, 28 Jan 2026 09:35:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769589305;
	bh=t4Gj4mMZQzBSEUkRqGV7U26TwgSW1EG6pmEqN7Gvj90=;
	h=Date:Subject:References:From:To:Cc:In-Reply-To;
	b=S4dWOUJW+HnjYLW2x2BxP387LEloRsHuJCfVlFsjpj/zAnQJKqx34m1/TImoQZCIv
	 h6F1PnzJ+eulgJTLc062VEB8NtKQqzfu4J4Fuyd8gGtbt99xZGx2oUlZ82Lbat+ZXl
	 38jTT7fBz+oYDBT5y+t1AYeNzaVekT4laFZjxSo6MejSOPchAqOIUCUgagMyLM8WKE
	 b8h1xq9g8cu/uWMReBq2w5XEVTsrv4T5Jd+GVxWiPO3oask8umDVLMnzNuWLmd6MWv
	 iu9abioC8O9pJVHHBeA18jFELspm9VjAZpWWHxz1Pys4ATDPi2mXCseKKWFKSfzyai
	 /asFx7Ov+vBHQ==
Message-ID: <b32d932f-fbcd-4e43-b4ae-cdf634c8b35d@gaisler.com>
Date: Wed, 28 Jan 2026 09:35:04 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] can: grcan: Add saving and restoring of CAN FD
 baud-rate registers
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-11-arun.muthusamy@gaisler.com>
 <20260123-original-manipulative-bulldog-07cf38-mkl@pengutronix.de>
Content-Language: en-US
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mailhol@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 Daniel Hellstrom <daniel@gaisler.com>
In-Reply-To: <20260123-original-manipulative-bulldog-07cf38-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6322-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gaisler.com:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:email,gaisler.com:url,gaisler.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34EAD9E43F
X-Rspamd-Action: no action


On 1/23/26 15:00, Marc Kleine-Budde wrote:
> On 22.01.2026 13:10:33, Arun Muthusamy wrote:
>> From: Daniel Hellstrom <daniel@gaisler.com>
>>
>> While reset the GRCAN baud-rates are preserved, since GRCANFD has the
>> baud-rate in different registers we need to add saving of those
>> registers too.
>>
>> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
>> ---
>>   drivers/net/can/grcan.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
>> index a2a5a5c868ff..0ee6e9bfbe7f 100644
>> --- a/drivers/net/can/grcan.c
>> +++ b/drivers/net/can/grcan.c
>> @@ -517,15 +517,27 @@ static void grcan_reset(struct net_device *dev)
>>   	struct grcan_priv *priv = netdev_priv(dev);
>>   	struct grcan_registers __iomem *regs = priv->regs;
>>   	u32 config = grcan_read_reg(&regs->conf);
>> +	u32 nbtr, fdbtr;
>> +
>> +	if (priv->hwcap->fd) {
>> +		nbtr = grcan_read_reg(&regs->nbtr);
> Why do you save nbtr....

You’re right. nbtr is reprogrammed by set_bittiming() after reset, so saving/restoring nbtr is redundant.

>> +		fdbtr = grcan_read_reg(&regs->fdbtr);
>     Who writes fdbtr in the first place?

These configuration values are embedded into the CAN controller IP at SoC design time(cfg record).
 From the driver's standpoint, saving/restoring fdbtr also redundant.

-- 
BR,

Arun Muthusamy
Software Engineer
Frontgrade Gaisler
T : +46 (0) 700 558 528
arun.muthusamy@gaisler.com

Frontgrade Gaisler AB, Kungsgatan 12, SE-411 19 GÖTEBORG, Sweden.
+46 (0) 31 775 8650, www.gaisler.com


