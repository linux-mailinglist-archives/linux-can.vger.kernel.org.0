Return-Path: <linux-can+bounces-8420-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BGzzBMs3VmqJ1gAAu9opvQ
	(envelope-from <linux-can+bounces-8420-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 15:21:15 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C00755047
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 15:21:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=eTpvkjxb;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=RHrkez8z;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8420-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8420-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6FFD30234DC
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ADE1EF39E;
	Tue, 14 Jul 2026 13:11:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40828389106
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 13:10:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034661; cv=pass; b=KvDBZiP80EXBj8jQfEclLnHjQMN0HPvww3PSPYBPpcn+TMW7sZTK9o8ATPZ0qTs4vzzCFh4btkFMP/89wYPDKOv+3eLIxXOrQaWkZi9zlEnq+xBYGJgs/ndiCf7WE7s6/S0Zt+yjcBtbd9q6HOaP7YMCrm6OsRj7syO5V3LFsSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034661; c=relaxed/simple;
	bh=znxXo87iY2K7i0i45/hzGRAFQP5Qw+DyoZxvELMx7Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4TL/7Nl2rlauXYdYaawImOcD2rmKPM63sFxwd2EqhzdQixgf4gKOmOmTXuNqrGbuAw65IBMpeycn7xA1V5WMKox1dNWwLHepDe9bA+fbXx0WbgACERNfgrF6EDcFVHvfpvH+oZO0+b7ngZBrUo3wA1HKN1euYCTbshm5ZaqspE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eTpvkjxb; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RHrkez8z; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal: i=1; a=rsa-sha256; t=1784034469; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mvCzuuFFHWuDsV3S9xC5/QKO2CaLh7IpLYVJ7RUBx6uwf6BNZ2wRsezduDQiCklaOT
    Ae2MLitDufTTaEyIeqeSJ0BrptoyjhJ0876WbSOaeQPfIFvcKqVXcMiQ3TZOqxFrQm9Y
    4ateklIU4uDAmThlp5vgICrPcg4ifIHULHoeP7/GXCqF8PlenDXj3klk/aHGV7+4gUnd
    TsFNompTCwuTjlYf8mpz61x4f+Rt0HIDi9TsciZHSdolawleS8xekHy5jXM4IV8ZHm4z
    yLl3pB1MvIOf59JphmCTprhRySaJfJkKoVbCt5FVBkaKVtuSEY6oNM1k+IuWl+pK5Yu3
    rRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784034469;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=guEuGcTlCYA/IKVUqHOhnf18L9VLtdbzdYlIh6ZIP+M=;
    b=tacYFdwe2n9fiueao38evEcvR8BXY+S1FsfpOtizif0wa2hBmxc6IQf2KgBNFldRE/
    9I9E04HxsCcsFk7bOwIuzTLt8XwWxgKz4QD54uxDidhCEcUIBc6O7H5Hbid9kZeM1ToU
    PPCHXS0YVbNgwGPCdimssAkQ0wBOZhX7gC5yAkHjQRIynDRbNFE2hqINab2J6oTfmcou
    PtTAyey8NFWvc1VTiYrB7dsdUgl6kD2C+nvuCWsgcrlVWNm7tbDjsvOmpLvwcCIpKlsa
    atzvIkoRP8JxmaJNYuxkinzzVdc1TEis3C4B4r4l5KrTJXaw0uEqHYyIloVVTu++nU2V
    mnlg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784034469;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=guEuGcTlCYA/IKVUqHOhnf18L9VLtdbzdYlIh6ZIP+M=;
    b=eTpvkjxbWQUUq686Csxj7Ds70+kern3/XAU5yoUfW9McvqF9L1+NRa31MFPDEJ32E7
    xuxgTjwNcfOfHxxm9Uts43fPfd2sAuQXusbPsO5TemlyRV70Yz5X/emIv/BGuNKHauw4
    Q1trR+biGguScB/1IaGghJVHHhq+8p6RVHbkqkLBF2InHKiDxrg1UJs/o094vWbKuGln
    2cZVD5zqo9vUwSIbw1Sqe1FyVkzfVAblsyI2Loq0VI4ymQIF/7o0/O+z0Jo0wMaR3/eB
    Q6Q4K6r7Yz5G5Agj/dxRe9O0aDQ6gYrJQG7Lh14JQ+8dMpu+2FAigAYl2HTHXZBO8w+7
    QI2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784034469;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=guEuGcTlCYA/IKVUqHOhnf18L9VLtdbzdYlIh6ZIP+M=;
    b=RHrkez8z3lCG4UCchphNTc3QgzvpozmJ66nIZwKyavn97n7YqHpYFLx3uxTahTNwje
    RX7BI5d762GtbShqnJBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26ED7nkpe
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 15:07:49 +0200 (CEST)
Message-ID: <ee59dccc-0532-4b00-8783-9763e04c327e@hartkopp.net>
Date: Tue, 14 Jul 2026 15:07:48 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device
 removal
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: sashiko-reviews@lists.linux.dev, Oleksij Rempel
 <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-9-fd667c61099a@hartkopp.net>
 <20260714104431.65C751F000E9@smtp.kernel.org>
 <2c2bc659-fd26-4c48-a5f4-e9e6a3c43003@hartkopp.net>
 <20260714-towering-phenomenal-nyala-ad406f-mkl@pengutronix.de>
 <1a521f25-0aee-4eae-a0da-3eb7f0702e84@hartkopp.net>
 <20260714-vehement-native-jaguar-4f52dd-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714-vehement-native-jaguar-4f52dd-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:sashiko-reviews@lists.linux.dev,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8420-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53C00755047



On 14.07.26 14:36, Marc Kleine-Budde wrote:
> On 14.07.2026 13:47:35, Oliver Hartkopp wrote:
>>>>> Pre-existing issues:
>>>>> - [High] Unprotected concurrent access to op->rx_stamp and op->rx_ifindex in bcm_rx_handler causes data races and torn 64-bit reads on 32-bit architectures.
>>>>
>>>> Fixed in patch 10
>>>
>>> Pre-existing issues are not a shot stopper, _new_ issues for a patch
>>> series are...usually are.
>>>
>>> Hopefully upstream will accept that you fix issues in a later patch that
>>> sashiko claim to be introduced by a patch in the series.
> 
> Sorry, let me clarify: This was a general statement.
> 
> I don't want to imply that _this_ patch introduces a new issue.
> 
> If you remove sashiko from this sentence it was valid before the LLM
> review bots. Rule of thumb: You should not introduce "bad" code and fix
> it later in a series. - As this is a huge amount of fixes that requires
> a lot of code changes, I hope upstream doesn't insist.

When there was a new issue pointed out by sashiko I fixed it inside the 
patch with --amend when it belonged to the topic of the patch.

So I tried to follow the one problem, one patch pattern. And every patch 
makes things better and introduces no new regressions (which sashiko-bot 
would have detected) - while probably not fixing everything at once.

Best regards,
Oliver

> 
>> Is it?
>>
>> Patch 10 Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
>>
>> not anything in patch 9.
> 
> regards,
> Marc
> 


