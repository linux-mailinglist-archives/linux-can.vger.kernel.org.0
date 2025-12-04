Return-Path: <linux-can+bounces-5818-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD45CA2D63
	for <lists+linux-can@lfdr.de>; Thu, 04 Dec 2025 09:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F5C23009A9B
	for <lists+linux-can@lfdr.de>; Thu,  4 Dec 2025 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C420831ED7C;
	Thu,  4 Dec 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ns5DB6Wh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nRGqH40E"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7B10957
	for <linux-can@vger.kernel.org>; Thu,  4 Dec 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764837461; cv=none; b=HAqFYxFzSd2ctsWlOXk3jaq6MygDCYqmJ74I1opGRzHZK80VBRBgV1kmV5FRHEcG+MnT7pjMSWBNaq6BG1HenMMR+MrimRjD5K9PEwMs0M60eOBryqBbDQnxtSoLqezxPjG8G/5EEKzYszYYhlQFlf27patsFUEDys5MnleJmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764837461; c=relaxed/simple;
	bh=Fgti3Yp68+r1SXdHjNvigqNpTieQfP3rIFRvqwDgXVI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=ObkTvFBIKSi9fY7YJpM+Cf7mXxiNkngaRTDpSCC9Ffxzpd8E5xm9r5HLBfSOvcKsiMEn/+oREsroYc7Gx15/1Ac/qyRq4Dv4f9mu7eojsocz6a5S9GgbqSJBqfnhJo2JV8aDXowChDr2noiwfrjFWaHwLjORY3uobbiXqIDDHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ns5DB6Wh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nRGqH40E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764837458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fgti3Yp68+r1SXdHjNvigqNpTieQfP3rIFRvqwDgXVI=;
	b=Ns5DB6WhZd8skRCB60Zd3Wpy+9F9Twhjh3QhkCGMIoPd0QS2q9Sfqd2vJlAXSBbom9Ru/j
	tewZ5S8H4K8YjAAf0EbS5LLIH4Ml7tJC5IilcxWXl4RxkDYqzp1UcLouImpzsnkjXZFQAk
	RJPpi/q+hboTyXvqgZ5GjkTnfHlR5wM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-_YqDA7fBO4GSu-8IhC-j1w-1; Thu, 04 Dec 2025 03:37:37 -0500
X-MC-Unique: _YqDA7fBO4GSu-8IhC-j1w-1
X-Mimecast-MFC-AGG-ID: _YqDA7fBO4GSu-8IhC-j1w_1764837456
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2ffbba05so298993f8f.0
        for <linux-can@vger.kernel.org>; Thu, 04 Dec 2025 00:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764837456; x=1765442256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgti3Yp68+r1SXdHjNvigqNpTieQfP3rIFRvqwDgXVI=;
        b=nRGqH40Eb8jPlEqLKyctp5JX+jgbcBrCLcW5eNJGsrb0WLK+aRsYrSLip/KCyGA1DS
         CQHnbDmDWR7WOGZ65oRG8yBcflYV47Ft2yDKRE+7gWvB+EzVOXFpqNbp3aHUAY8yBdL1
         K51BgV3HT+L7Uy6HI/Mhnu0pmcMM3v3plD23xvSCYxS5kh3GTnIr2eNCMuVG+g04dzIR
         WWxiNixQqVzinaKaU2DJ86Fo/1F1aDVHoq3iL/OffZ6yEFy4k5jav41dDxacMk1H2Rqv
         3O1tiOYx0pvCTK9+uM04dwmHuQ7utOKkydby6N6FiBg5nOaskqvTRTAej+vWUMlrgkcn
         WhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764837456; x=1765442256;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fgti3Yp68+r1SXdHjNvigqNpTieQfP3rIFRvqwDgXVI=;
        b=EU4q2hxGaU2KyfxWJL87L96dZY4uL94xvUMT9H0GMe71CGtbH2x0WsNQgXni18gxde
         ZUKRwlxKOuJ4nAQLCa7qPYoWeXCrMqrMsHr+iGCZ3cQ30/aZSk6noacpzRhXyNJXeBDo
         YaqytFZoqTp67Qpf8CNokwEcTmPW5d/zwNY/mIwrixPxJDIm+Q0SzuzkH46yOgQUc33V
         dWW03Z4E++PTtU/y572h28D4kVHireeRuFp/0VBf349a4JyzoiLXEG6D2abYF139q1Cf
         Hw1AwfVZ8x8vo2RszZrWqsH3yLxrz2GUNopUPyIIjzMsFZUse/4wBfU7hhAEwG2lgNw5
         TMOg==
X-Forwarded-Encrypted: i=1; AJvYcCU8yS+JTes4PDxt/KPeSfIXTVO9gE5FU+Zkq56K0wtbAYKcnpsIXg8Hn6wxO1tV3HEeH45LaNAeIP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhmDYo/UJ15S4GE1nXOFzDJ/BSqDRlGrsasV9FR/GWaIvMALmM
	Xia1Efjv/i5SpwIXjz+in2kNo0ZYA3kGQ0teSNZJ8qEBTI5V/zWBYCLtAqSqHu8nemnkrwoMDhc
	DFxDlPcVF5+Yh/mDZ3ZtCWdrSFwVUHJXBIMaVNO1H00gbJ/rm9QSqawvOgaESDQ==
X-Gm-Gg: ASbGncvS3XYynaEuniS56cX3YQ6S1DohzXIGS3iiVZOGGH0cHtZqJ3UPD+nXlfP/Pvq
	yw6sQNRPgnHIlvLQieJV/G+ea+b+vSoW6QZCld3Wp+JQYgUupvlH9mYLnaN/iqXFrXM3SYWaNLS
	J7KcRIXTe8bKvJNv0fiEjyNkmnOh4twKlSXXzqNYazr+ys/DiydI2J5NvoITxZ2OjolYEwYtNvg
	Eu4LeHgYVY1DW87+UMtMqKPrBm6B4B7zgq6UtVj51She2rXG4KqFJS67zehireugfaNIFnSImKb
	q1em71JU6jLTIIFRKsre3wEvNrZJA9tBu1HGxyM3GKUoInLHADlt12TUWHvLtjMyNBGgylaxDOR
	0xvWUlpaeXiAs
X-Received: by 2002:a05:600c:3b1f:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-4792f24413emr20683855e9.2.1764837456389;
        Thu, 04 Dec 2025 00:37:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOFiaycmUpSi4NFw0Dx9Owuk3m9GKbQxWbEzhOFEEvLDFewzTh2sfwX63tPD9WFtnBq5V4Cw==
X-Received: by 2002:a05:600c:3b1f:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-4792f24413emr20683335e9.2.1764837455818;
        Thu, 04 Dec 2025 00:37:35 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d352a52sm1925339f8f.38.2025.12.04.00.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 00:37:35 -0800 (PST)
Message-ID: <3a2cf402-cba2-49d1-a87e-a4d3f35107d0@redhat.com>
Date: Thu, 4 Dec 2025 09:37:32 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Subject: [ANN] poll on EoY break
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
 Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

Due to some unfortunate calendar, conference and personal schedule
circumstances we (the netdev maintainers) are strongly considering an
end-of-year break similar to 2024'one, but for a longer period:
effectively re-opening net-next after Jan 2.

Since this comes out-of-the blue and with a very strict timing, please
express your opinion using the poll below:

http://poll-maker.com/poll5664619x19774f43-166

The poll will be open for the next 24H.

Thanks,

Paolo


