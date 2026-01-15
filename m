Return-Path: <linux-can+bounces-6170-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAF9D256AF
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 16:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3B0230B786C
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 15:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC83A9018;
	Thu, 15 Jan 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boiPMRI5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tBSrzjRB"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2D2FD7B1
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768491438; cv=none; b=EdFyh8U9G3ComcHrbND3z6wKM1nVJJdTPYyDFoTq9CDb7jjwy9vEE4ImW9eMMSEOThpjeCAE8rGfuQs5zR7golYjZ0M48Q4eVelvptQKCMECKRogSz+35RhKCuMOMDyx3WX72E3gshLTn42bA8VhPKz/rSfBUGAagB+AqtfY7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768491438; c=relaxed/simple;
	bh=XF28RqBi4SlwjxDLGtl+8Jh91wjCxXXEOaqjg2L/k84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTx3z6ln57JTBAfbGcIQcEs411q2yQRQhy4tCWkvxeaj5w6nfrzP0d6uHaYBXwM+mB41k+ldQzXxouiRCs71Jxu3YvpCuNYlidQP0Oyipct/3/LgvbLKHErchX8K5Ip1F+ka1wLCpBy4CY0mMp4FhiEiFCsRsxMZ5tqGpo09YYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boiPMRI5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tBSrzjRB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768491435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpXY7FmDacCa1GA7GmUw8ZF/Yt1FqaToqmro4+kI8Ro=;
	b=boiPMRI5ck6FPeYT4KZp31E21Wj196CrVXuGxdZEURizT/TdodaRyXceq5bg4dLjZlLMac
	nUu94F47QsbIbxrdPyaQKvTwqAwBujvfk/D598EsGzdm4hJwS5XpRVoaGIv3IiONFiUB92
	Jgu/TnAOQKWW0eMBW1BtM/9Ye0hW9OE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-XUPxmsF3MV6bFV8mE2y4sQ-1; Thu, 15 Jan 2026 10:37:13 -0500
X-MC-Unique: XUPxmsF3MV6bFV8mE2y4sQ-1
X-Mimecast-MFC-AGG-ID: XUPxmsF3MV6bFV8mE2y4sQ_1768491432
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee33324e8so6423025e9.1
        for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768491432; x=1769096232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpXY7FmDacCa1GA7GmUw8ZF/Yt1FqaToqmro4+kI8Ro=;
        b=tBSrzjRBXMbXr1E75zA1re2aVonmd6e1LSfu4gS7jIvXRHbnEG74BY3nYrh8KUhc2m
         N35QVaboXREXQkBvaDlnA8VBVbx24mLPQfl98Vosfmt5PDXzghj175zgAbz03OZXS5PG
         7AlD2J5wP2POKOktgfv89jGJlipcjKdWiZjzihAcK/H7IiaVbfZVw4zL0gbx/oxz0bAY
         3NQEslNUPiI9GG4KIJimAKnfFVYvXIsn+VNogfTRHkR/yz2EeHH4tF9ujFEr7mb7G8wa
         Enelq6sZa7Ay1fkk/delB2RUFcVCqs7R1orumdvT1QGzEg68WkEK7FHYxe+yl/hNmktX
         r4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768491432; x=1769096232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpXY7FmDacCa1GA7GmUw8ZF/Yt1FqaToqmro4+kI8Ro=;
        b=koxtH4Jva8EerOxpDdjdHb79TegCvwoD+apM6OJde67Y4J6HNXfB1a0r6u+4wk/RQW
         +RjQNpLvd14c5942wKKSKYC+gbXUziS1BXvvtRbUw9cuQbMDP5M3lBi+WBzcRAE+JNcn
         90PIyelJdB/HuNtzYaA2VzPsLHedyKwonwCxuE3QbyqDF/VBhT8L2rt2KSipHv3ikZo7
         aMAHGXY5UAh2tb0H96g1RYzXgpwmepuDCp8JuUIQm5i1dzqS0ZWnZaWAJ4+DiSDwTugn
         wukySV3yCubMN4Yx5b/bKtve5aouq4ZC2zMRZVOgsJF6T/o5eGpfblKb79SkIEXUFFuN
         DYow==
X-Forwarded-Encrypted: i=1; AJvYcCXmygrFCuROuLBwTnfdE6/3NeTTtstml0Nf35jZleNfSX0SCLWxXkpyG0vqqbwQM2Y86jG139WQKcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+Ne3Zfb1Ojm07n5DUQ/9vtRURKSeCWw9gm6rWPs8VJKqBJCQ
	hknokgprVC1BZKX6Xe3U3KZKiUrmPQOo9OhzJevVbyWjyjogYzZpO4dUN6sN9wgm0kMk/K92ndc
	rmFBujmAth1TUS0SUdPgSHZCc9BjRRHNLiTKAv47jcuvKQSVS/yP8EbmaP4EVvQ==
X-Gm-Gg: AY/fxX6kNIEo8JNg6lVGxUe7+s/TmrpYjVs27BeuLuPK1jGKZASBbZATpMHsxW4gwtp
	CMS9C7mRfJrXeYIgVuCMhonUdQzcrrJTpd83LHdZhJngKYvE6tvwxt0sWAFBhiTH9JYLoyHsLZr
	umU0AyjuYW1OD7WKnth5iDY8YdcKNw/eh4Ck+85UPSzp6af6bG8MyDIDpL/RrirpTUSH8MOs2nk
	yyLMlZyIZXSakfSOXV3gqbzrvgwS+N09zaGqQJp5cwIrkKsBJH75F/JHGrFSsbMClLN8AXVaUQ9
	P0KYWhl9dSq7F7MRTGMWc7mj2EXMyG+vIoT1+RarZnW5dMbG5LjZQTCWo+k5gQL5phYFfOSlBue
	rysfcwkTRUUwaIw==
X-Received: by 2002:a05:600c:3504:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-4801e2a95fcmr2863745e9.0.1768491432435;
        Thu, 15 Jan 2026 07:37:12 -0800 (PST)
X-Received: by 2002:a05:600c:3504:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-4801e2a95fcmr2863485e9.0.1768491431977;
        Thu, 15 Jan 2026 07:37:11 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee2a5e48asm44798015e9.20.2026.01.15.07.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 07:37:11 -0800 (PST)
Message-ID: <a2b9fde3-6c50-4003-bc9b-0d6f359e7ac9@redhat.com>
Date: Thu, 15 Jan 2026 16:37:10 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next 0/5] can: remove private skb headroom infrastructure
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 davem@davemloft.net
References: <20260112150908.5815-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260112150908.5815-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 4:09 PM, Oliver Hartkopp wrote:
> This patch set aims to remove the unconventional skb headroom usage for
> CAN bus related skbuffs. To store the data for CAN specific use-cases
> unused space in CAN skbs is used, namely the inner protocol space for
> ethernet/IP encapsulation.

I don't like much that the CAN information are scattered in different
places (skb->hash and tunnel header section). Also it's unclear to me if
a can bus skb could end-up landing (even via completely
insane/intentionally evil configuration/setup) in a plain netdev interface.

In the such a case this solution will be problematic.

Could you please explain in details why the metadata_dst option has been
deemed unsuitable?!? I *think* something vaguely alike the following
would do?!?

---
diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 1fc2fb03ce3f..d6ee45631fea 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -13,6 +13,13 @@ enum metadata_type {
 	METADATA_HW_PORT_MUX,
 	METADATA_MACSEC,
 	METADATA_XFRM,
+	METADATA_CAN,
+};
+
+struct can_md_info {
+	int can_iif;
+	int len;
+	int uid;
 };

 struct hw_port_info {
@@ -38,6 +45,7 @@ struct metadata_dst {
 		struct hw_port_info	port_info;
 		struct macsec_info	macsec_info;
 		struct xfrm_md_info	xfrm_info;
+		struct can_md_info	can_info;
 	} u;
 };


