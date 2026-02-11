Return-Path: <linux-can+bounces-6538-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGhbLGpbjGnelgAAu9opvQ
	(envelope-from <linux-can+bounces-6538-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 11 Feb 2026 11:35:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B81236E9
	for <lists+linux-can@lfdr.de>; Wed, 11 Feb 2026 11:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CDBA3050D6E
	for <lists+linux-can@lfdr.de>; Wed, 11 Feb 2026 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848F2306483;
	Wed, 11 Feb 2026 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DNFVCA3O"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24481324B1C
	for <linux-can@vger.kernel.org>; Wed, 11 Feb 2026 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770805926; cv=none; b=FaXaogQW3EQuxe9X8NskqPczrIzzenJRc5s4BgIJarKeHm/tggj7DYGvT0iRpIjY9PcWwEGIUUFLucREW4b6yvq+IOsIuBk2q7IOhK4yvFmDnuJ82pAO1vfmOExFvaQP9pUOWl89bVOaUNUUtCKAsyBa4DQSr3xmYDARZU5wSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770805926; c=relaxed/simple;
	bh=FOSilV9jCbDQtYxMn3d/k0f3+5fY7YvNPrxS5LYlEZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Da8TAr6IZyR73NbUk9GfVP0R6ZurQPQTjuP8gVteUQywAJAYUFfRjyTSv1feMcnIXImwrdxnT3QsF2mkFwMTEbU2HmENPwPpMPIc/D6hpdPY/DAOepJSlnyIopdSZf+qNBj6ZJ43AlPhHtvWSwaZo0hEUzGZ0xUNX6n1cCMAmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DNFVCA3O; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4362507f0feso3394662f8f.0
        for <linux-can@vger.kernel.org>; Wed, 11 Feb 2026 02:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770805923; x=1771410723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cpGqXAv+rZXDOFLu53KPftGLKum2yP86W9nBICbxU4I=;
        b=DNFVCA3OdXNCDsfdL61bMu3RPZY03679OPzuaUyulzLClBhU4kQvuW13XwY3UvKIRw
         dhIwxLzXBlRPBgAIgdCi9m4B7NnX6XqCRcFRQEIgSiqe8OGTlfQC4o15h9B9q4dYdYwo
         3vJaIeQzROUb6qKzqt1m5CgLQYE9NnFNm4HDira/bj0hski49h2KxCwZ1j1sj0+OC241
         yfAbOiLVfcx6Yr+dz9ZTR5DxedZ0p3JQ54azGegh/WrCHN39jDJm2lKC4K1OIZUpAltA
         zu91w2QO4bfua1nhoUVLWtJY8OU32gKv1jy7485LNXr8au9xcEqQy1nXm9g4kAIuvw1H
         xzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770805923; x=1771410723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpGqXAv+rZXDOFLu53KPftGLKum2yP86W9nBICbxU4I=;
        b=RygXE5hPWoDv0OvXXBcrRxmPnwtLe9W6h/HiWG8qupEPbH/vs9w7kk2Ru3E0qMSPpp
         iCfBm/FEXzA7OOJKgB6sJBdN6+Fvifm641vRoKx0zp1gumGRRg7A1+7lmwUkyDnNqoq7
         Ag/QG6pJaduGFSg3eR3iQnsZZWDMDuNSKPwZB+sTR29PN6Bka2IAXTDeYSodThrinSXw
         7o34jQV/sFj0YlsbnqQ/9qc3e+BqK2ryFI8Yw/ilgqT7unGPE9+tLkL0YejeSddgqLys
         kpltUTe8eH2DpPzinPHDogQsfA5De0pOzNVni/ILxB0DZCx/nk77dbVWxwLrvGhm+8LQ
         xYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0AZ15PAt+yA9BhaZu0cKNUdeFIlzwKvVOhKXfF/QSj3+glZHucL4YTY62S7lgIiOW15E5zdmW+1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdRJIjKvpMWfFupKjsQ34g3ycw6QBOMk5nvE1e3bQM97uvOO9X
	Xslwk49jkMuwNJq+akAkCOSgw7FfOMgsqzNpjhukd9u23Dv1EQ0vc6iFdHM4pl9UYJmSi7+Sa3A
	ryOuv
X-Gm-Gg: AZuq6aJ6HP7b9FuTGjZUHxMt0tPeGcm0ATg4/gSNSkW/84OUIuM2d3Doau6ULXasN/q
	hn34oseu7m3+h+YXLdQOAtNYJ0G6XBa+tERf8zfTTPInL2ghrRXMd0AfayeSIcX7zaH+PSnt0CT
	c1vvlv/Bt8FooXy7oL3uW413f5WXOv3ousxhAtKC1gxd7OYnWN8JiCTkgejjBwFF3Up7sVtE7Ns
	Cb69xkB1fVQ20xKUJ4mlnJf7qDoJglgZsaAb2q+NqGlqProEqXkM+jHxYWCJLHSiFnfBhs5XmB+
	7G++A69wb7YkyJH4UrZEWCs3XggWY4fHRMUZDtajhyobMMXcOOlNLKhrGS96lS2WeDsaSnzZgf8
	iRdv3aS60cRJqr/xj9oZ9DjeOIuzCHX39Z0ylM45/nYWKUflkxLIpbUdqoqs8gJ8RIX/N1KZZKa
	kVDLUPiO0MyoEleg9kR7S2dSndifwPoIAXliYj2BgCAQEFOpRchfL3eUEY6cnZkg==
X-Received: by 2002:a05:6000:4014:b0:435:8f1b:bb32 with SMTP id ffacd0b85a97d-4378458f33amr2461367f8f.32.1770805923375;
        Wed, 11 Feb 2026 02:32:03 -0800 (PST)
Received: from ?IPV6:2001:a61:138e:301:e4a1:47e:3f5f:5d09? ([2001:a61:138e:301:e4a1:47e:3f5f:5d09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc55dsm3769842f8f.20.2026.02.11.02.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 02:32:03 -0800 (PST)
Message-ID: <3b9a469d-d67e-40c9-b348-947277da8abe@suse.com>
Date: Wed, 11 Feb 2026 11:32:02 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: can: etas_es58x: full cleanup in the error case
To: Vincent Mailhol <mailhol@kernel.org>, mkl@pengutronix.de,
 linux-can@vger.kernel.org
References: <20260210145049.40995-1-oneukum@suse.com>
 <ff49fb08-f97c-449b-ab2f-7f10bf7dc1e9@kernel.org>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ff49fb08-f97c-449b-ab2f-7f10bf7dc1e9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6538-lists,linux-can=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE6B81236E9
X-Rspamd-Action: no action

Hi,

sorry for missing your last mail.

On 10.02.26 20:07, Vincent Mailhol wrote:
> On 10/02/2026 at 15:50, Oliver Neukum wrote:
>> Memory allocation can fail in the middle. Hence the cleanup
>> needs to be called in every case.
>>
>> Fixes: 8537257874e94 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
>> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> 
> Did you see my previous message?
> 
> https://lore.kernel.org/linux-can/CAMZ6Rq+TtQnA-vvmfKhRftOuXyxWOPNZ4uH5ObT884OLDZHyng@mail.gmail.com/

Nice. This is a definite improvement and solves
the issue, but I think it has issues. I will
send in a follow-up.

	Regards
		Oliver


