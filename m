Return-Path: <linux-can+bounces-7353-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM0QO2KP1mmEGQgAu9opvQ
	(envelope-from <linux-can+bounces-7353-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 19:24:50 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667DA3BF7A6
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 19:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2611A307C487
	for <lists+linux-can@lfdr.de>; Wed,  8 Apr 2026 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138013D47A5;
	Wed,  8 Apr 2026 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="Oaii7BFc"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7820B3D5645
	for <linux-can@vger.kernel.org>; Wed,  8 Apr 2026 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668961; cv=none; b=Nf3lpWC/03tuaa7tFzfDSk/TXHiG4DtWWwhz5LoX1I0ReP4VOk4peztiNMGeI7ztuTj1gD8LrlHOW4HHaVWA1ffz+5q1z28jm23JYZRAPFDopWfkVkjV5RTmFLge/ecSumKKOOv4nQBnxjfvtXwIfAgkeAVGvYw8GeDtVXRpjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668961; c=relaxed/simple;
	bh=gNJduQx8uBBAIyt5/XG5cTtxBJWJ2wWwKg9EVpn6lE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQUk6Hs68HqV/Jf02Zp0mJnImDtrTinAhYJMJUhnFBFwUdrZJpY0evqc/1RezgA6g8o+jO2BqlHWIYMGTQVKCZbGVP7xlnr7vQH64NrJTuduTDaSTx/V5H82lBbkRNx+WadQ0iWhFpIOnz7kjG6epQuv1QvCj0hhmdtEwQAlVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=Oaii7BFc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b8efed61so658985e9.1
        for <linux-can@vger.kernel.org>; Wed, 08 Apr 2026 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1775668958; x=1776273758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyRjAExzptaZ37zBDXbJb6e5/hLDzY5/zkTN8PmV6NI=;
        b=Oaii7BFcfdgtD+RC7d2xsPVPhjXwM8nuzxIspweJl6mn6zyvXxyvnYsAmlkBi6k18P
         8z/BIqcG9ooXBmeVjpm4HVWJrYRvTsIWVGfdU5lwGgIK/SySz3sMPe7taWlKdxeYhVda
         A+RIAPjf3ikRFr7lW4xxFXVKTB//PStJc1ufFQjBFK3KtzXkWu4umnOVWcBmatuFyCej
         c2TYFWNbw/J0hZCdfSJJ+lwEigKyLTNVogh/cuvvMa50EbBn0SdcFgjm0ofNKX9jliwO
         m8LS2aCVYAJVBhMk6pbaNsvnMh7wGGmGLTUneryK2tRhQ+IHDrfcDYgWzRTdoSfxKFTM
         OD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668958; x=1776273758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyRjAExzptaZ37zBDXbJb6e5/hLDzY5/zkTN8PmV6NI=;
        b=mvpL5ZCTN32ywli67bSfXtqeuCLu/W/cKDlZdGKHbTMhFUCDVhKgjMND1e4NxjZ1Uj
         BbGXOg7/LiCcrHm3+OmiMQhxnqb8D7fthYLSADGEiEXIfY7Xfp1n56BIyQrUQV3fIVDw
         02t2tDBbiafj94Svn+MDfEp4fiXpe0vS1x6Ekq+dCxA0uZuyuchhhAh+P0rgp0xYp0v4
         vzekYfHk1MWAOb1c/f3rZusgczXUJ4u9R9EnzpcygoQT8oDLzpO2ql1a/UOaaQ8nk43M
         TGJJ2OqM/O69e/+8HOX15yRSPmDO3Al2pQPfci4/jyhvKb302I+KIukh+TG5uAecUtpJ
         JF3g==
X-Forwarded-Encrypted: i=1; AJvYcCUTxAh3UniEOIzPlioZKUF0ly4jQ3aO5nZT8lfc+R7kdOcMrxntSMdXDNSm2uLVd1bi9x26MHV1AEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4jZ2WUe/TxQza1c9C0WPgNKuFZSIXcEGNQbmxYXUdvoFiIp4
	99jXxvYPqo409rj57HtcR/vd+f8zMFcPQkmaj2ohwWF9K6ktHp3oy6zpa2lgcNpus9muxeu8qk5
	kiYOWxsa5
X-Gm-Gg: AeBDietaqenxrDl/4wI9zZVr00TxuN7EkWqmYz6Efo3h4NJOxgFwn2uZD8E/bpLe/aB
	VQ9W8KKjMPJ7dpo4n9pjrd41Kc9hyDp1eE3j0PNP/7aKG0pQXEjNVIzIvNIIITS61CM+bydNofX
	gPZgdigvkASS3FfTj9oaYQvyXw1GGvfXrl09DlSd8lhktAX60Seyh3oO7ykU39ZCcG6k+WAARAT
	0+2DEAnWjzw3B/ZuIpsSHJ563xmX1sbKOOmdDNqu7PN/fGVP2TGPna6mYBQslN6QR61h/u6+nhz
	g6pXsv48gOhJd8rBxcel8XMYT/spsWpMQAjz+gYuo9abt4Oy1yhzZEM+fvW2+1mfxsTGcdl11oZ
	/fcXlSX+4v3vYmuZaqUAH4t7GkOYT8bKwohzJkIIU+49bxFTGFYCQFuynjx4YQAQ1qTvVjXct4y
	OhIQAJxT6/zB4flcF64wtkualC9tPtlKazpK9rTRI9FKttBr8VO6pGgdUU
X-Received: by 2002:a05:600c:354f:b0:488:c239:d498 with SMTP id 5b1f17b1804b1-488cd557418mr5167705e9.8.1775668957556;
        Wed, 08 Apr 2026 10:22:37 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd1b57f8sm6879605e9.7.2026.04.08.10.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 10:22:36 -0700 (PDT)
Message-ID: <430cc8b9-21f0-4954-ae36-ec5e63f3ef9d@bynar.io>
Date: Wed, 8 Apr 2026 18:22:36 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: raw: fix ro->uniq use-after-free in raw_rcv()
To: Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Cc: mkl@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
References: <26ec626d-cae7-4418-9782-7198864d070c@bynar.io>
 <c67d6642-8078-4144-8b21-f0e882ecd61a@hartkopp.net>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <c67d6642-8078-4144-8b21-f0e882ecd61a@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-7353-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bynar.io:dkim,bynar.io:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 667DA3BF7A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 08/04/2026 17:28, Oliver Hartkopp wrote:
> Hello Sam,
> 
> many thanks for your investigation and for the provided fix.
> Excellent work!
> 
> Btw. you also suggested a different solution with synchronize_rcu():
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index eee244ffc31e..5bb9a84f2471 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -431,6 +431,13 @@ static int raw_release(struct socket *sock)
>       if (ro->count > 1)
>           kfree(ro->filter);
> 
> +    /*
> +     * Wait for any in-flight raw_rcv() calls to finish before freeing
> +     * ro->uniq.  can_rx_unregister() scheduled deletion via call_rcu(),
> +     * but RCU readers (raw_rcv in softirq) may still be active.
> +     */
> +    synchronize_rcu();
> +
>       ro->ifindex = 0;
>       ro->bound = 0;
>       ro->dev = NULL;
> 
> 
> Can you tell why you preferred the destructor solution now?

Thank you :) I preferred the destructor solution as it seemed to match the socket lifetime model better and I wasn't sure if the blocking sync in the raw_release() was too heavy-handed for this specific issue, given raw_release() already holds rtnl_lock() and lock_sock(sk). That said, I'm happy to defer to your experience if the sync fix is better suited, I have tested both of them.

> And if I see it correctly the UAF problem might also show up with the
> kfree(ro->filter) statement we can see at the beginning of the above patch.
> 
> So either free_percpu(ro->uniq) and kfree(ro->filter) should be handled after the finalized synchronize_rcu() process, right?

ro->filter isn't accessed in the racey raw_rcv() path as far as I can tell, and I don't *think* there are other racey paths but it wouldn't hurt to handle it just in-case. I think this would be simple with the synchronize_rcu() patch, as you mentioned, but I'm not sure with the destructor.

Kind Regards,
Sam

