Return-Path: <linux-can+bounces-8422-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sXeoBidLVmrs2wAAu9opvQ
	(envelope-from <linux-can+bounces-8422-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 16:43:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA71755FFF
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 16:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=EnoKAamN;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=iQYAPV9W;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8422-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8422-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 061AA303799E
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C60480DE5;
	Tue, 14 Jul 2026 14:41:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A8E480DD3
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 14:41:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040082; cv=pass; b=Wnu2/wbjTB8H55kAsKb9HHc3KFzAy8sbLUXltYtatf5iSVZiqiVBKCWThUWYAvQPvI7XzEfr0ype2GWJWuesCwalWeiGBwgZCuszR24t1aWCRgHPAPtvawPB3GbPKcoN1c8saEod0c1FILPh3O8wtX8uC8896ohEdgMT9MA/WWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040082; c=relaxed/simple;
	bh=/mqaC19Y/yMk5bYUbcHelPJJeBNbYVsBCKjfoXb9XcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auypIJdg0L+6l3hfNt16+dj10cO872grt09GuRO5yBGAMOjz3aB+av9SSALSnSjmflAv9+5/5ndWLOGMScLy065rocqJfboe6xH9eAarD4/9OsTNjSY/MgLRKUWDinRLzLzRXTcVkxUlCHvSbPfE3cUopcfWLzOK6HS4f037IU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=EnoKAamN; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iQYAPV9W; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal: i=1; a=rsa-sha256; t=1784040055; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rC/I1nPonJJYh5h+0Ape4YppV++25VAivFWOZL2GzE1d1supDkesnWZtqwPl35jQ0F
    M0TaOkj0QLWdvN6txkX/8LPl3Qujtm3enP8yu93TcCr6jhKWKwZ/QL+0LSgiNEGEwTTr
    FI9WB8K69oW4HtUnzC6np1LJjEgvHcwVUjL6bLiIQYXKNVNU+8/eWIcIGBGVdOI5zmuK
    bO1zHoIpnfTJ3QrmzAR0Pa3kFCYUGzZm1RnEZB+NfUyu6psqSAwNA007+CkkGzzzlBlS
    +EphvIGLslQyJhtkNYWW2af+BeFwkIp7qDXMuLmgIbJXgZxrxsax4sUvSEWgiRqRyNh+
    KgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784040055;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KRax0Y0vd0zXdk9mMyXYZhbAztuKHFumKVBMHJCzQzk=;
    b=eVn07jIGd1E3IgmIQI1iH4ylWSKAZhSGWYLKsWTCyhq5wFrIaQz+Kvv9OWYFTpfrSZ
    kwUIMDrfIxynRppnTJKu3FPh02HsD1VlKKbgtn50RXj34Tj1PciNj34kTOJyLRZQuUSh
    Xt16jM0lwERUiUIU0CEKDt/T+Lmze6U5Pslmuc/JufW4w/elvqnXIMHqdYbGV7JBihO4
    xnmPXWpdTOPe4esDakb/G1dlQ6f8ldt2VuPJqG7zIscQ9fQoPnKcctMvqydXkyFWpYf9
    pIcgY2E/jdUMlM6UecdMwENz6E/mXjPeRGlG0MfY2Sk1NVLao8g1NQPol1AIH2K2lme6
    pdpQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784040055;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KRax0Y0vd0zXdk9mMyXYZhbAztuKHFumKVBMHJCzQzk=;
    b=EnoKAamN7cmTAZv0TVM1H0waeEyHdb38f9vozP/RKkxgbPX1SzIT1K0ij05pSHfcP9
    2TiEwVtBCq2DzW1lJAjlpHHVvo7edvYA7vs8x9lBjEAnNc6vQqVvm7cr4e3b9KhFeH0B
    zW6YKmGolecxr4FAV1drHCy8gSuJfnfKjO+q2TGixPYWptim//btyaOhw74AIYrTqXyP
    V1PZ7yQs/yFWzjBidaDak4jo0sTh3ZKz84ShLiW9p0jbV1MI8P+DWCWffI0/XL1zPGyc
    0al7AM7JjqQEgm6oI7mmSPaJBObEkA9dJUSmtvqgmRHOTxgdSRWGsXTm/iHCY6zBh/Wp
    1ibg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784040055;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KRax0Y0vd0zXdk9mMyXYZhbAztuKHFumKVBMHJCzQzk=;
    b=iQYAPV9WazCHmWwgemFsezDdKKjUfMYaXge8ql+6LXyVuIMuuYa61WS7P9xORO0fgb
    0pmOScli5mbPDQwE+eAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EEetlSQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 16:40:55 +0200 (CEST)
Message-ID: <b6309f4c-3c8e-4f34-a01d-1a08c5998f7a@hartkopp.net>
Date: Tue, 14 Jul 2026 16:40:55 +0200
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
 <ee59dccc-0532-4b00-8783-9763e04c327e@hartkopp.net>
 <20260714-tidy-quizzical-collie-4aaee0-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714-tidy-quizzical-collie-4aaee0-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-8422-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FA71755FFF



On 14.07.26 15:41, Marc Kleine-Budde wrote:
> On 14.07.2026 15:07:48, Oliver Hartkopp wrote:
>> When there was a new issue pointed out by sashiko I fixed it inside the
>> patch with --amend when it belonged to the topic of the patch.
> 
> You've probably already working on this one:
> https://lore.kernel.org/all/20260714115254.D9C2B1F000E9@smtp.kernel.org/
> 
>> So I tried to follow the one problem, one patch pattern. And every patch
>> makes things better and introduces no new regressions (which sashiko-bot
>> would have detected) - while probably not fixing everything at once.
> 
> Perfect!
> 
> regards,
> Marc
> 

In fact that was still a problem. working on it for patch 3. Easy thing.

Thanks,
Oliver


