Return-Path: <linux-can+bounces-4067-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D5DB0F268
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 14:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB743BAF17
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE026C3BD;
	Wed, 23 Jul 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hXWHm5PW"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C3248F69
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274283; cv=none; b=mJND5MvdrmijwGcqsqE35++trlq5jE7w2feQ/uX061I+IaKhUsvd8I5Qj8ZyUIg/7Ufhh3e0Kg2qFNI8PimpZsJpUxiPkUtsjG5WRptJyArGH4cfXTO55f6xJsrsxnfHsCmIlnx2Ot4tvQGI6/s0zSUeKZIjmjkkSDYeJyuNHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274283; c=relaxed/simple;
	bh=DlMaPAjQ3909nnlHnCSNwa+yNwblSTsqC2m7PHQ40rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQH1XSJ+T6e6H5ggCdfb49gmdL3Y48YzGRMVxNIw75xfuDi81N3e9aE1KfI3SA6iX8u/uEEjkxEuOC5369Xo6ec3m/LmhDEw8smvrB8+fn5L99Pp6gfvzYuNtKUa/ySBQE8EYZN7ZgCZG8iQM4PLOHS6DF1ANov+0hu+KOSrgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hXWHm5PW; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eYjLu5Cbw7oQQeYjMuCYQh; Wed, 23 Jul 2025 14:37:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753274278;
	bh=DlMaPAjQ3909nnlHnCSNwa+yNwblSTsqC2m7PHQ40rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hXWHm5PW7Bem79bno+NbJkuemxQ0kG1EVPF97jtPTbicDUIvuGDEI0ESOMZn7NORO
	 6/bPz6szGSn4E8ZFRKdxzESquWLRf89d7LTtsB3PHzdnsqjxFWp9OMu2Ms9CXw2u2K
	 BkSSU3CUYQKew5KK5yDyPxMatMlJpVil1DbxQO2NTco+qubGNsKy99T2jyjPs9l6qm
	 O3TWtOFET2DssRRlIGp2NOlJXb5OauXHSRVM8GXf/w+xHyoqzVUf4U6kGVk9hSLfdH
	 31oB25FzX20qIEgha2nwRX3o4IXWfRsHm/JWWihZW1CMj0L1LVlI8adV7jwmgfK/l0
	 0wjTP4mlJTWNw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jul 2025 14:37:58 +0200
X-ME-IP: 124.33.176.97
Message-ID: <cbdacb19-4f27-458b-937a-8796c8ebd706@wanadoo.fr>
Date: Wed, 23 Jul 2025 21:37:55 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] can: kvaser_pciefd: Simplify identification of
 physical CAN interfaces
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250723083236.9-1-extja@kvaser.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250723083236.9-1-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 at 17:32, Jimmy Assarsson wrote:
> This patch series simplifies the process of identifying which network
> interface (can0..canX) corresponds to which physical CAN channel on
> Kvaser PCIe based CAN interfaces.

I completed my review.

My only real concern is on patch 5 where you are using the dev_id instead of the
dev_port.

My other comments are all nitpicks. If you have a strong opinion, I am actually
fine if you keep things as they are. No need to argue on these :)


Yours sincerely,
Vincent Mailhol


