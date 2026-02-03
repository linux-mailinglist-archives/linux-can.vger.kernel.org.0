Return-Path: <linux-can+bounces-6477-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN47LNQJgmmCOQMAu9opvQ
	(envelope-from <linux-can+bounces-6477-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 15:44:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5C8DAC30
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 15:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C50DF3101DAF
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF0B3AA1BA;
	Tue,  3 Feb 2026 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cz0/avTW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRB6xPPl"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFBA3AA1A5
	for <linux-can@vger.kernel.org>; Tue,  3 Feb 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129615; cv=none; b=frrUL7/pVAekC24KxTDQsx0iaDdMhbj1hBm5Vk1VxaFb5smHcr7ttb1G20Zkk6PmCCIvJi9iTuwmipNkqkNX6BMQroVD1uyG2H67TXUhvHRU8jM+85yhG/zuRH219o7c0Op4GMsSmmNkvPCR2Pm3oKdBqrHHoeJ9JmF/2hNzaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129615; c=relaxed/simple;
	bh=w6VqQQ3kvvaMxttD2hQ3NUd84N8EGa/iURrUmh63aJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZ4oWCq4EqUzgSKMKMF4+EJL5E1zqk1JmukvxNTWj158YYj6rfYa0ehGPqghokUhjCeTNyAPCOO3bnT1GZ9FPrc2UxROHx96uY8XybE0jyZnYj3k3Z+hatNIJoEXZyJxyjnylLXjAcN/0D3LXhI6xd7a+oD5NmQD5PuXulapWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cz0/avTW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRB6xPPl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770129613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXIK8pbr0Ak3R3kwZ6QVVlTeM/dr6lUn4/7h9iePoDk=;
	b=Cz0/avTW0oVPH4fSPnZCS/e0EYIDHVoz0/dOBSh+uT3W29Xrj++1npQeqi/k27Jl9PlTfh
	68bcfQWZiM0ZpZ4riFeJbfLVZxnTHtkQnl6C+WShU74xLGPYgONDPMnfaytBEogzXWzIoh
	LzncVRxZJWoXZhm+wd7pWUaZIqR/sL4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-GZ2sRWlsMEeJBDol-lrFWg-1; Tue, 03 Feb 2026 09:40:11 -0500
X-MC-Unique: GZ2sRWlsMEeJBDol-lrFWg-1
X-Mimecast-MFC-AGG-ID: GZ2sRWlsMEeJBDol-lrFWg_1770129610
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325b81081aso7439016f8f.3
        for <linux-can@vger.kernel.org>; Tue, 03 Feb 2026 06:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770129610; x=1770734410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXIK8pbr0Ak3R3kwZ6QVVlTeM/dr6lUn4/7h9iePoDk=;
        b=CRB6xPPlf7+HTeOx7qkwfoJVF+RykvOOcssRwC99WLmBp/BredRNhNuFUDUiPI6MTC
         TddE9z9E2hxFwkRKF5UbvMi5vBr4wvss4hYI5LSsSsH3x8DsUH5AW+rcyIRR6GNTLj/x
         6fc/EtDgpG8PlAZW56n6BKXwY96i2DFkvkJ1/mckGLvYFHgAOPTSTpbaJg6TR0cWlHn2
         W74V8fWlsfJR9UNsvjjR9FTLET17Sfpnv5IsaduKQe2C+Gm4730zp6Dug+boNokZUkt4
         hXaND5Sd2Jy7XbuHBGCIPuaLrozIroEaUcpZlOr3DWB6huhlmPwtL1Mgq6p50HGGLgEw
         UnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129610; x=1770734410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXIK8pbr0Ak3R3kwZ6QVVlTeM/dr6lUn4/7h9iePoDk=;
        b=YXyVSkRh1aR6qoZ33CDDA6f5+5FuWFEwlta24yRrPQ5SDFz9ts1/InVTU3SkhWiZAj
         hBR68po0G7fJE54djvJsVe6ywwFLIF+D3eDyUoRExZwmSwQLABPuRBkuT4O5mli1W2gQ
         oqD4ALvy1q3fTstzGhXjriJNAwrBjUBG1Q1q+Pb25rbCGvj/jM2ZvGHXrZtRqIQTP8Fr
         xU2QtzNeiYSzypj91ypR3mfAYcO8nyoHb2N9nhK/HbJUdQhfGRy8Lpa8ZmFerk0oLfdv
         3cvWAP1+II3iA91FGrQuSn7tIj8b3Y7Vslzoi3MK3hPoF3ZobQo6j8C0Zs+8kSj+ca3g
         EWHQ==
X-Gm-Message-State: AOJu0YxBeTV7tg+rvL57pY7qDY9qmTYWP28+pZjcJVPmedaZK1sCaXNp
	WIkTeyytUwkSPHx+ljWQY8Mff1HQmAn8A5rMnAQ5fQ6+3aPjr6QrFyb625cFktJcTWUTwu6ZWGf
	/OOEhe4Z7YEs0Xq1rhaZ10QzpaZfIgR34XyGO/sRLazmJHZLDSuilJbNA/S0hBQ==
X-Gm-Gg: AZuq6aLbgBmJQLy4LQBlDkbLYThSbj0IC0F/dgQnEsXPK76L3O2T1JY3iTNwDcH8TRf
	N0x+6KPuqOn7dTRimtux6YhkmEbwPSYabGfG56FZggh7sQe12WmsQiNMluOlP3NQTu6x5z0yiCT
	pY//kFI3BWuPLQXuzcFB45jmZl1G+L7UD/br1Aj7De93jsNMTZ54Fj2KgWtUeFXq4q10t9Otutg
	dDiLOIHT32Y+00jeTDqpYKT1Xcl5J/uRcmm73OrZLPAZH6PTTp85Yl+Pip+OI4QknKDgBSWEJ/E
	9+wuLeZ8IO5iOgY1FNusK8o3wuFnaO7HyH1vW8LcWkMmzt02vXo94DRLJpLmvNC/ok4tq6G9qKy
	rumM0hC/5iyo=
X-Received: by 2002:a05:6000:4212:b0:435:95c9:6891 with SMTP id ffacd0b85a97d-435f3abc59fmr25258112f8f.42.1770129609297;
        Tue, 03 Feb 2026 06:40:09 -0800 (PST)
X-Received: by 2002:a05:6000:4212:b0:435:95c9:6891 with SMTP id ffacd0b85a97d-435f3abc59fmr25258065f8f.42.1770129608803;
        Tue, 03 Feb 2026 06:40:08 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce64sm55977770f8f.26.2026.02.03.06.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:40:08 -0800 (PST)
Message-ID: <7d544645-8699-409f-89c0-6fc606113627@redhat.com>
Date: Tue, 3 Feb 2026 15:40:03 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/6] move CAN skb headroom content to skb
 extensions
To: socketcan@hartkopp.net, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-6477-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C5C8DAC30
X-Rspamd-Action: no action

On 2/1/26 3:33 PM, Oliver Hartkopp via B4 Relay wrote:
> CAN bus related skbuffs (ETH_P_CAN/ETH_P_CANFD/ETH_P_CANXL) simply contain
> CAN frame structs for CAN CC/FD/XL of skb->len length at skb->data. Those
> CAN skbs do not have network/mac/transport headers nor other such
> references for encapsulated protocols like ethernet/IP protocols.
> 
> To store data for CAN specific use-cases all CAN bus related skbuffs are
> created with a 16 byte private skb headroom (struct can_skb_priv). Using
> the skb headroom and accessing skb->head for this private data led to
> several problems in the past likely due to "The struct can_skb_priv
> business is highly unconventional for the networking stack." [1]
> 
> This patch set aims to remove the unconventional skb headroom usage for CAN
> bus related skbuffs and use the common skb extensions instead.
> 
> [1] https://lore.kernel.org/linux-can/20260104074222.29e660ac@kernel.org/

Could you please share how skb_ext size change with this series?
(possibly breaking down the actual size to each separate extension).

Ideally/hopefully the  skbuff_ext_cache size is not going to change, and
that would ensure that this change will not cause any indirect regressions.

/P


