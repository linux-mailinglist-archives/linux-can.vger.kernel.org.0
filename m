Return-Path: <linux-can+bounces-7836-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XZbiGHchLWqKcAQAu9opvQ
	(envelope-from <linux-can+bounces-7836-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 13 Jun 2026 11:23:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B4567E377
	for <lists+linux-can@lfdr.de>; Sat, 13 Jun 2026 11:23:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ZUdzcura;
	dkim=pass header.d=redhat.com header.s=google header.b=n7ACzOLv;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7836-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7836-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE9FC308B7A3
	for <lists+linux-can@lfdr.de>; Sat, 13 Jun 2026 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4E93B42D6;
	Sat, 13 Jun 2026 09:22:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86339D6D6
	for <linux-can@vger.kernel.org>; Sat, 13 Jun 2026 09:22:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781342555; cv=none; b=g/0hxUJal248v+wVdqvtFgNcscOLdfdk0niN6lG6gmLwf0FtlInLWzm97KvA0evErtIAWWSkNsAySeW5445kG4FY1UtTNoHVWEIEBrteuH+/VCg1QrNTHd5qm+Nx7GHBbfhHODrh/shiG11T2BISIjqOvH5UXXZzDpHWLteWOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781342555; c=relaxed/simple;
	bh=helDrwuxiWtrf/iPIy4Y9R/hkLMVrwdS0rRl6C7Dn4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6DES1QSFtSEwCK9prv6wpnJ0JHGsa2LTlo1n8e9+CbQ+xwnN+PGhWM3Jqh46cnXAjssXOcpp5GJpWwBYR9bjZ83/qFFI6udj4dAsfJSVdTXTmSyqzWvc5o6y3wliGHzqcYfDwzZr4MES8PAb/rH7Ytgx1CKnHp3Y5VggKxYpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUdzcura; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n7ACzOLv; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781342553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkSlrlMGjyQ/p88XPP6jRxfxndrJ9//6XRAvhwfy0VE=;
	b=ZUdzcuraVxN0tR4QJtHjX3fl/wRfhoqGYfDmhNfhjFRx2gXExTPMNgBprtslbgAJzh+/c4
	TOLfjmt5WBXgzFcjW54M/l23ro2DGJ5ZFlDZPKdKCesMClOCg3vFJSX+E/6jpnKEAF5gA/
	/VXzmmq3ib9yNhFnjChapll3X2dr9xQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-j2mNCw3KMNCHrkI0CPDSyg-1; Sat, 13 Jun 2026 05:22:30 -0400
X-MC-Unique: j2mNCw3KMNCHrkI0CPDSyg-1
X-Mimecast-MFC-AGG-ID: j2mNCw3KMNCHrkI0CPDSyg_1781342549
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-915757be497so259279785a.2
        for <linux-can@vger.kernel.org>; Sat, 13 Jun 2026 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781342549; x=1781947349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkSlrlMGjyQ/p88XPP6jRxfxndrJ9//6XRAvhwfy0VE=;
        b=n7ACzOLv+WOrWvtffgBSHFCd1sqwAVcuLe0N4EwnK1hGqBRwEJdin2TthCBO/6a8mw
         Ht1esjvYudGXsl57gJWIQ8Hee9yAgEPB4Ij3+0wMZSrabFC3cWTlsDbmnlIipEnFXF9G
         FykR9mRnpzk2VNZf/fpDibTE10PTSfeF4A1DDIfeNJQZWpH5k/6sgq/XgkLVHJNOFOEv
         7ZLrzbYESpAmIEa+SkDTnPRpMLa41XZjPOyrpPNYEnO/HLnhNtjF0vzk9qvkUF/NSzZD
         ozyJz90OYTYAwjbO9dvhDpfJ/cuMy7EEEdTxY/cYMC9y2aOmf+tNYmjr2HI0ys22ctnP
         06CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781342549; x=1781947349;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkSlrlMGjyQ/p88XPP6jRxfxndrJ9//6XRAvhwfy0VE=;
        b=cT5+EAQb8qh+5dFpJL59T2ftRaLcvo/5zZAEN994MeMUZyp9uuA7D60dEaE3RH0wbd
         gHcNzd/iC1RpYPaLSdPZQIFGEEc4z07crtpPjiQa9Uhml1kYAv43jhapg+U03Aa5sDsz
         OdbxjqbbHs0oXh6ZnVgVRGiRDMegUwBoc24SyYpKe9Pbz8y7scaSo0CwkWaQiHcorHvz
         UjYoP8fR92vjklDlS9+83rNVDybRVwrHq7xZxeET8hkmAKAb4G8QsnLCBc4Glk5Dy0cc
         NTXhKwYmTo9y2rKCtBqAkWOHw8uMAd3FrHlUqlxFru1hZ+ssLHyN4Lo/ZZkWAnXvAwdE
         OYiw==
X-Forwarded-Encrypted: i=1; AFNElJ9l2hPCs3H5cnumSI01ZQV9dnKljEuIaei3Y2TRbKDA9Wu9+u9kxjahx7Ed/+b8A7eONm2zhVYS1gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTOasnvTlotD/DWm/LMcZNwRZw7IpLPrJab6coiQ13fv3HW8N
	08C27WxmPEJtQPerdJo3jJBWGYltrr7aie+QAXMGx6dOvvMkAjPlNGogL6cGi6ixBZoNxuQ7bLx
	hNlgCVVMBPmPEMXaC0EjeAlIJUX74T+eQ5SSWrx1kV/qOBQGBOlu5wa7KchK3xQ==
X-Gm-Gg: Acq92OFpCSjMj2YH3ibDiyQ8yaxQ5XijQuChwQ2HiEYXQMYSwUu8sqn6mjw2inU+DHV
	JdYgMeLOdxZRupIecbS2VmlmGsadb3iKkWpmIohNQrJ4OHgA6k/pf8mfI8gyYEZtuB1FjScITs7
	p20ccElD0gHK1q8n5cnSiUgP3Ba7jgb2JNwc7kr9RTA0iFEtCWs4XnU1YIn+GN2T7U64B85oC7x
	Af+R49/9oB4YHw+uGJTvZYa8RkSF0i59JAJfoi8dd9AlFwOqxHCrMp4CCCr6gDAjgVVxc8iJTic
	FmDsw27xXXYLsugfqy9Z3YVH3TlDVZ0fpPRmAJEvvsPRV1ai6pkuCDhKRNnbBwmx9+hEbbbeNgC
	01oh6OGF3zdnHyHVwwDmEJkK/BI33TCtyhoLhcT6O1smScmjKbo73UFY=
X-Received: by 2002:a05:620a:4708:b0:915:cf88:1e41 with SMTP id af79cd13be357-9161bf6c4bfmr926953785a.45.1781342549624;
        Sat, 13 Jun 2026 02:22:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4708:b0:915:cf88:1e41 with SMTP id af79cd13be357-9161bf6c4bfmr926950585a.45.1781342549179;
        Sat, 13 Jun 2026 02:22:29 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm454992285a.21.2026.06.13.02.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 02:22:28 -0700 (PDT)
Message-ID: <fe40891c-3fd1-417c-835e-6f1046db7844@redhat.com>
Date: Sat, 13 Jun 2026 11:22:24 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
To: Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, arnd@kernel.org, wei.fang@nxp.com,
 frank.li@nxp.com, shenwei.wang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, nico@fluxnic.net, adureghello@baylibre.com,
 ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-can@vger.kernel.org,
 linux-spi@vger.kernel.org, olteanv@gmail.com
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260609142139.1563360-1-gerg@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-7836-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gerg@linux-m68k.org,m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:arnd@kernel.org,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:nico@fluxnic.net,m:adureghello@baylibre.com,m:ulfh@kernel.org,m:linux-mmc@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nxp.com,lists.linux.dev,fluxnic.net,baylibre.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4B4567E377

On 6/9/26 4:12 PM, Greg Ungerer wrote:
> This odd collection of patches is aimed at fixing the non-standard ColdFire
> set of readX()/writeX() IO access functions. Instead switching to using the
> asm-generic definitions in include/asm-generic/io.h. The difficulty comes
> in trying not to break any drivers with this change.
> 
> The implementation of the readX()/writeX() family of IO access functions
> is non-standard on ColdFire platforms. They either return big-endian (that
> is native endian) data, or on platforms with PCI bus support check the
> supplied address and return either big or little endian data based on that
> check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are currently broken because they are implemented
> using the readX()/writeX() functions.
> 
> Patches 1, 2 and 3 in this series are specific driver changes that can be
> made independently of the final ColdFire readX()/writeX() change.
> 
> Patch 4 is the actual switch to ColdFire building using asm-generic
> readX()/writeX(), but also contains three driver fixes that are not easily
> handled independently.
> 
> Note that I don't have access to all supported hardware needed to fully
> test all these changes. I have tested what I have, a bunch of the standard
> Freescale ColdFire eval boards, and inspected generated code for differences.
> 
> Note also that patch 3 relies on changes that are currently only in
> linux-next, and are scheduled to hit mainline during the next v7.2
> merge window. Those changes are also available in an immutable git tree
> at git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
> cf-internal-io branch.

I understand that with this series you are targeting the m68K tree, am I
correct?

A possibly better option would be, after that the pre-req patches land
into Linus's tree, to share an immutable branch for this series, so that
both m68k and net-next could pull it.

/P


