Return-Path: <linux-can+bounces-7400-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Wyt9Ch5k7GlVYQAAu9opvQ
	(envelope-from <linux-can+bounces-7400-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 25 Apr 2026 08:50:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABC7465357
	for <lists+linux-can@lfdr.de>; Sat, 25 Apr 2026 08:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F218B30078CD
	for <lists+linux-can@lfdr.de>; Sat, 25 Apr 2026 06:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65D2D3A60;
	Sat, 25 Apr 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pFr8xaSx";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="xMZXaHN7"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9071B6D08;
	Sat, 25 Apr 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777099802; cv=pass; b=nm2BJRiQyBzZedrnDwVQd22bZaYCTMtNbBE0JAVsQZK5J5l4eTjclxyBJFMui+O04+O9cV20moOuY1dZKz8Le4C0EUBfREOkfysir4lxYP6uPdFCYmOlUfue4jJNw3p/BdYPPRlcBhkxggvuSaPNiKyZ67akldgMO55Y7wZw+EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777099802; c=relaxed/simple;
	bh=I9FkQ/1XYc1++Rrra8ArhPG5MGmANqp0RbavEVviz68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1VTB7HyLCD8Nzf6xFxRDIeyLzVwx+G8od1TAPPCuE4rSZbqsVsP1W5CFE/49rX9kSWMH+zrLGZ2YZXcuA9jAbQdVb0PrThFRZDNX0z/7yel6jMg7WyUvWOkbU2QmN0xGyvXlqGcA/H+QyEjYRTyf9PLRsydGGyWx+kcBxONah0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pFr8xaSx; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=xMZXaHN7; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1777099791; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rn+vOcJAhTotGYLWqyHg7EcIoyPRdOWYTa/4lCaPe759FFQttBAvQjkLfI5nIKqdQx
    i3FX9P3UCi1DkgR963alDlSnS2aOZIwAMoiWqOftuxFnwh81VH2pz0Sl1BGgBTQlYpZB
    HuNrVDCvLGd8OkAbJE88S9XrbTE33Mzx//tNvRfA2ye86UTDjDu8KtBhJJ6CLIdVklQb
    o1LqYGk8mrafoffESSAjfm5l3cUqQBrCYUxBla/FKdzrOcnyazZrw4KbIC7FsxEVrguf
    hlEN0xHSel6Des+kgCfIJvSUcPlhhLWY5YYUV2TYrXOGYQuUVwN/HOtC4vDLoarhNQRB
    +sFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777099791;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3XzRiqA9diEa0n51hCFI9y9PXlA3XEqJxtPae+VZc6g=;
    b=JbtmQkDjLf0anA+x49weY1a1IhWt0pY07aoVW4Qcm5RHnfMGVsrkHIzcUiVu35u6/W
    WaNHXOxJMDuIqZnmcumkOu2hABdPtuwkETcEI1jgLwfJGWhAJf8W1FpQ8cjNUBOwkXIr
    8MWtKTKEBbCyyQ6cOn2jTdzMm047k2FMzzpX8G617Z6HsLWN2oe2uMC6wN6AIJC3pfMJ
    XY8bkTwyiCvgxzvUpMJKmC2N0vba+TEU+fNi6bizUqcFjI+zJ0xTmzSMGoUBc7QbcTph
    zvYN7BXi8+gjgs50g1ImV0ct8gTqE9a3DPdzAtWudGRPG1PBvuKdXACTf+cBh2rR7IS/
    2ASQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777099791;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3XzRiqA9diEa0n51hCFI9y9PXlA3XEqJxtPae+VZc6g=;
    b=pFr8xaSxX4Z7JjOi0gTWbr1JzWzOp90d12LebgdyXKtsfbm+67ebm2lTFbrOhzUDvo
    jkttJ4ETCZRk6pNWlTsbeduvyPMaLX+65tJeq/ZY/h9dryo1k2fSRuwR9EeYLwlxdlX5
    CBYco5jas2GqhAH400Ln7DQRmEvxynQyF3q6efWFv3FL8GcFma9lITuQwCl7GxgbEW7Y
    /kx2tRf4IGJWExs+qmRh2JEaS1Dr7w4wVRePxxOwoSts0iMi2LRcltETBUiHuc5UJXeq
    7CLU/WoUZQXuChTrXbD8iAXzKkjuRe7R4zI4QOTS6G5Bz8bmZddVdoN9hn9BIexkEdAd
    eEVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777099791;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3XzRiqA9diEa0n51hCFI9y9PXlA3XEqJxtPae+VZc6g=;
    b=xMZXaHN7fjCuItnvUA7RZt56uYzeZmGJa1+Wi8bjg7DmoiUCmURMbN/YkLPnh416pf
    Bs2WEmUKUmE6AnxMd3AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7tgYTqjtr/gWT0HtAFTmQeHuqmWZQ=="
Received: from [IPV6:2a00:6020:4a38:6800:f493:fb24:b10c:c543]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d23P6nppgK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 25 Apr 2026 08:49:51 +0200 (CEST)
Message-ID: <eef6917f-38c2-4bb4-a5d6-98f5a71adf65@hartkopp.net>
Date: Sat, 25 Apr 2026 08:49:46 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Lee Jones <lee@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260422102239.948594-1-lee@kernel.org>
 <6cc6eec9-2e8a-4a39-955a-0eeefc93fe97@hartkopp.net>
 <20260424-magic-snobbish-rabbit-0865cf-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260424-magic-snobbish-rabbit-0865cf-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6ABC7465357
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7400-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid]



On 24.04.26 21:08, Marc Kleine-Budde wrote:
> On 22.04.2026 14:55:50, Oliver Hartkopp wrote:
>>
>>
>> On 22.04.26 12:22, Lee Jones wrote:
>>> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
>>> synchronize_rcu()") removed the synchronize_rcu() call from
>>> bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
>>> timers from being rearmed during deletion.  However, it only applied
>>> this check to op->timer via bcm_rx_starttimer().
>>>
>>> It missed the fact that op->thrtimer can also be rearmed by an
>>> in-flight bcm_rx_handler() (which runs as an RCU reader) via
>>> bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
>>> bcm_remove_op() has already cancelled it, leading to a use-after-free
>>> when the timer fires on the deferred-freed struct bcm_op.
>>>
>>> Address the omission by checking the RX_NO_AUTOTIMER flag
>>> in bcm_rx_update_and_send() before starting op->thrtimer, effectively
>>> preventing it from being rearmed concurrently with teardown.
>>>
>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>
>> Many thanks for the investigation and the fix!
>>
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Can we add a Fixes: tag?

Yes, we should.

Thanks!

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Best regards,
Oliver



