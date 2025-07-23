Return-Path: <linux-can+bounces-4068-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B765B0F27B
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 14:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89453AA8003
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FAC2E6113;
	Wed, 23 Jul 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ws9qnsJp"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A65210F4A
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274661; cv=none; b=a0e1JWfDxwaWDR/9VfuQDiHo7vAs8/dx9qbEK63MQ8EKTnp84zHbCRlp2OfkgToCMCmvtsAEEkpvxvCZz8HmXAycs/E0YTZJDU4PunqmjgdRWhc1mQzBQKltEmoSXAOBAtccRak8Vep1J0hrIgsmZlp1+pzLe08qW/w+vw+Wosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274661; c=relaxed/simple;
	bh=aU93mfWw6kA1fFz1KMN8sakBc6oHdD91SqM8F56j9iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imerwZrw2w4NqQviVsJx5v4eBIn2E87WY9t5yG0LXnyqCG88JOrPeHPObuv+VDT+V72UwTsGC3VY2xxa0JLZOBuBUzGSfsFnhSRlBqyrIj7XqBrfEMU86VRUYOv+70OSyvzYmRff4f/RZoiKJOXdfcM7ZFss2ZIr09x+NmoHCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ws9qnsJp; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eYpQu1OrzZLLzeYpRuJMBd; Wed, 23 Jul 2025 14:44:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753274656;
	bh=aONn4UQtvVQm9ayt6lKOS/Ae8m0hQOzsObEmSIzEyps=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Ws9qnsJpIrEkyMTHUJ5whUbovlOhuual6N1YM0K5Zjkxm1QtovbX1Yna5+g6ONjpJ
	 aX/FdB9pgndRwdomAT0RMoS8e72qehMjOsTW+n9hGVqOec/3RxMPR+7tEnYBQ50zUW
	 Gw0YYH9jR8ls8CdthhwbE+rcj6Q5AFcWn/3X68b4LCCV5/am6zfrGciM19PTpPugi2
	 4qLxoYWzlrDeLxeiMsllPG0UWmWC37QrdSiSH81vFMzEKSml6hEXcNK9ZSb0HCdQ4I
	 nqp57ao+CgfyLymSWDShSw85lQ9scBIgzsu1T6y2Tf92pDTTqodJfZbIUkh+PNTXLT
	 0Tr3JF4MW3tlA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jul 2025 14:44:16 +0200
X-ME-IP: 124.33.176.97
Message-ID: <5cdca1d7-c875-40ee-b44d-51a161f42761@wanadoo.fr>
Date: Wed, 23 Jul 2025 21:44:11 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] can: kvaser_usb: Simplify identification of physical
 CAN interfaces
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250723083508.40-1-extja@kvaser.com>
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
In-Reply-To: <20250723083508.40-1-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 at 17:34, Jimmy Assarsson wrote:
> This patch series simplifies the process of identifying which network
> interface (can0..canX) corresponds to which physical CAN channel on
> Kvaser USB based CAN interfaces.

This series mirrors the kvaser_pciefd one, so I will not repeat the same comment
twice. I let you manage it directly :)

One last comment for both the kvaser_pciefd and the kvaser_usb: you may want to
add an entry to the devlink documentation. Something like this:

  - https://git.kernel.org/torvalds/c/9f63f96aac92
  - https://git.kernel.org/torvalds/c/115dd5469019

Yours sincerely,
Vincent Mailhol


