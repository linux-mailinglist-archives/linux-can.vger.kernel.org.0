Return-Path: <linux-can+bounces-5822-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2080CA7A62
	for <lists+linux-can@lfdr.de>; Fri, 05 Dec 2025 13:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5409A33E3ADC
	for <lists+linux-can@lfdr.de>; Fri,  5 Dec 2025 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB3329E51;
	Fri,  5 Dec 2025 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQHC3P/2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxP2iNwu"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCD246BD2
	for <linux-can@vger.kernel.org>; Fri,  5 Dec 2025 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764932170; cv=none; b=Yhoj1xCVQZUyaotSq1nvO7dbLqcdqHKDiUji/J8R+NuElvVWdKZ88xPnGwM1kskFAYA62s1ckjbxcfZPh3aiZV4Bynwo6XGkBofXW7aTpwfQLWassXHbDZhEl1H2blTqBAXOXSdrXaRkP49Ld6OXqLnQL/SLWPjvP0twAtBs/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764932170; c=relaxed/simple;
	bh=li1n7AiJvWRG4/ZcB/yX/5YGbsKuOzGw1EsKlGT3BtQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=siyj1UCUfyZOovHRJkTYS1/vITOHDoHK2a/Jgw8XFvbVewB62ZD/50VNf2MSDmXBj0+r4IP5jgVjqJjhZQm5jZwcaeSO8Tb81wtmiQXLI7XVbuQNvjIVeNsjwEkbIAn6yMZsMm+07kq9GYYgY0LB2oZXDzbkbMsGQsLY2D3I0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQHC3P/2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxP2iNwu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764932153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7gSf2n5M3odk+ChxoT6AFUK+lODC5oQOZkjvhzNfhw=;
	b=NQHC3P/2OB18nWjkxyx7xwZc5zuWwqP15gzLzBp1WWSlo+KwFIA5cR/NEP06YUinF7GKtf
	JXHGNfgqsAIScBQeLG2agZVCkOoGtexzqgHqlW60J66Eic9UlWS8B0gcUeQLyhv4jYoiJe
	GglW/wZeXdBHRsNty78XAz+kHqwV/z0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-HI01OAXQMwetNBoROC2btw-1; Fri, 05 Dec 2025 05:55:52 -0500
X-MC-Unique: HI01OAXQMwetNBoROC2btw-1
X-Mimecast-MFC-AGG-ID: HI01OAXQMwetNBoROC2btw_1764932151
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b79f6dcde96so288413466b.2
        for <linux-can@vger.kernel.org>; Fri, 05 Dec 2025 02:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764932151; x=1765536951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7gSf2n5M3odk+ChxoT6AFUK+lODC5oQOZkjvhzNfhw=;
        b=BxP2iNwu0/ew0K2BhcX70SFxDDH5wPX7TPNg5v0C2W6ZTMQ4ClIlhCTT/773B8EXcR
         AR56glnVDZS4UO061amT+cLJFC4h76evOMhzbohKnEC53J7lIY+pq/F7YwZVZ6E/r5ex
         86uk5eaUAqZpCy7OaGuassAr9ZJPaBYEtrEhnl35t/7FzOyq8em33FlLLDe1cpNiNrkG
         ez+/Wo9qJF/zTUuFaHNnUhGRjqMFm67QjgU25kf7p2LyjTUgGaty8+GxhNxyuIpdlr1d
         l7RkqK6aHisb55O0PlcO7bctldlE1qvG41+8oq3uxBGCQZX7/PyX5UMf7MvpY1AOHMz/
         5nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764932151; x=1765536951;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7gSf2n5M3odk+ChxoT6AFUK+lODC5oQOZkjvhzNfhw=;
        b=ajOiWwxy/1576Lcc8UN8QncdUDmtLH8K35WjR661xitx3axpmT0h1fTAWnv/NDnUpJ
         cfPuq6/HVLQd9ALxgyH+kql2L41fmad8Z4r/6paINNK7KK4Dzp5L/qT1GUNOwPqN8Lz/
         xzoBT2TUT77Sn5in+XNjbNvhHNLURxvsOKN1b3TJf7sHGruwB9L8d6pdY1ImZdO1SufO
         QXNwLTyP9/9kUnExguD6Q6nBdrqnC8+pRJkWngFXuySF3krxds0NBadnM0HOaC1YXeb6
         jFQpaU7p71HawA3WnD8328qoo2z5MQ+DLJq1CuYCG2jM9sbXKRLWxNDxo9pCUj99kSNf
         137Q==
X-Forwarded-Encrypted: i=1; AJvYcCX66ytc1ttrOKdynkPatjdSVwzNV8UtiaDya+eACJCDxGH39MvKu1QDVxArjY72rM1HhYtlRxkwabM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBha29DrrSL6VHoVWSl1ixRhO5qdDSQNHPRliuXPhFCn0YI/q
	vrPSJ18HfJDmP4WURqXGX1iSJ9vWoK2fnmX2A5Bam2RxpTwbjpLBAGMf5b+2ztIHg1wcg59Qw9R
	bVTxVIXJIVA8zl9G0q5/R4GYY1gFDw2mw4pWcM2jhVwjhBAESzRoM3ijU1UQx3w==
X-Gm-Gg: ASbGncvTgvSgT/6GTuJhhEYr/ghf7F4u+lTdzbURjcVBIWTbJ/HmpsmY7erzHdAx+b7
	qgD0ZMfjvc3v+0visWveyDE8MZlqgsF6+pKAwIOyiypkDiG4QSw2NPLMnMUOId4/e7bdbtTjV+X
	7rOBmhlLjXnPKCtYQAlFIr5QyiOvDWjNN8TpnHwIMupYaewfnQX2Q+oDCFmuebi4W2CJ+aiwZfK
	hHBi7f93YHEMdVud/3XwFzJJoSlPTSAUJYW/T9sxH5LyayZG7exsyFGt8PxmM42QDHHTuVkXAzp
	E5BiKiir40V1zlzTO1jyBSOyrK7vf1X223IjNHcUuWWmCgFlmdkjlWrZUFkfzGDPH0FVEfZqhea
	8oJvMlLpe3gTW9g==
X-Received: by 2002:a17:906:7953:b0:b73:4fbb:37a2 with SMTP id a640c23a62f3a-b79dbe8c6bcmr946948766b.5.1764932150919;
        Fri, 05 Dec 2025 02:55:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0fCpVjMBXkMIqMsOLr+JuNuOZ4LtvJSBlHhcUoih/A51LWRZLURxoWIUd3WMgn58OFYGAPA==
X-Received: by 2002:a17:906:7953:b0:b73:4fbb:37a2 with SMTP id a640c23a62f3a-b79dbe8c6bcmr946946066b.5.1764932150435;
        Fri, 05 Dec 2025 02:55:50 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49a897fsm344670966b.51.2025.12.05.02.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 02:55:49 -0800 (PST)
Message-ID: <15b104e5-7e8d-4a7c-a500-5632a4f3f9a8@redhat.com>
Date: Fri, 5 Dec 2025 11:55:46 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [ANN] End of year break up to January 2
From: Paolo Abeni <pabeni@redhat.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <bpf@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 dev@openvswitch.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, devel@lists.linux-ipsec.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
References: <3a2cf402-cba2-49d1-a87e-a4d3f35107d0@redhat.com>
Content-Language: en-US
In-Reply-To: <3a2cf402-cba2-49d1-a87e-a4d3f35107d0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The EOY break poll concluded with a substantial agreement WRT the break;
the final figures are:

			Voters	Percentage
it's great		28	41%
it's fine		23	33%
I don't care		11	16%
mildly inconvenient	5	7%
unacceptable		2	3%

Given the above, and that the capacity in this period will be severely
negatively impacted - most of the maintainers will be traveling to LPC
the next week(s) - net-next will stay closed for new features until
January 2.

Fixes (for both trees) and RFCs will be processed as usual.

Thanks,

Paolo


