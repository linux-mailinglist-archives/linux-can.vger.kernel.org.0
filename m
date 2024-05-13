Return-Path: <linux-can+bounces-633-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2558C3AF6
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2024 07:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F09A1C20D48
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2024 05:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC53146018;
	Mon, 13 May 2024 05:26:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EF146006;
	Mon, 13 May 2024 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715577972; cv=none; b=ZvpHvaTywDqs6Fh5Imk89+0k2Aqd2Zr3XyBdgSZps1+WUAF3l2Ycw4WMVh37h+NmOTv9H/K6WjwUJFWvyzsm8zn1S1nEtYcAUVpL32A4qo8tSDmCRP/9WNAQxAKeaexGoORqK9F0o7CtX7TcwqseDaNV8NhzgX/uQGGdiWa5p3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715577972; c=relaxed/simple;
	bh=h/nNwkdROHIhqlfkjh2JQ26tRYtuEy/4mF4v+a+sLKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkDksrSf3vstHax0CM+Knqmj8/TUCMW2y+WhkqBCrKe+gMs5kLS3iuNkLoBhef5aQH5GuPWn4vqtNuESiii5A9oJfV0GltYgcdQPuWuMPY2ziACvtCorC01WGLbWM7OGbFskC2dvFvpDzvsEQdAIvuAGR5QssNFbxNeu2XiDPmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59ad344f7dso795005466b.0;
        Sun, 12 May 2024 22:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715577968; x=1716182768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHLzZwQi5gHnfmzUd/O46iK9xy6a6Bk4cuL6KxXx1po=;
        b=tbFq95sSv2sjFw5DklzmRm2LYSC3m7e0+Snj9Upcm3VgDSCNdrO4TlsT+3qbMqWrKE
         O1D7eipsFKKDFSXru0vSnjoMVVk0QkrOb3TfU04Sz58ymEdcTkwTUGspXJTgd2p9G+tU
         P8ncl8TFUHpsFU1xDhyaCLTbsHoujXZA3OU5veyDbJb4gBAWVSkwzRCasVNAuRNYNZJt
         dz+KidcI0ZwB33jXkvsB5cuWEr7GQ+duCNPG0owmyv3E2N4SGn+NwNCetI6iOXPaqvZl
         cr468ztqNKsE1a52v/QGR1Z4OuF7CAiP/rrAo26VPqBvcLRS3z14q2VgFmE2w87IppcY
         x9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVnYdAox/9nf0Icl6u419fDW83mXBx1Xi1ZRMm3wewBIJd6INnhTGPtOSFirBIt3fAnu4ZJfYSLfNJhXUMfj6o+d+b/iqepFhTn3kgUMZGcXj476JCqlaPR+uYRAOs6G/nmMjVrBw/6yzBLK2ALYUFdQgEhK0wNG7InxAMa5UY3Aa5dsao8O2y2zBqqoISUtVbn9HnA4aQ6s+8+WEjsHoZGucNpNmKO5nfKcN/u6vyA+x3fW62L/Zk/
X-Gm-Message-State: AOJu0YxxiVffvhoPM6V5Ofn2NJzS+6MdiWp99q9t1AE01lRDAS/xKI+Q
	M7Q94v+I+xaAl3f4e/2B6dSjjV2K95t9Gsq6hPFhYMLn5rJtsIHlNO8xh/hf
X-Google-Smtp-Source: AGHT+IEQmj/CsAUX+RnrSsR/oOFTJkE8oGAEEKYrgMbWKGWvf2Q5jg/FggAEQ3LnT71BavYqOh1+AA==
X-Received: by 2002:a17:906:4a42:b0:a59:ae6e:486f with SMTP id a640c23a62f3a-a5a2d68098fmr526771166b.65.1715577967912;
        Sun, 12 May 2024 22:26:07 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c822fsm541509966b.138.2024.05.12.22.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 22:26:07 -0700 (PDT)
Message-ID: <1405110f-5a1b-40d5-b607-72081e5153d3@kernel.org>
Date: Mon, 13 May 2024 07:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] HID: hexLIN: Add support for USB LIN adapter
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Simon Horman <horms@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andreas Lauser <andreas.lauser@mercedes-benz.com>,
 Jonathan Corbet <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-serial <linux-serial@vger.kernel.org>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
 <20240509171736.2048414-3-christoph.fritz@hexdev.de>
 <4bf1a5e9-904c-584e-72df-71abc3f99bd2@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <4bf1a5e9-904c-584e-72df-71abc3f99bd2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10. 05. 24, 15:46, Ilpo Järvinen wrote:
>> +	reinit_completion(&priv->wait_in_report);
>> +
>> +	n = hid_hw_output_report(priv->hid_dev, (__u8 *) out_report, len);
> 
> The usual is to not leave space between cast and what is being cast. I
> know hid functions seem to use __u8 but that's intended for uapi and in
> kernel, u8 should be used (somebody should eventually cleanup the hid
> function types too).

Apart from that, you are attached to USB, so this goes down to usbhid 
(the ll driver). Are you sure the put-const-away cast is right thing to 
do here? (usbhid passes it to usb_interrupt_msg().)

That is the only reason why you have the cast in there in the first place…

regards,
-- 
js


