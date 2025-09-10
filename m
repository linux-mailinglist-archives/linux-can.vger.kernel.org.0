Return-Path: <linux-can+bounces-4637-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A556B515A7
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 13:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359613B5F57
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879A27E7EB;
	Wed, 10 Sep 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzVBvk0x"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49C0279DCB
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503705; cv=none; b=KhlDuXtc+0nRpdQuGnlwBPJ3RehJ2Br4v3S4laU1uP85+XBnUfau0HMw29mnlOLcxPjNTb/8XHt3p++qo0ZjvLxdWsKCbAYkofe7NoA0gkeO8ipGfgGeJUmwcid7cAr8o48SVjkR1n6KsdYO0oRnwhdfX9tVKdP5lm7fagEmZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503705; c=relaxed/simple;
	bh=gzm3F8ivWRsE+wMhk0jcUcCb5z8TdXLB+FZi3iYut9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPPT9twWDIrls/yW8JqaQySMgFSAi81gIt/B+6XDSDOF/F6r2ob7LfbQ5Sa/z43x2fiwTAGdvf1Z+WRID00kVVUYms38GFCOGhtMj59F9xkYstJ6CfAy9Hpja3+ej7YMiMwX3POFecrfoAojwQIhp984FMT7EKfxpj6vYwVLQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzVBvk0x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757503702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/xLdEa9NYg82axRGOeMagzWxKZkX5+y179Pb1sa7+E=;
	b=NzVBvk0xOjp7z19nEVXEzrXFF7OPQJlePMYZeDkW3xjztJgnrJdK1IDBl85B3twMM7AMP4
	rpeJJSAfKZDt/+2vAJ7LEj5qX2ODMcFwZxho3KnaN0BLS1l/QdITLGsliv0kkpRZ6q8ad9
	UbWCAzDzgOCNFvDrfDhYL0Gv/MT55cA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-bG4XET_WNgCEAZdPWiaytA-1; Wed, 10 Sep 2025 07:28:21 -0400
X-MC-Unique: bG4XET_WNgCEAZdPWiaytA-1
X-Mimecast-MFC-AGG-ID: bG4XET_WNgCEAZdPWiaytA_1757503700
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dd9a66cfbso48115755e9.1
        for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 04:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503700; x=1758108500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/xLdEa9NYg82axRGOeMagzWxKZkX5+y179Pb1sa7+E=;
        b=VHSHRXLYj7OH7t2dnHoLms99bhrDGAbN3IMy3EQJAE3hzzoeK6WRGwAe+MmaLMGS6X
         iSP+YVNT4DXhgb4mGIb+p8Fb20EGIm0+dyF5Nsgjnz08909CQNoY9DEs2CR5hO4ijXVR
         pShQ+uiduTGKYIrxcR6F2vCuuSqDpfovHdf+kfgIh0i7vkzYojyJ9a4PwSCM8p7dxOP1
         iYdenGvzbVkXfVS0Mcz9pPw4uE7tg8YZo4MH4nvleoq6MUNZ5bZijuL5C7F9w2FZuQts
         zYfCIcPL5NTmEl3MF6t0DrhLu67fjBALPQgYQK5gmOESzYDWDP8g9vEaK2mzqrgALFA6
         zwAw==
X-Forwarded-Encrypted: i=1; AJvYcCXt0D/drcrHAMixnA/tf2w6+MQMAYtlctEMeoIfl1phtU3DZtd9+SqEz8o20AD5imvHjrsehaGh9mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+fZGuR4Jv3LbkudwfC2W7LPlHAg6/AFeF1QXmPS0BjUpJyUN
	SskqTD1mVrYEeQPBLW/HO0BlitCe7cXW5xFEmYR5+2ZVUmHFP4QsqBSpbLvIc7rprYJWQCBFr9K
	GbT3UC8e350JYmhkqMjD1ZaLoc6Tu7wDCnqLe4TanQKhrf6qH9IT+N+j/D9SqIg==
X-Gm-Gg: ASbGncsJVcz89A9NUhH4iIAhusbtY6WNiyrBXTtrZWmdRb2A3Fhyu8aBP0I39eJFJvB
	7AEP73xIEd0+ADUnRw7ual5o5xzkhVviZvJEmdtaQaBGQKXS9V+YybmSCjYkspJpgcvcHQR62Sr
	mfHmk8XIkkHBzGSiqCamgDNqxgNDPi33EoFCqajRw/T3OPlsKjj1zk0/pgccI1b0gXy3eCdQeLE
	3fz9uIl7tXrUOO6rgnvn46qx0HIPkB2D5JsDTEZZCimP/ylH3cy2SLgc7L9lP+uBmXDF20igDBh
	zhIzqSAxsbINCbpFY51Ds67ichk3v4EL8JOCPnFddPOp/A+XtQu55vof4TLCWiYjUngTfBsnqiV
	evkiZP6eKFoQ9
X-Received: by 2002:a5d:5848:0:b0:3e0:152a:87b7 with SMTP id ffacd0b85a97d-3e643ff65a8mr11134655f8f.41.1757503700125;
        Wed, 10 Sep 2025 04:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTBQtFcvzi2V8WZkeFurWwi1Ly/HO/upO55NveOTrwxl4mWUJUFpXmy+dZri82kAe4vbD1pg==
X-Received: by 2002:a5d:5848:0:b0:3e0:152a:87b7 with SMTP id ffacd0b85a97d-3e643ff65a8mr11134635f8f.41.1757503699706;
        Wed, 10 Sep 2025 04:28:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f5d7sm6402712f8f.53.2025.09.10.04.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:28:19 -0700 (PDT)
Message-ID: <0ab052de-5187-467d-974b-aa9f9533621c@redhat.com>
Date: Wed, 10 Sep 2025 13:28:17 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/7] selftests: can: enable CONFIG_CAN_VCAN as a
 module
To: Davide Caratti <dcaratti@redhat.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>
References: <20250909134840.783785-1-mkl@pengutronix.de>
 <20250909134840.783785-3-mkl@pengutronix.de>
 <00a9d5cc-5ca2-4eef-b50a-81681292760a@ovn.org>
 <aMEq1-IZmzUH9ytu@dcaratti.users.ipa.redhat.com>
 <aME2mCZRagWbhhiG@dcaratti.users.ipa.redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aME2mCZRagWbhhiG@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 10:28 AM, Davide Caratti wrote:
> while the enablement of CONFIG_CAN_VCAN is still necessary, the contents of selftests/net/config need to be preserved.
> @Jakub,  @Marc, we can drop this patch from the series and I will respin to linux-can ? or you can adjust things in other ways?

@Marc, IDK if you usually rebase your tree. If that happens, I guess the
better option would be squashing the fix into the CAN tree and send a
new revision for the PR including the modified commit.

Cheers,

Paolo


