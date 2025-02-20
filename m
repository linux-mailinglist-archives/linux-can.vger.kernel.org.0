Return-Path: <linux-can+bounces-2895-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6530BA3DAB8
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 14:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894E8189150C
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 13:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357AF1F1508;
	Thu, 20 Feb 2025 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzMh7iYw"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2CC1EEA3E
	for <linux-can@vger.kernel.org>; Thu, 20 Feb 2025 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056647; cv=none; b=TbGgJqL/kUHY/0+w7Fq/Fa3VlSH/t+L6nSgm5+K9GDccdmdl4p/k6X+mBUJyJHp3erzWwT18PxTHd1GJuTnuUqcrHiYW0Xrgy02u9qJ+Ra+O8zO3Ram1fDbBb2ErRABtFsd9Zh3JA3LCeUejcG2DJ1L96709+nQzmcoyhlmSz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056647; c=relaxed/simple;
	bh=aSUdrIfuOrx6EneSTDQIiZHpf7Ir6iDKOScVBS0GpNo=;
	h=Message-ID:Date:MIME-Version:From:Cc:Subject:To:Content-Type; b=PCw4IfmgcGV/6GiP3B6wIiAHT+pHppcTa+/nA7Lgl/YhGG1NgvjjpzW8DOsnqvBaQZVUy8DHPKiWXw/F6NYTNGKZSDFBUOO8LH5C2Ez8oVoaXPB2Vp+IOtOdxCAyQFQ5YouoaV6WREENFFEFOXkcXZWrevdvugo9tilrdvT/HKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzMh7iYw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740056644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/JFfTVITJzszu8QzX8YlKWuo/Cf093rUYscxc6mB9lA=;
	b=NzMh7iYwW8zIDTo0Kva8J48DJsKZPpwaBRGM+bHphYFi4ptq2+cnM47mi9Z0kJD/2wC+UA
	tHjyvcrX6oteZnBtWPs0DuGoIHp2r1NXmISffwRgvriFkuVuOZMSf0C/bje/+KKuPQE3iw
	cC9wUIv92+VSzgoZ/5GydxDJM3fBB2M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-iiPYu4elMlyteesOJngoCQ-1; Thu, 20 Feb 2025 08:04:02 -0500
X-MC-Unique: iiPYu4elMlyteesOJngoCQ-1
X-Mimecast-MFC-AGG-ID: iiPYu4elMlyteesOJngoCQ_1740056641
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393e8738b3so6820085e9.0
        for <linux-can@vger.kernel.org>; Thu, 20 Feb 2025 05:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056641; x=1740661441;
        h=content-transfer-encoding:to:subject:cc:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/JFfTVITJzszu8QzX8YlKWuo/Cf093rUYscxc6mB9lA=;
        b=PbL5IugUIGC60dB7wXRBiJaMVEzBM2M4+JgJlwM40LLcX6XIdcNKjqFH6T5+hzuwyZ
         g96gXjaSVcwr5fiBfuBAI90rjHmKKwXCL1yKvWepq+p94xdr/2G68XrxYshWB5yzHmvw
         pIqIZ5R1a5yQhM+/YS+NoRvzNr45qQyf4aMudHbhk9jOt8+TRW+jcS2EimfMUUq4A/mt
         TqUV8CClXUSeLSU2fh3WzTFDt7KZglOD82Htr9KSXs2zpKgM4MjPlkByNoogbLOWfFr4
         fQutQMivFVkJXies76NcwBZNJreXZiVVObA4Ytfgfvyv2Lc3SsMQ2XICClZmtGHkjyVm
         B9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLIW033nUI+0W9ekYKQjnLC0c4EsJItd5yUyk7bKKQHsfZyHyBF0w+O4Jip5zCHf4GXOSydEqM+wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaMilIv10gxL9ZNe4jGPkY3B6Pwnp7cbLu6htoCajxsrJjip7X
	mg2Gjy++79RDiPc2Mgcv4jzE80ELEoWAOBkE95V6cT2EDmG9ikyJvpzrK61e5ndwK+mimCWG3AH
	1Wa9SWURVrU1KTp2Or1N1oMRSJz88dJgAakXfn0MWUd+HmwpkAP2/4988AA==
X-Gm-Gg: ASbGncuXTbkcXOX0yzapLgtUaUubxZf2bdGrHPpSOF6g6AXa29OOyK4yO9XxaSF/5Pa
	VZ5ITmnF7/9gLLQJ2RbvcnG3mIljtZSpS0EewfM0w5K6tiJQavQD+asSvYOL/v6vYI35R30Kpq/
	PPkXeRQQkQvq8G+/OCdMjbvrJKA7QcRH+FBJzYJsYR+Zh8nL0jwxBNx1uLQw9mkYhCo0D1yMNw8
	Wryl5CUmdZKtH0rx6mtMJOua03nI5VP/PqSha/AzwIm9qmQHQQRoslKHhpnoQnzPSSrem8LPk9B
	jbwgS3LsJwUUnSkJ8Fw8TohGuBJeW4h7UoXtPX0KZtrRobbPDu0+17AmBUM9uKrhH+vhSxUzf3M
	tYrXzlMgfoZO1yJy5/cacDoKa1d0hNMvIFg==
X-Received: by 2002:a05:600c:4590:b0:439:6101:5440 with SMTP id 5b1f17b1804b1-43999d8aa16mr72802615e9.8.1740056639855;
        Thu, 20 Feb 2025 05:03:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH6N8f3X7sPOmC3OMG8mB+QpXsend7nrbtp5KEqmX4km74HqEewfzyfOfvKu+QM9WV0uuzsw==
X-Received: by 2002:a05:600c:4590:b0:439:6101:5440 with SMTP id 5b1f17b1804b1-43999d8aa16mr72802045e9.8.1740056639449;
        Thu, 20 Feb 2025 05:03:59 -0800 (PST)
Received: from ?IPV6:2003:cc:9f32:6bf1:ca16:f6b0:a8c9:60d5? (p200300cc9f326bf1ca16f6b0a8c960d5.dip0.t-ipconnect.de. [2003:cc:9f32:6bf1:ca16:f6b0:a8c9:60d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25913f5asm20890194f8f.52.2025.02.20.05.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:03:59 -0800 (PST)
Message-ID: <0feda774-853b-42c3-8bae-5d84f7881171@redhat.com>
Date: Thu, 20 Feb 2025 14:03:57 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
Cc: Davide Caratti <dcaratti@redhat.com>,
 Filippo Storniolo <fstornio@redhat.com>
Subject: Advancing the testing for the CAN subsystem
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Marc, Oliver, and linux-can community,

we are reaching out to you because we would like to advance the testing
of the kernel CAN subsystem. We, that's Davide, Filippo and I, are
volunteering to provide the patches for this, but would like to get your
feedback and opinions first.

We know about the can-tests repository[1] and think this is a good
starting point for our efforts. Currently, there are two main activities
we'd like to do:

- Promote the test cases in can-tests to become part of the kernel
selftests: This would mainly get the tests closer to the upstream kernel
development, both in terms of maintenance and actually running them. CI
systems like LKFT and CKI could easily be continuously running the
tests. The downside is that existing automation depending on can-tests
(which we don't know about) would need to be modified.
- Extend the coverage of the tests: This could include testing for,
e.g., vcan, vxcan, and the cangw netlink interface. But we're open to
feedback here if you see any pressing areas.

Like I stated in the beginning, this message should get the discussion
started and we are looking forward to your feedback or concerns on these
ideas.

Thanks,
   Felix


[1]: https://github.com/linux-can/can-tests


