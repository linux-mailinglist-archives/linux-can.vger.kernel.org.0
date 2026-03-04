Return-Path: <linux-can+bounces-6871-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKMoO8swqGm+pQAAu9opvQ
	(envelope-from <linux-can+bounces-6871-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 14:16:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0389220045C
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 14:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 576213047EA2
	for <lists+linux-can@lfdr.de>; Wed,  4 Mar 2026 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E18229ACDB;
	Wed,  4 Mar 2026 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Ge40rm/q";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6B4rDIGj"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88E27CCE0
	for <linux-can@vger.kernel.org>; Wed,  4 Mar 2026 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629760; cv=pass; b=U8caSvfG/E+5DbuA6FqzNP+l4cPGkwGMaE2i3T3FYyr5FrG58JyH7xhuJagw1XkibNfU72CjGm6wODxZemtZBJJQhSu5eHLQJu/FwBXqssJpyblEiIQ1E15At2e/X0vA57697/k6XQ7r9d/YVoT4+dPTC462RPBntDmbX5yfJ+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629760; c=relaxed/simple;
	bh=HKoQpe0H5FnHaI1GB9ZrqrQWaP/g1BkU5eYUvjAdlIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mcOTvAfvy/wAxic/MyUmE1QHMLiEH/W+m4QkKG1t3eXhamuHnSMHJPguzFCxgaRFnL+hbKtGVV/3cfNWgDTg3KtfQ7K9xepncSpnCU8wUSSf8j0C8eUP/5VnT4NjZC244bQoiXkbn/YMWSMUnMLFWKOYf6gX/uLBcjzrQhvKVlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Ge40rm/q; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6B4rDIGj; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1772628313; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WOzMaSB+XtBElCo5a+IrmgxUESTGCKYoeJKfYN0US/UWFacscdFBhvcM8KhizlI3vD
    eRExtYrsF7BsHVw2KqhrqTmdLfUm1HsfdG0DDU6ZOt8Er8ln/XX4E6KoXC82eE3C/Atj
    nRkQkly2xCakDIy0nFhXj3PCcYbCRR8HA2Kk6MIj2lvt9KtWpILsAXK9su2jH4cCzCqt
    zAdX4SjYkVWZxi3MGZI4CviE4PdjxvXTcTHV9lO0pARipTWGNtrmYz79gwWHF7uZQ1kt
    ym3sbig+3YMcizT8Wow4ULDgUyCPHFzoouqTAebBOuY1Q1kty6EwU8NVG4VJqOvjjXLs
    M6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1772628313;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=oe/fXuzUuwDI+v6hGy5iioS03s6+8ZKQmbC5zW0Hra8=;
    b=SCMChfR0Jbm6YsEn3s29AOBMJfanI6CgGhZO5NtAR6gSnSQLsO+eURZqYePRSYWgtS
    HDKDRhVDzkVG3u6zGY+vLCVBBhv/AZwxfNHqcHsboLS8fyidRL7zln5uxHn9j4ZvimtW
    A8Z95RigvPswEC2wwjDlhcgHXVDZB/Pwe7iDxFeC8xBkurzijws/WzVJmkE77M4YHYvJ
    WNh2FDSAkpK7zBzWf49a9lnMscGXnzPV/JX36LVETaijesH0kpO1FzEPFfJOZvZFHHPp
    FkN6LvPFqKujx3nGdEPR9BB06N5goATBjRalzPmHJ6aFm+trshFWKVYW8s0MsxsXCQa5
    PFMg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1772628313;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=oe/fXuzUuwDI+v6hGy5iioS03s6+8ZKQmbC5zW0Hra8=;
    b=Ge40rm/qs6eXa1INkUtOhdBkN7YiBpXdVsIIMV52U3hOlOcrhBFACEqUrm7A1SNRgu
    qTDv6X6Wj+drsTUk09RkKvHV76VHJlKNaq0WktHcgeaApkFypZhpMK/1dgoFOe84D7eP
    yz1vYdNjA1zVawjgn3P8PpGScZGyQYueZHoWg9Xb1GnxxG1V7YE2XcUD3fR1qbEsqZU6
    XF8fLBOofA/kvHK5/szk1flQvP36sSDyosmiMRea8S8mNRfDsPLDJDIMZYPpCRrWXn5Y
    nf6MLTnymMZNfV9Vi/P84spIkBD/x1quXsgSK1PEBH36F9WWreIxlSNRZzGFOkTFJ0hb
    gR0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1772628313;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=oe/fXuzUuwDI+v6hGy5iioS03s6+8ZKQmbC5zW0Hra8=;
    b=6B4rDIGjtAzfdMSQmxbW+fa2zENFuyJLtpSfve7pDyrSNVak79Q9L5lnfGfxz1bm2t
    a9bbmw0WSrkinrDkNZDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from [IPV6:2a00:6020:4a38:6800:3499:34c0:1f42:76da]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka8610224CjDwLK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Mar 2026 13:45:13 +0100 (CET)
Message-ID: <69c0912b-0d9f-4f5c-af06-119fc9a6c1bd@hartkopp.net>
Date: Wed, 4 Mar 2026 13:45:13 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux-CAN Community Meetup at Embedded World 2026
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20260304-comical-illustrious-chowchow-c972e2-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260304-comical-illustrious-chowchow-c972e2-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0389220045C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6871-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,hartkopp.net:dkim,hartkopp.net:mid]
X-Rspamd-Action: no action



On 04.03.26 12:38, Marc Kleine-Budde wrote:
> Community meetup for Linux-CAN and related topics at Embedded World 2026
> in Nürnberg
> 
> We invite you to join us for a casual gathering to talk about this and
> related Open-Source projects. It's a good opportunity to meet fellow
> developers and users in the Linux-CAN community, exchange ideas, and
> discuss future directions.
> 
> 📅 Date: Wednesday, March 11th
> 🕒 Time: 13:00 @ Pengutronix booth (4-261)
> 
> We'll first meet at the Pengutronix booth and walk to a coffee area
> together.

Great!

Looking forward to see you there!

Best regards,
Oliver


