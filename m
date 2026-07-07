Return-Path: <linux-can+bounces-8079-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1kWsImXzTGrmsQEAu9opvQ
	(envelope-from <linux-can+bounces-8079-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 14:39:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B371B6D9
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 14:39:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=HVkMwqsD;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=GrspAFRn;
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8079-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8079-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90E6C3007B85
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 12:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A770404BFE;
	Tue,  7 Jul 2026 12:38:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5440A95E
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 12:38:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427938; cv=pass; b=dry6S6j5HlVG+zcY91C8iJVCkNuDNGhD09RVhGbfWMpHnQEZjRUBSMXAaTfAJx/L3sqiE6RZyP1FbWmXA6z+oxF+aMMZuO2VSHdLZelTnLEyp5vLUnHAFJnVlmZrf+dpj42pWhCdFMmUG8zfVWhsHBJoyp8AgivYJxEgHifSaDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427938; c=relaxed/simple;
	bh=nGal1MaX6MsGil9m4yfD5ihUFEQa/a3+vLqiU3/7VD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JT5Ra+uFJjwDysIDUK4idn2CwqBDblaHqAC1ihgM3RATPL6WVSmLJ2ma6IaqOmoeRAF0GV14KPo1nDj+gSRuqLNtQBjRvoGM9vZgYAB09HJANOVYG73CQ/hXhft4BHDIfpG5C3bR1ajXaSREHeRPgrGD/DUUln33H0b5YDMAcWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=HVkMwqsD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GrspAFRn; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal: i=1; a=rsa-sha256; t=1783427935; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Gv1Hc2NQ8LU3KAQWNi7UzGIhLuLyluD5sMhwN7jH++9fH7XT17Fg6jX7W4Hqc3RwLb
    xvHVa1kPiZp7yEp78SfByclP1Rz84BGeZb/FP1UhPEHN02EpTwCVSNl8wzvelOJ/ghHw
    1h9hdWgi3ZpOSaLgpjH/t7yQ1ue8ex8YSaTiXI0+7vUgtpt6uy4SR9JjJ+xpxAfK+dGv
    Vg9H2h3R/m20IWkoPrpHRGHIJ19ygWyAhf4tpPZCvr2WXzwVieaMfiPr5CU66iKl/ktY
    2iMqlF8vvJfjC7BHxOdx7Z/dX+6epAUx8G1aB//repufkbF+reQzFf35pzOddamp5ip4
    eG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783427935;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0Y+a+ouzS+0/V/nEsAkkIxwprIupal8/Ckp1ppeviF4=;
    b=JBwTNJDb7sNsQr/IY1xKEgvZE2gLt0Gsud/WaAAm7DzPpJU1AqTs9ri1VmAAJfGAjp
    CmDsQPp8XpVuXCoVU2eP1FnCIUtoqrL7H5O1FfmbnBtksCF9bK+N9W1s+w31aT0uW3TW
    AD9YpnN2fcR2JxdLaKfDqPG9NGxDmc+DCxkqI/w+lr6LVX10Re8JBTsXUy+rimd1zx+z
    x0mDREALvCUHO7I2annYlnIZju1ijsYOFm7i1/e8i26FfmuI7nEYoHNWcLG33iETwuWY
    uFY8rX3hI9vwQLYvvEBgf6/Mcw0g50Ra3Bc7FM9PZnH1UBGM6RM9Em5tdWP0coG6h0kk
    cqkg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783427935;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0Y+a+ouzS+0/V/nEsAkkIxwprIupal8/Ckp1ppeviF4=;
    b=HVkMwqsDCcIxOi0GqPWK5TgeGX4eVqXUPipwH96wQFW2Q7V0cJ05dhqtsjizTtAAp4
    dqDdTc2K0ItcwJAQDV2cac5YfR97tEMqorQdva/PmsQWs/4S1siPsG2Y0Wuug3gGGjlH
    4rbUyrWB6bEQfcaGXscB9D+WcKBTyL0bZUVP9oNKiuBFjFI9cJheiiyWc4F6M4uJPVSL
    pN6EQ1iZAjZFBihCazUMKkvY+IW8UBJHOMTi730DVoZ1bcHsdfuPpwPG9/bZLsmHsdk6
    PlTv+LHySkkuqnoS4hCXGepYP9nDQ8YZXqLSnP8ckhhKquLTcFQZsi3Tj90AILrl82IY
    jMYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783427935;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0Y+a+ouzS+0/V/nEsAkkIxwprIupal8/Ckp1ppeviF4=;
    b=GrspAFRnygBuInuREUBglhdM71CfcvD3swryv+hnPWYEceQqCWuD9vQ+4naJCghbn6
    eo0tkpyGIeM0US/QcNDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.154]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb267CcsTWK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 14:38:54 +0200 (CEST)
Message-ID: <d2de0641-635c-4817-aada-f867d61f41dc@hartkopp.net>
Date: Tue, 7 Jul 2026 14:38:54 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] can: bcm: extend bcm_tx_lock usage for data and
 timer updates
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-6-84600ca6d889@hartkopp.net>
 <20260707-nocturnal-jellyfish-of-destiny-201f7d-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260707-nocturnal-jellyfish-of-destiny-201f7d-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8079-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:devnull+socketcan.hartkopp.net@kernel.org,m:linux-can@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,socketcan.hartkopp.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hartkopp.net:from_mime,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 219B371B6D9



On 07.07.26 14:33, Marc Kleine-Budde wrote:
> On 07.07.2026 12:16:13, Oliver Hartkopp via B4 Relay wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> Stage new CAN frame content for an existing tx op into a kmalloc()'d
>> buffer and validate it there, mirroring the approach already used in
>> bcm_rx_setup(). Only copy the validated data into op->frames while
>> holding op->bcm_tx_lock, so bcm_can_tx() and bcm_tx_timeout_handler()
>> can no longer observe a partially updated or unvalidated frame.
>>
>> Also move the kt_ival1/kt_ival2/ival1/ival2 updates in bcm_tx_setup()
>> under op->bcm_tx_lock, and read kt_ival1/kt_ival2/count under the same
>> lock in bcm_tx_set_expiry() and bcm_tx_timeout_handler(), closing the
>> torn 64-bit ktime_t read on 32-bit platforms.
> 
> Can you update the comment in struct bcm_op::bcm_tx_lock accordingly?

Yes, I will go through all the commit messages and add the changes.

Best regards,
Oliver

> 
> Marc
> 
>> Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 


